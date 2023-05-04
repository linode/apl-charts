{{/*
Expand the name of the chart.
*/}}
{{- define "deployment.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "deployment.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "deployment.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "deployment.labels" -}}
helm.sh/chart: {{ include "deployment.chart" . }}
{{ include "deployment.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deployment.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "deployment.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "deployment.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "helm-toolkit.utils.joinListWithSep" -}}
{{- $local := dict "first" true -}}
{{- $ := . -}}
{{- range $k, $v := .list -}}{{- if not $local.first -}}{{ $.sep }}{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}

{{- define "flatten-name" -}}
{{- $res := regexReplaceAll "[()/_-]{1}" . "" -}}
{{- regexReplaceAll "[|.]{1}" $res "-" | trimAll "-" | lower -}}
{{- end -}}

{{/* aggregate all the files and create a dict by dirname > list (filename content) */}}
{{- define "file-volumes" }}
{{- $vols := dict }}
{{- range $location, $content := . }}
  {{- $dir := $location | dir }}
  {{- $file := $location | base }}
  {{- $fileContent := (dict "name" $file "content" $content) }}
  {{- $files := list }}
  {{- if hasKey $vols $dir }}
    {{- $files = (index $vols $dir) }}
  {{- end }}
  {{- $files = append $files $fileContent }}
  {{- $vols = set $vols $dir $files }}
{{- end }}  
{{- range $dir, $files := $vols }}
{{ $dir }}: {{- $files | toYaml | nindent 2 }}
{{- end }}
{{- end }}

{{- define "podspec" }}
{{- $name := (include "deployment.fullname" .) }}
{{- $serviceAccountName := (include "deployment.serviceAccountName" .) }}
{{- with .Values }}
{{- with .imagePullSecrets }}
imagePullSecrets: {{- toYaml . | nindent 2 }}
{{- end }}
serviceAccountName: {{ $serviceAccountName }}
{{- if (ne .type "ksvc") }}
securityContext: {{- toYaml .podSecurityContext | nindent 2 }}
{{- end }}
containers:
  - name: {{ $name }}
    image: {{ .image.repository }}:{{ .image.tag }}
    imagePullPolicy: {{ .image.pullPolicy }}
    {{- with .command }}
    command: {{ . | toYaml | nindent 12 }}
    {{- end }}
    ports:
      - containerPort: {{ .service.containerPort }}
        protocol: TCP
        {{- if ne .type "ksvc" }}
        name: http
        {{- end }}
    {{- with .args }}
    args: {{ . | toYaml | nindent 12 }}
    {{- end }}
    {{- with .env }}
    env:
      {{- range $key, $value := . }}
      - name: {{ $key }}
        value: {{ $value | quote }}
      {{- end }}
    {{- end }}
    {{- with .secrets }}
    envFrom:
      {{- range $secretName := (. | default list) }} 
      - secretRef:
          name: {{ $secretName }}
      {{- end }}
    {{- end }}
    livenessProbe:
      {{- if .livenessProbe }}
      {{- toYaml .livenessProbe | nindent 6 }}
      {{- else }}
      httpGet:
        path: /
        port: http
      {{- end }}
    readinessProbe:
      {{- if .readinessProbe }}
      {{- toYaml .livenessProbe | nindent 6 }}
      {{- else }}
      httpGet:
        path: /
        port: http
      {{- end }}
    {{- with .resources }}
    resources: {{- . | toYaml | nindent 6 }}
    {{- end }}
    {{- with .securityContext }}
    securityContext: {{- . | toYaml | nindent 6 }}
    {{- end }}
    {{- with .nodeSelector }}
    nodeSelector: {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- with .affinity }}
    affinity: {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- with .tolerations }}
    tolerations: {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- if or .files .secretMounts }}
    {{- $vols := include "file-volumes" .files | fromYaml }}
    volumeMounts:
      {{- range $dir, $files := $vols }}
      - name: {{ $name }}-{{ include "flatten-name" $dir }}
        mountPath: {{ $dir }}
        readOnly: true
      {{- end }}
      {{- range $location, $secret := .secretMounts }}
      - name: {{ $name }}-{{ include "flatten-name" $location }}
        mountPath: {{ $location | dir }}
        subPath: {{ $location | base }}
        readOnly: true
      {{- end }}
volumes:
      {{- range $dir, $files := $vols }}
  - name: {{ $name }}-{{ include "flatten-name" $dir }}
    configMap:
      name: {{ $name }}-{{ include "flatten-name" $dir }}
      items:
        {{- range $fileContent := $files }}
        - key: {{ $fileContent.name }}
          path: {{ $fileContent.name }}
        {{- end }}
      {{- end }}
      {{- range $location, $secret := .secretMounts }}
  - name: {{ $name }}-{{ include "flatten-name" $location }}
    secret:
      secretName: {{ $secret }}
      {{- end }}
    {{- end }}
{{- end }}
{{- end }}
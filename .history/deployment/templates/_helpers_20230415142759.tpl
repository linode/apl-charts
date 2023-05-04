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
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "deployment.fullname" . }}
app.kubernetes.io/owner: {{ .Release.Namespace }}
otomi.io/app: {{ include "deployment.fullname" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "deployment.selectorLabels" -}}
app.kubernetes.io/name: {{ include "deployment.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "deployment.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hello-world.fullname" .) .Values.serviceAccount.name }}
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

{{- define "volumeMounts" }}
{{- $name := (include "deployment.fullname" .) }}
{{- with .Values }}
{{- if or .files .secretMounts }}
{{- $vols := include "file-volumes" .files | fromYaml }}
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
{{- end }}
{{- end }}
{{- end }}

{{- define "volumes" }}
{{- $name := (include "deployment.fullname" .) }}
{{- with .Values }}
{{- if or .files .secretMounts }}
{{- $vols := include "file-volumes" .files | fromYaml }}
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

{{- define "envFrom" }}
{{- range $secretName := (. | default list) }} 
- secretRef:
    name: {{ $secretName }}
{{- end }}
{{- end }}


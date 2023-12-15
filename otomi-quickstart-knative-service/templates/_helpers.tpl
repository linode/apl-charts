{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "otomi-quickstart-knative-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ksvc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ksvc.labels" -}}
helm.sh/chart: {{ include "ksvc.chart" . }}
{{ include "ksvc.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "otomi-quickstart-knative-service.fullname" . }}
app.kubernetes.io/owner: {{ .Release.Namespace }}
otomi.io/app: {{ include "otomi-quickstart-knative-service.fullname" . }}
otomi.io/team: {{ .Release.Namespace }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ksvc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "otomi-quickstart-knative-service.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "envFrom" }}
{{- range $secretName := (. | default list) }}
- secretRef:
    name: {{ $secretName }}
{{- end }}
{{- end }}
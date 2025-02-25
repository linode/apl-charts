{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "inferenceService.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "inferenceService.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "inferenceService.labels" -}}
helm.sh/chart: {{ include "inferenceService.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "inferenceService.fullname" . }}
app.kubernetes.io/owner: {{ .Release.Namespace }}
otomi.io/app: {{ include "inferenceService.fullname" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "inferenceService.selectorLabels" -}}
app.kubernetes.io/name: {{ include "inferenceService.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

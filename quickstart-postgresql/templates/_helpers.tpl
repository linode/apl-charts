{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "postgresql.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "postgresql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "postgresql.labels" -}}
helm.sh/chart: {{ include "postgresql.chart" . }}
{{ include "postgresql.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "postgresql.fullname" . }}
app.kubernetes.io/owner: {{ .Release.Namespace }}
otomi.io/app: {{ include "postgresql.fullname" . }}
{{- end }}

{{/*
Dashboard labels
*/}}
{{- define "postgresql.dbLabels" -}}
{{ include "postgresql.labels" . }}
grafana_dashboard: "1"
release: grafana-dashboards-{{ .Release.Namespace | trimPrefix "team-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "postgresql.selectorLabels" -}}
cnpg.io/cluster: {{ include "postgresql.fullname" . }}
{{- end }}

{{- define "envFrom" }}
{{- range $secretName := (. | default list) }}
- secretRef:
    name: {{ $secretName }}
{{- end }}
{{- end }}
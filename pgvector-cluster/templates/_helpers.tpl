{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pgvector.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pgvector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pgvector.labels" -}}
helm.sh/chart: {{ include "pgvector.chart" . }}
{{ include "pgvector.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "pgvector.fullname" . }}
app.kubernetes.io/owner: {{ .Release.Namespace }}
otomi.io/app: {{ include "pgvector.fullname" . }}
apl.akamai.com/purpose: knowledge-base
apl.akamai.com/workload-type: ai-ml
{{- end }}

{{/*
Dashboard labels
*/}}
{{- define "pgvector.dbLabels" -}}
{{ include "pgvector.labels" . }}
grafana_dashboard: "1"
release: grafana-dashboards-{{ .Release.Namespace | trimPrefix "team-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pgvector.selectorLabels" -}}
cnpg.io/cluster: {{ include "pgvector.fullname" . }}
{{- end }}

{{- define "envFrom" }}
{{- range $secretName := (. | default list) }}
- secretRef:
    name: {{ $secretName }}
{{- end }}
{{- end }}

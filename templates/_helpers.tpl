{{/*
Expand the name of the chart.
*/}}
{{- define "carsharing-helm-charts.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "carsharing-helm-charts.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "carsharing-helm-charts.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "carsharing-helm-charts.labels" -}}
helm.sh/chart: {{ include "carsharing-helm-charts.chart" . }}
{{ include "carsharing-helm-charts.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "carsharing-helm-charts.selectorLabels" -}}
app.kubernetes.io/name: {{ include "carsharing-helm-charts.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the nginx service account to use
*/}}
{{- define "carsharing-helm-charts.serviceAccountName" -}}
{{- if .Values.nginx.serviceAccount.create }}
{{- default (include "carsharing-helm-charts.fullname" .) .Values.nginx.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.nginx.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name of the nodeapi secret account to use
*/}}
{{- define "carsharing-helm-charts.secretName" -}}
{{- if .Values.nodeapi.secret.create }}
{{- default (include "carsharing-helm-charts.fullname" .) .Values.nodeapi.secret.name }}
{{- else }}
{{- default "default" .Values.nodeapi.secret.name }}
{{- end }}
{{- end }}

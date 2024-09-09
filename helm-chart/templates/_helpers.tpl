{{/*
Expand the name of the chart.
*/}}
{{- define "unnamed.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "unnamed.fullname" -}}
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
{{- define "unnamed.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "unnamed.labels" -}}
helm.sh/chart: {{ include "unnamed.chart" . }}
{{ include "unnamed.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "unnamed.selectorLabels" -}}
app.kubernetes.io/name: {{ include "unnamed.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "unnamed.toYamlRecursive" -}}
{{- range $key, $value := . }}
  {{- if kindIs "map" $value }}
    {{ $key }}:
{{- include "unnamed.toYamlRecursive" $value | indent 2 }}
  {{- else if or (kindIs "array" $value) (kindIs "slice" $value) }}
    {{ $key }}:
{{- range $item := $value }}
      - {{ $item }}
{{- end }}
  {{- else }}
    {{ $key }}: {{ $value }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Adds quotes to each element of a list and returns them as x1 x2 ...
*/}}
{{- define "quoteList" -}}
{{- $out := list -}}
{{- range $index, $element := . -}}
{{- $out = append $out (printf "%q" $element) -}}
{{- end -}}
{{- $out | join " " -}}
{{- end -}}

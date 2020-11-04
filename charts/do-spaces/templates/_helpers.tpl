{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "do-spaces.name" }}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this
(by the DNS naming spec).
*/}}
{{- define "do-spaces.fullname" }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Calculate do spaces certificate
*/}}
{{- define "do-spaces.do-spaces-certificate" }}
{{- if (not (empty .Values.ingress.doSpaces.certificate)) }}
{{- printf .Values.ingress.doSpaces.certificate }}
{{- else }}
{{- printf "%s-do-spaces-letsencrypt" (include "do-spaces.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Calculate do spaces hostname
*/}}
{{- define "do-spaces.do-spaces-hostname" }}
{{- if (and .Values.config.doSpaces.hostname (not (empty .Values.config.doSpaces.hostname))) }}
{{- printf .Values.config.doSpaces.hostname }}
{{- else }}
{{- if .Values.ingress.doSpaces.enabled }}
{{- printf .Values.ingress.doSpaces.hostname }}
{{- else }}
{{- printf "%s-do-spaces" (include "do-spaces.fullname" .) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Calculate do spaces base url
*/}}
{{- define "do-spaces.do-spaces-base-url" }}
{{- if (and .Values.config.doSpaces.baseUrl (not (empty .Values.config.doSpaces.baseUrl))) }}
{{- printf .Values.config.doSpaces.baseUrl }}
{{- else }}
{{- if .Values.ingress.doSpaces.enabled }}
{{- $hostname := ((empty (include "do-spaces.do-spaces-hostname" .)) | ternary .Values.ingress.doSpaces.hostname (include "do-spaces.do-spaces-hostname" .)) }}
{{- $protocol := (.Values.ingress.doSpaces.tls | ternary "https" "http") }}
{{- printf "%s://%s" $protocol $hostname }}
{{- else }}
{{- printf "http://%s" (include "do-spaces.do-spaces-hostname" .) }}
{{- end }}
{{- end }}
{{- end }}

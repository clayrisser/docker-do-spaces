FROM nginx:1.19.3-alpine

LABEL image=codejamninja/nginx:latest \
  maintainer="Jam Risser <jam@codejam.ninja>" \
  base=alpine:3.9

RUN apk add --no-cache \
  tini
RUN wget -O /usr/local/bin/confd \
  https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 && \
  chmod +x /usr/local/bin/confd

COPY entrypoint.sh /usr/local/sbin/entrypoint.sh
COPY nginx.conf.tmpl /etc/confd/templates/nginx.conf.tmpl
COPY nginx.toml /etc/confd/conf.d/nginx.toml

RUN chmod +x /usr/local/sbin/entrypoint.sh

WORKDIR /opt/app

EXPOSE 8080

ENV \
  BUCKET="" \
  ENDPOINT=sfo2.digitaloceanspaces.com \
  PORT=8080 \
  PREFIX=""

ENTRYPOINT ["/bin/sh", "/usr/local/sbin/entrypoint.sh"]

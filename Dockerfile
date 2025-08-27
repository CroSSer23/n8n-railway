FROM node:22-alpine
ARG N8N_VERSION=1.109.0

RUN apk add --no-cache graphicsmagick tzdata \
 && apk add --no-cache --virtual build-dependencies python3 build-base \
 && npm_config_user=root npm i -g n8n@${N8N_VERSION} \
 && apk del build-dependencies

WORKDIR /data
ENV N8N_USER_ID=root
EXPOSE 8080

# Печатаем важные env и жёстко слушаем $PORT на 0.0.0.0
CMD ["sh","-lc","echo Effective PORT=${PORT} ; env | grep -E '^(N8N_|DB_|PORT=)' || true ; n8n start --port ${PORT} --host 0.0.0.0"]

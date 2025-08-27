FROM node:22-alpine
ARG N8N_VERSION=1.109.0

RUN apk add --no-cache graphicsmagick tzdata \
 && apk add --no-cache --virtual build-dependencies python3 build-base \
 && npm_config_user=root npm i -g n8n@${N8N_VERSION} \
 && apk del build-dependencies

WORKDIR /data
ENV N8N_USER_ID=root
# EXPOSE информативен, на работу не влияет. Можно оставить 8080.
EXPOSE 8080

# Критично: слушать именно $PORT от Railway и на 0.0.0.0
CMD ["sh","-lc","echo Starting n8n on PORT=${PORT} && n8n start --port ${PORT} --host 0.0.0.0"]

FROM node:22-alpine
ARG N8N_VERSION=1.109.0

RUN apk add --update graphicsmagick tzdata
RUN apk --update add --virtual build-dependencies python3 build-base && \
    npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
    apk del build-dependencies

WORKDIR /data
ENV N8N_USER_ID=root
# EXPOSE можно оставить, но числом; это лишь декларация для людей/инструментов
EXPOSE 8080

# Критично: слушать именно $PORT, которое задаёт Railway (часто 8080, но бывает другое)
CMD ["sh","-lc","n8n start --port ${PORT:-8080}"]

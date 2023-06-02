# For development
FROM node:18.15-buster-slim as development

COPY ./docker-entrypoint /docker-entrypoint
WORKDIR /usr/src/app/myapp
ENV WATCHPACK_POLLING=true
ENV NODE_ENV development

COPY ./myapp/package*.json ./
RUN npm install
COPY ./myapp .

ENTRYPOINT [ "/docker-entrypoint" ]

# For build
FROM node:18.15-buster-slim as build
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci -omit=dev
COPY ./myapp .
RUN npm run build

# For staging
FROM gcr.io/distroless/nodejs18-debian11:nonroot as staging
WORKDIR /app
ENV NODE_ENV production
ENV HOST 0.0.0.0

COPY --from=build --chown=nonroot:nonroot /app/.output /app/.output

USER nonroot
EXPOSE 3000

CMD [ "/app/.output/server/index.mjs" ]

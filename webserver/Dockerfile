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


# dependent packages
FROM node:18.15-buster-slim as dependent
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci --only=production

# For build
FROM node:18.15-buster-slim as build
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci
COPY ./myapp .
RUN npm run build --spa

# For staging
FROM gcr.io/distroless/nodejs18-debian11:nonroot as staging
WORKDIR /app
ENV NODE_ENV production

COPY --from=build /app/public /app/public
COPY --from=build --chown=nonroot:nonroot /app/.nuxt/dist /app/dist
COPY --from=dependent /app/node_modules ./node_modules
COPY ./myapp/package*.json ./

USER nonroot
EXPOSE 3000
CMD [ "node_modules/.bin/nuxt", "start" ]

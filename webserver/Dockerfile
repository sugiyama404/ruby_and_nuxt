# For Development
FROM node:18.15-buster-slim as Development

WORKDIR /usr/src/app/myapp
COPY ./myapp .
RUN npm install

# Dependent packages
FROM node:18.15-buster-slim as Dependent
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci --only=production

# For Build
FROM node:18.15-buster-slim as Build
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci
COPY ./myapp .
RUN npm run build --spa

# For Staging
FROM gcr.io/distroless/nodejs18-debian11:nonroot as Staging
WORKDIR /app
ENV NODE_ENV production

COPY --from=Build /app/public /app/public
COPY --from=Build --chown=nonroot:nonroot /app/.nuxt/dist /app/dist
COPY --from=Dependent /app/node_modules ./node_modules
COPY ./myapp/package*.json ./

USER nonroot
EXPOSE 3000
CMD [ "node_modules/.bin/nuxt", "start" ]

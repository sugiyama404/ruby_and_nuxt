<<<<<<< HEAD
# For development
FROM node:18.15-buster-slim as development
=======
# For Development
FROM node:18.15-buster-slim as Development
>>>>>>> origin/main

WORKDIR /usr/src/app/myapp
COPY ./myapp .
RUN npm install

<<<<<<< HEAD
# dependent packages
FROM node:18.15-buster-slim as dependent
=======
# Dependent packages
FROM node:18.15-buster-slim as Dependent
>>>>>>> origin/main
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci --only=production

<<<<<<< HEAD
# For build
FROM node:18.15-buster-slim as build
=======
# For Build
FROM node:18.15-buster-slim as Build
>>>>>>> origin/main
WORKDIR /app
COPY ./myapp/package*.json ./
RUN npm ci
COPY ./myapp .
RUN npm run build --spa

<<<<<<< HEAD
# For staging
FROM gcr.io/distroless/nodejs18-debian11:nonroot as staging
WORKDIR /app
ENV NODE_ENV production

COPY --from=build /app/public /app/public
COPY --from=build --chown=nonroot:nonroot /app/.nuxt/dist /app/dist
COPY --from=dependent /app/node_modules ./node_modules
=======
# For Staging
FROM gcr.io/distroless/nodejs18-debian11:nonroot as Staging
WORKDIR /app
ENV NODE_ENV production

COPY --from=Build /app/public /app/public
COPY --from=Build --chown=nonroot:nonroot /app/.nuxt/dist /app/dist
COPY --from=Dependent /app/node_modules ./node_modules
>>>>>>> origin/main
COPY ./myapp/package*.json ./

USER nonroot
EXPOSE 3000
CMD [ "node_modules/.bin/nuxt", "start" ]

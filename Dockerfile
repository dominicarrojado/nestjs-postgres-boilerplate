# syntax=docker/dockerfile:1

FROM node:16.14.2-alpine AS base

WORKDIR /app

COPY [ "package.json", "yarn.lock*", "./" ]

FROM base AS dev
ENV NODE_ENV=dev
RUN yarn install --frozen-lockfile
COPY . .
CMD [ "yarn", "start:dev" ]

FROM base AS prod
ENV NODE_ENV=production
RUN yarn install --frozen-lockfile --production
COPY . .
RUN yarn global add @nestjs/cli
RUN yarn build
CMD [ "yarn", "start:prod" ]
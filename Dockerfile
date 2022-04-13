
# syntax=docker/dockerfile:1

FROM node:16.14.2-alpine
ENV NODE_ENV=production

WORKDIR /app

COPY [ "package.json", "yarn.lock*", "./" ]

RUN yarn install --frozen-lockfile --production

COPY . .

RUN yarn global add @nestjs/cli
RUN yarn build

CMD [ "yarn", "start:prod" ]
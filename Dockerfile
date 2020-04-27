FROM xrayray/nodejs-sceptre:v1.13 as base

RUN mkdir /app
WORKDIR /app

COPY package*.json /app/
RUN npm ci

COPY . /app/

CMD ["npm", "start"]

########################################
FROM base as prod

ENV NODE_ENV=production

RUN npm run build

CMD ["npm", "run", "server"]
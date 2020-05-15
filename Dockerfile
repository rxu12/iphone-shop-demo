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


# Set up SSH access to the container
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update \
  && apt-get install -y --no-install-recommends openssh-server \
  && echo "$SSH_PASSWD" | chpasswd

EXPOSE 8000 2222

CMD ["npm", "run", "server"]
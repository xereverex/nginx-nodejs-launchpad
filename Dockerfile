FROM nginx:1.17

RUN apt-get update \
 && apt-get install -y \
    git \
    curl \
    gnupg \
    gcc \
    g++ \
    make \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y nodejs npm\
 && rm -rf /var/lib/apt/lists/*

COPY ./default.conf /etc/nginx/conf.d/default.conf

# UPPER should be moved to base image

WORKDIR /app

ONBUILD ARG folder

ONBUILD ARG commit_hash

ONBUILD COPY ./${folder}/package.json /app

ONBUILD COPY ./shared-components /shared-components

ONBUILD RUN npm install --unsafe-perm

ONBUILD COPY ./${folder} /app

ONBUILD RUN COMMIT_HASH=${commit_hash} npm run build

ONBUILD RUN rm -rf node_modules

ONBUILD RUN npm install

ONBUILD RUN mv /app/public/* /usr/share/nginx/html

EXPOSE 80
ENTRYPOINT nginx; npm run server

FROM nginx:1.17

RUN apt-get update \
 && apt-get install -y \
    git \
    curl \
    gnupg \
    gcc \
    g++ \
    make \
    nodejs-dev \ 
    node-gyp \
    libssl1.0-dev \
 && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
 && apt-get install -y nodejs npm\
 && rm -rf /var/lib/apt/lists/*

COPY ./default.conf /etc/nginx/conf.d/default.conf

FROM     ubuntu:17.10

MAINTAINER Elie <contact [at] eliesauveterre [dot] com>

ENV IONIC_VERSION=3.20.1 \
	NODEJS_VERSION=8.15.0 \
	CORDOVA_VERSION=7.0.1 \
	NPM_VERSION=6.7.0 \
	PATH=$PATH:/opt/node/bin

# Install nodejs	& requirements

WORKDIR "/opt/node"

RUN apt-get update && apt-get install -y curl ca-certificates git wget unzip libfontconfig bzip2 \
    gcc make g++ --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1

# Instal Ionic
RUN	npm i -g --unsafe-perm npm@${NPM_VERSION} cordova@${CORDOVA_VERSION} ionic@${IONIC_VERSION}

# Install typings
RUN npm install -g typings

# Install Sass
RUN apt-get install -y ruby-full rubygems ruby-dev libffi-dev
RUN gem install sass

### Clean
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/*

WORKDIR "/app"

EXPOSE 8100 35729

CMD ["ionic", "serve"]
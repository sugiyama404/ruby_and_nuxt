FROM ruby:3.1.3-slim-buster

WORKDIR /usr/src

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    g++=4:8.3.0-1 make=4.2.1-1.2 \
    libmariadb-dev=1:10.3.38-0+deb10u1 \
    git=1:2.20.1-2+deb10u8 \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

COPY . .
WORKDIR /usr/src/app
RUN bundle install

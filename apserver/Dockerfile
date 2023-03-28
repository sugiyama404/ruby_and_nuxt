FROM ruby:3.1.3-slim-buster

WORKDIR /usr/src

ENV HOST dbserver
ENV DBNAME todoproject
ENV USERNAME rubyMySql1
ENV PASSWORD rubyMySql1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    g++=4:8.3.0-1 make=4.2.1-1.2 \
    libmariadb-dev=1:10.3.38-0+deb10u1 \
    mariadb-client=1:10.3.38-0+deb10u1 \
    git=1:2.20.1-2+deb10u8 \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

COPY . .
WORKDIR /usr/src/app
RUN bundle install

EXPOSE 8080

CMD ["rails", "s", "-b", "0.0.0.0","-p", "8080"]


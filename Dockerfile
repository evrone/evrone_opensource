FROM ruby:2.7.1-alpine

WORKDIR /srv/app

# install dependencies for
# nokogiri, pg, pzinfo-data, webpack
RUN apk add --no-cache \
        build-base \
        postgresql-dev \
        tzdata \
        nodejs yarn

COPY Gemfile* ./

RUN bundle install

COPY . .

FROM ruby:2.7.1-alpine

WORKDIR /srv/app

# install dependencies for
# nokogiri, pg, pzinfo-data, webpack
RUN apk add --update --no-cache \
        build-base \
        postgresql-dev \
        tzdata \
        nodejs yarn

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

RUN rails webpacker:compile

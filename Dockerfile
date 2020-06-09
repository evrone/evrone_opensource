FROM ruby:2.7.1-alpine

WORKDIR /srv/app

# install dependencies for
# nokogiri, pg, pzinfo-data, webpack
RUN apk add --update --no-cache \
        build-base \
        postgresql-dev \
        tzdata \
        nodejs yarn \
        git

COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

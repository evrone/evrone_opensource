FROM ruby:2.7.1-alpine

WORKDIR /srv/app

RUN apk add --no-cache \
        build-base \ # gem nokogiri
        postgresql-dev \ # gem pg
        tzdata \ # gem tzinfo-data
        nodejs yarn # webpack


FROM ruby:2.6-alpine

# Install important dependencies
RUN apk add build-base nodejs yarn tzdata sqlite-dev postgresql-client postgresql-dev python imagemagick 

RUN gem install bundler -v 1.16.1
RUN gem install rails -v '5.2.3'

RUN mkdir -p /myapp && chmod -R 777 /myapp
WORKDIR /myapp

COPY Gemfile* /myapp/

RUN bundle install

COPY . /myapp/

RUN chmod -R 777 /myapp

ENV RAILS_ENV development
ENV SECRET_KEY_BASE 123456789
#ENV GOOGLE_CREDENTIALS 

RUN bin/rails assets:precompile

ENTRYPOINT rails s -b 0.0.0.0

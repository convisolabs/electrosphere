FROM ruby:2.5-alpine

RUN apk update
RUN apk add build-base

WORKDIR /electrosphere

COPY /templates /electrosphere/templates
COPY /core.rb /electrosphere/core.rb
COPY /graphql_build.rb /electrosphere/graphql_build.rb
COPY /reporter.rb /electrosphere/reporter.rb
COPY /opt_parser.rb /electrosphere/opt_parser.rb
COPY /printer.rb /electrosphere/printer.rb
COPY /Gemfile /electrosphere/Gemfile
COPY /start.rb /electrosphere/start.rb
RUN bundle install

ENTRYPOINT ["ruby", "/electrosphere/start.rb"]

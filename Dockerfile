FROM ruby:2.4.0

MAINTAINER Leonardo Tegon <ltegon93@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /shorty

WORKDIR /shorty

ADD Gemfile /shorty/Gemfile

ADD Gemfile.lock /shorty/Gemfile.lock

RUN bundle install

ADD . /shorty

CMD [ "bundle", "exec", "puma", "config.ru" ]

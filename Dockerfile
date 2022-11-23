FROM ruby:2.3.5

WORKDIR /usr/src/app

RUN gem install bundler -v '1.17.3'

COPY . .

COPY Gemfile* ./
RUN bundle install

COPY . .
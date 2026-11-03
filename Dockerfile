FROM ruby:2.6

WORKDIR /app

RUN gem install bundler:2.4.19 --no-document

COPY . /app

RUN bundle _2.4.19_ install

CMD ["bundle", "_2.4.19_", "exec", "rspec"]

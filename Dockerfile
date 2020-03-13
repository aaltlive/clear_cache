FROM ruby:2.5
RUN apt-get update && apt-get upgrade -y && \
    apt install redis-server -y && \
    apt install git -y
RUN bundle config --global frozen 1
WORKDIR clear_cache
COPY app app/
COPY tg-rb tg-rb/
COPY Gemfile Gemfile.lock Rakefile ./
RUN bundle install
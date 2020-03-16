FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && \
    apt install redis-server -y && \
    apt install git -y && \
    apt install ruby-full -y && \
    apt-get install libreadline-dev libconfig-dev libssl1.0-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make -y

RUN gem install bundler

COPY .telegram-cli root/.telegram-cli/

WORKDIR root/w/clear_cache_ruby
COPY Gemfile Rakefile ./
RUN bundle install
COPY tg-rb tg-rb/
COPY app app/

EXPOSE 4567
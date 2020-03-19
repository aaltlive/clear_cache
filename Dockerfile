FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && \
    apt install git -y && \
    apt install ruby-full -y && \
    apt-get install libconfig-dev liblua5.2-dev libevent-dev libjansson-dev -y

COPY .telegram-cli root/.telegram-cli/

WORKDIR root/clear_caсhe

COPY Gemfile Rakefile ./

RUN gem install bundler && bundle install

COPY tg_rb tg_rb/
COPY app app/

EXPOSE 4567
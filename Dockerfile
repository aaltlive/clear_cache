FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && \
    apt install git -y && \
    apt install ruby-full -y && \
    apt-get install libconfig-dev liblua5.2-dev libevent-dev libjansson-dev -y && \
    apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make -y && \
    apt-get install libssl1.0-dev and zlib1g-dev -y

WORKDIR root/clear_caсhe

COPY Gemfile Rakefile ./
RUN gem install bundler && bundle install
RUN git clone --recursive https://github.com/vysheng/tg.git && \
    cd tg && ./configure && make


COPY app app/

EXPOSE 4567
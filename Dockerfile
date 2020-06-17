FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && \
    apt install git -y && \
    apt install ruby-full -y && \
    apt-get install libconfig-dev liblua5.2-dev libevent-dev libjansson-dev -y && \
    apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make -y && \
    apt-get install libssl1.0-dev and zlib1g-dev -y

# COPY .telegram-cli root/.telegram-cli/

WORKDIR root/clear_caсhe
RUN git clone --recursive https://github.com/vysheng/tg.git && \
    cd tg && ./configure && make

# CMD bash
RUN tg/bin/telegram-cli -k tg-server.pub

# COPY Gemfile Rakefile ./

# RUN gem install bundler && bundle install

# COPY tg_rb tg_rb/
# COPY app app/

# EXPOSE 4567
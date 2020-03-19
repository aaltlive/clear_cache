# clear_cache, 11.02.20

## SETUP
git clone https://github.com/aaltlive/clear_cache.git && cd clear_cache

### Telegram-cli
https://github.com/vysheng/tg

#### Ubuntu
git clone --recursive https://github.com/vysheng/tg.git && cd tg <br>
sudo apt-get install libreadline-dev libconfig-dev libssl-dev lua5.2 liblua5.2-dev libevent-dev libjansson-dev libpython-dev make <br>
./configure <br>
make <br>

**If get a compile error:** <br>
https://github.com/wbeyda/tg/commit/4336ff8d04268dab7d0e6888e77bec54f9a16e18 <br>
sudo apt-get install libssl1.0-dev and zlib1g-dev

**After compile:** <br>
bin/telegram-cli -k tg-server.pub

**Enter the number and received code and then for check type:**<br>
contact_list <br>
exit
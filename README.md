# clear_cache, REMAKE 18.06.20

Примечание: на данный момент версия не работает, рабочая версия с компиляцией вне контейнера на ветке V4.
Цель этой версии - выполнять все действия внутри контейнера.

## СОСТОЯНИЕ:
18.06: удалось запустить tg-cli через tg-rb, после предварительной авторизации в режиме сессии.
``` 
docker build . -t cache
docker run -it cache
tg/bin/telegram-cli
**авторизация**
rake rloop
**цикл успешно стартовал**
!ОШИБКА: обращение к редис, а он в docker-compose, а не просто docker run. Так что теперь нужно пробовать тоже самое в docker-compose
```

## SETUP
```
git clone https://github.com/Aaltdes/clear_cache.git && cd clear_cache
```
### ENV
```
touch tokens.env
```
```
VK_ACCESS_TOKEN=<your_vk_access_token>
```
## Run docker
```
docker-compose build && docker-compose up
```

# 디펜던시

* postgresql
* libpq-dev
* nodejs

더 있을지 모름 알아서 해결하세요

# 루비 버전

.ruby\_version 참고

# 준비

postgresql에 wabook이란 유저와 wabook이란 데이터베이스를 추가한다

# 설치

config/database.yml.sample을 참고하여 config/database.yml을 생성

    bundle install
    rake db:migrate

# 가동

    rails s -p [port] -b [ip]

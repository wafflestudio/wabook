# 디펜던시

* postgresql
* libpq-dev
* nodejs

더 있을지 모름 알아서 해결하세요

# 루비 버전

.ruby\_version 참고

# 준비

postgresql에 wabook이란 유저와 wabook이란 데이터베이스를 추가한다  
루비도 깐다  

# 설치

config/database.yml.sample을 참고하여 config/database.yml을 생성

    gem install bundle
    bundle install
    rake db:migrate #필요시에

# 가동

    rails s -p [port] -b [ip]

# 유저 추가하기

## host 변경
config/environments/development.rb 에서 host: 부분을 적당히 수정한다  
email 관련 설정을 적절히 수정한다  
wabook\_admin의 비밀번호는 config/wabook-account.yml을 만들어서 적어둔다

    ---
    password: [wabook_admin password]

# 책 추가하기
## 관리자 설정

    rails runner set-user.rb [관리자로 설정할 유저 이메일]

## 없는 책 추가

화이팅  
잘 하면 좋다  

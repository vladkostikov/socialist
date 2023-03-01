# SociaList

### Описание

**[SociaList](https://socialist.kostikov.ru)** - это соцсеть, в которой можно
добавлять друзей, создавать публикации, комментировать,
ставить лайки и сохранять интересное в закладки.

### Что реализовано в приложении

* Пользователи
  * Регистрация и авторизация
  * Личные страницы
  * Редактирование профиля
  * Система отношений: друзья, подписки, подписчики
  * Поиск по имени, юзернейму, электронной почте
  * Отдельная стена у каждого пользователя
* Публикации
  * Создание публикаций на своей стене и стенах других пользователей
  * Редактирование и удаление публикаций
* Комментарии
  * Комментирование публикаций
  * Ответы на комментарии
  * Редактирование комментариев
* Лайки публикаций и комментариев
* Закладки на пользователей, публикации и комментарии
* Лента новостей с разделением на категории

### Версия ruby: 3.2.1
### Версия rails: 7.0.4

### Библиотеки
* activestorage
* bootstrap
* devise
* google-cloud-storage
* image_processing
* kaminari
* ransack

##  Запуск

1. Должны быть установлены:
- **[Docker Desktop](https://www.docker.com/)** 
- **[Bundler](https://bundler.io/#getting-started)**  
- Ruby 3.2.1  
Для установки выполнить одну из команд, смотря каким менеджером версий пользуетесь:  
`rvm install 3.2.1`  
`rbenv install 3.2.1`  
`asdf install ruby 3.2.1`

2. Запустить Docker Desktop

3. В консоли выполнить команды:
- `git clone https://github.com/vladkostikov/socialist.git`
- `cd socialist`
- `bundle install`
- `docker-compose up` в первой вкладке и оставить процесс активным
(следующие команды во второй вкладке)
- `bin/rails db:create`
- `bin/rails db:migrate`
- `bin/rails server`

Если всё получилось, то сайт будет доступен по адресу http://localhost:3000

Если на команде `bundle install` будет ошибка с `pg`, то нужно будет установить
`libpq` и `postgresql`, например с помощью `apg-get install` или `brew install`.
И выполнить команду `gem install pg 1.4.5`.

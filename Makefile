.RECIPEPREFIX +=
.DEFAULT_GOAL := help

help:
	@echo "Welcome to IT Support , have you tried turning it off  and on again."

analyse:
	./vendor/bin/phpstan analyse --memory-limit=26m

build:
	docker compose build --no-cache --force-rm

cache:
	@docker exec  crm_php php artisan config:cache
	@docker compose exec crm_php composer dump-autoload -o
	@docker compose exec crm_php php artisan event:cache
	@docker compose exec crm_php php artisan view:cache

coverage:
	docker exec crm_php .vendor/bin/pest --coverage

clear:
	docker exec  crm_php php artisan cache:clear
	docker compose exec crm_php php artisan event:clear
	@make optimize-clear


config:
	docker exec  crm_php php artisan config:cache

destroy:
	docker compose down --rmi all --volumes --remove-orphans

destroy-volumes:
	docker compose down --volumes --remove-orphans

down:
	docker compose down --remove-orphans

dusk:
	@docker exec crm_php php artisan dusk

generate:
	@docker exec crm_php php artisan ide-helper:models --write

fresh:
	docker exec  crm_php php artisan migrate:fresh  --seed

ide-helper:
	docker compose exec crm_php php artisan clear-compiled
	docker compose exec crm_php php artisan ide-helper:generate
	docker compose exec crm_php php artisan ide-helper:meta
	docker compose exec crm_php php artisan ide-helper:models --nowrite

install:
		@composer install

install-recommend-packages:
	docker compose exec app composer require doctrine/dbal
	docker compose exec app composer require juststeveking/http-status-code
	docker compose exec app composer require pestphp/pest --dev --with-all-dependencies
	docker compose exec app composer require pestphp/pest-plugin-laravel  --dev
	docker compose exec app composer require nunomaduro/larastan --with-all-dependencies --dev
	docker compose exec app composer require --dev ucan-lab/laravel-dacapo
	docker compose exec app composer require --dev barryvdh/laravel-ide-helper
	docker compose exec app composer require --dev beyondcode/laravel-dump-server
	docker compose exec app composer require --dev barryvdh/laravel-debugbar --dev
	docker compose exec app composer require --dev roave/security-advisories:dev-master
	docker compose exec app php artisan vendor:publish --provider="BeyondCode\DumpServer\DumpServerServiceProvider"
	docker compose exec app php artisan vendor:publish --provider="Barryvdh\Debugbar\ServiceProvider"
key:
	docker exec  crm_php php artisan key:generate
logs:
	docker compose logs
logs-watch:
	docker compose logs --follow
log-web:
	docker compose logs web
log-web-watch:
	docker compose logs --follow web
log-app:
	docker compose logs app
log-app-watch:
	docker compose logs --follow app
log-db:
	docker compose logs db
log-db-watch:
	docker compose logs --follow db

link:
	docker exec  crm_php php artisan storage:link

mysql:
	@docker exec -it crm_mysql /bin/sh

migrate:
	docker exec  crm_php php artisan migrate

nginx:
	docker exec -it company-crm_nginx /bin/sh

pest:
	docker exec  crm_php php artisan  pest:install
ps:
	docker compose ps

php:
	@docker exec -it crm_php /bin/sh

phpmyadmin:
	docker exec -it crm_phpmyadmin /bin/sh

optimize:
	docker compose exec crm_php php artisan optimize
optimize-clear:
	docker compose exec crm_php php artisan optimize:clear

rollback-test:
	docker compose exec crm_php php artisan migrate:fresh
	docker compose exec crm_php php artisan migrate:refresh

restart:
	@make down
	@make up

redis:
	@docker exec -it crm_redis /bin/sh

seed:
	docker exec crm_php php artisan db:seed

stop:
	docker compose stop

test:
	docker exec crm_php php artisan test
	#@docker exec crm_php ./vendor/bin/phpunit
up:
	docker compose up -d

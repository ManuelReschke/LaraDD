################################  GENERAL SETTINGS  ###############################################

# needed to run the make test command!
# https://stackoverflow.com/questions/3931741/why-does-make-think-the-target-is-up-to-date
.PHONY: test artisan

################################  COMMANDS  #######################################################
artisan:
	./docker/bin/artisan.sh $(c)
up:
	sudo docker-compose up -d
build-docker:
	sudo docker-compose rm -vsf
	sudo docker-compose down -v --remove-orphans
	sudo docker-compose build
	sudo docker-compose up -d
down:
	docker-compose down
remove:
	./docker/bin/remove.sh
connect:
	./docker/bin/connect.sh
install:
	./docker/bin/setup.sh
update:
	./docker/bin/composer.sh update
require:
	./docker/bin/composer.sh require
require-dev:
	./docker/bin/composer.sh require --dev
test:
	./docker/bin/composer.sh test
test-coverage:
	./docker/bin/composer.sh test-coverage
xdebug:
	./docker/bin/xdebug-autostart.sh
cs-check:
	./docker/bin/composer.sh cs-check
cs-fix:
	./docker/bin/composer.sh cs-fix
watch:
	./docker/bin/npm.sh
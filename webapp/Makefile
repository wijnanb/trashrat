all: clean compile copy

install:
	@echo "\n# install Compass"
	gem install compass

	@echo "\n# install Node dependencies"
	npm install

server:
	@echo "\n# run server"
	cd www; python -m SimpleHTTPServer 7000; cd -;

watch:
	@echo "\n# watch eco templates, coffee-script and compass"
	node_modules/.bin/cake watch:eco &
	node_modules/.bin/coffee --compile --watch --output www/js src/js/coffee &
	cd src/css; compass watch; cd -;

compile:
	@echo "\n# coffee-script"
	node_modules/.bin/coffee --compile --output www/js src/js/coffee;

	@echo "\n# compass"
	cd src/css; compass compile; cd -;

	@echo "\n# eco templates"
	node_modules/.bin/cake render:templates

	@echo "\n# index.html"
	node_modules/.bin/cake render:index

clean:
	@echo "\n# cleanup"
	rm -rf www;
	mkdir -p www;
	mkdir -p www/js;
	touch www/js/templates.js

copy:
	@echo "\n# copy files"
	cp -r src/img www
	cp -r src/js/vendors www/js
	cp -r src/css/vendors www/css/vendors
	cp -r src/css/img www/css/img
	cp -r src/fonts www
	cp -r data www

deploy:
	@echo "\n# copy www folder to cordova folder"
	cp -r www ../cordova/trashapp

	@echo "\n# build iOS project"
	cd ../cordova/trashapp; cordova build; cd -;
	
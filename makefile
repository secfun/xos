.phony: pull
pull:
	git reset --hard
	git pull origin master
push:
	git commit -am -'`date`'
	git push origin master


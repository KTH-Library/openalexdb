#! make

bibmon.db:
	@echo "Bring in the bibmon database SQLite3 file from ABM"
	cp ~/.config/bibmon/bibmon.db .

shell:
	@echo "A system shell on the postgres db service: (pg_dump etc)"
	docker-compose exec db \
		bash

dbshell:
	@echo "Get a db shell on the postgres db service: (issue \dt etc)"
	@echo "For example create schema w \i schema.sql and load data w \i load.sql"
	docker-compose exec db \
		psql db -U kthb

migrate: oa.db
	@echo "Migrate a sqlite3 db into the postgres db"
	# use connection URI postgresql://[user[:password]@][netloc][:port][/dbname][?schema.table]
	docker-compose run pgloader \
		pgloader /tmp/oa.db postgresql://kthb:example@db/docker

pgdump:
	@echo "Dump the postgres default db to the host"
	docker-compose exec db \
		pg_dump -U docker > ./oa.sql

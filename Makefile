
.PHONY: perms b_run clean run init

perms: 
	sudo chmod u+x -R . && chown 1000:1000 -R .

b_run:
	docker-compose build
	docker-compose up

clean:
	docker-compose down -v
	# docker volume rm borealstar_pgdata


run: 
	make delete_data 
	make b_run

# init:
# 	BASE_DIR="$(pwd)"
# 	cd ./_docker/postgres/
# 	if [ ! "$(ls -A . | grep 'dump')" ] then 
# 		mkdir dump 
# 	fi 
# 	if [ ! "$(ls -A . | grep 'log')" ] then 
# 		mkdir log 
#     fi 
# 	cd $(BASE_DIR)

# {{ $result->links('bootstrap5::pagination') }}


bs-dump.sql.latest:
	echo "lol"



DIFFS := diff _docker/postgres/dump/bs-dump.sql.latest _docker/postgres/docker-entrypoint-initdb.d/20-bs-dump.sql
dupdate: bs-dump.sql.latest
	# echo $(DIFFS)
	ifneq($(DIFFS),"")
		cp _docker/postgres/dump/bs-dump.sql.latest _docker/postgres/docker-entrypoint-initdb.d/20-bs-dump.sql
	endif

	
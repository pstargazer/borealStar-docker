PROFILE=local

.PHONY: perms b_run clean clean_data run init tests test_backend test_frontend

perms: 
	sudo chmod u+x -R . && sudo chown 1000:1000 -R .

test_backend: 
	docker exec -it bs_backend php artisan test

test_frontend:
	docker exec -it bs_frontend vitest

tests: test_backend 



clean:
	docker compose --profile=* down

clean_data:
	docker compose --profile=* down -v


build: perms
	docker compose --profile=$(PROFILE) up --build 

bc_run: clean 
	make build 

bcdata_run: clean_data
	make build 



run:
	docker compose --profile=$(PROFILE) up 


# run: 
# 	make delete_data 
# 	make b_run

init: perms

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


# bs-dump.sql.latest:
# 	echo "lol"



# DIFFS := diff _docker/postgres/dump/bs-dump.sql.latest _docker/postgres/docker-entrypoint-initdb.d/20-bs-dump.sql
# dupdate: bs-dump.sql.latest
# 	# echo $(DIFFS)
# 	ifneq($(DIFFS),"")
# 		cp _docker/postgres/dump/bs-dump.sql.latest _docker/postgres/docker-entrypoint-initdb.d/20-bs-dump.sql
# 	endif

	
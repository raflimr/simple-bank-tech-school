postgres:
	docker run --name postgres12 -p 5431:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migratecreate:
	migrate create -ext sql -dir db/migration -seq <add namefile>

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5431/simple_bank?sslmode=disable" -verbose down 1


sqlc:
	docker run --rm -v F:\!RyuEXP\Golang\project\simple-bank-tech-school:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mockhelp:
	docker run -v F:\!RyuEXP\Golang\project\simple-bank-tech-school:/app -w /app ekofr/gomock:latest \
	mockgen -help

mock:
	docker run -v F:\!RyuEXP\Golang\project\simple-bank-tech-school:/app -w /app ekofr/gomock:latest \
	mockgen --destination db/mock/store.go simplebank-tech-school/db/sqlc Store

mockrename:
	docker run -v F:\!RyuEXP\Golang\project\simple-bank-tech-school:/app -w /app ekofr/gomock:latest \
	mockgen -package mockdb --destination db/mock/store.go simplebank-tech-school/db/sqlc Store 


.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mockhelp mock mockrename migratecreate
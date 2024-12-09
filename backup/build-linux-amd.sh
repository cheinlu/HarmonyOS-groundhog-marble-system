env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 env go build -o main main.go
tar -cf main.tar main manifest/config/config.yaml manifest/db/user.db
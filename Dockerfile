FROM golang:1.18

# Copy application data into image
COPY . /go/src/boychawin/test_api_go
WORKDIR /go/src/boychawin/test_api_go

COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy only `.go` files, if you want all files to be copied then replace `with `COPY . .` for the code below.
COPY *.go .

# Install our third-party application for hot-reloading capability.
RUN ["go", "get", "github.com/githubnemo/CompileDaemon"]
RUN ["go", "install", "github.com/githubnemo/CompileDaemon"]

ENTRYPOINT CompileDaemon -polling -log-prefix=false -build="go build ." -command="./test_api_go" -directory="./"
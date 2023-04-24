#
#   A Dockerfile of the test web application written in Golang.
#   The image size at the moment of building was 7.32 MB.
#   DOC: Apr 24, 2023
#

FROM golang:alpine AS build_step
WORKDIR $GOPATH/src/go-test/
COPY main.go .
RUN go mod init main.go \
&&  go get -d -v

RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /bin/go-test_executable

FROM scratch
COPY --from=build_step /bin/go-test_executable /bin/go-test_executable
ENTRYPOINT ["/bin/go-test_executable"]

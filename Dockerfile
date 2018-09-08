FROM golang AS builder
ADD src /work
WORKDIR /work
RUN go get github.com/labstack/echo \
           github.com/labstack/echo/middleware \
    && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main main.go

FROM alpine
COPY --from=builder /work/main /main
ENTRYPOINT ["/main"]

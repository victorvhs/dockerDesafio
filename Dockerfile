FROM golang:1.18-alpine as builder
WORKDIR /app
RUN apk update && apk add upx
COPY /app .
RUN go build -ldflags "-s -w" main.go
RUN upx main

FROM busybox
WORKDIR /app
COPY --from=builder /app .
ENTRYPOINT ["./main"]




FROM golang:1.20.3-alpine3.17 AS build-env

WORKDIR /app

COPY go.* ./
RUN go mod download
COPY . ./
RUN go build -v -o -ldflags="-w -s" pingtunnel

FROM alpine:3.17
COPY --from=build-env /app/pingtunnel .
COPY GeoLite2-Country.mmdb .
WORKDIR ./

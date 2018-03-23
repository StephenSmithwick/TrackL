FROM golang as compiler
RUN CGO_ENABLED=0 go get -a -ldflags '-s' \
github.com/stephensmithwick/trackl

FROM alpine:latest as certs
RUN apk --update add ca-certificates

FROM scratch
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=compiler /go/bin/trackl .
EXPOSE 8080
CMD ["./trackl"]

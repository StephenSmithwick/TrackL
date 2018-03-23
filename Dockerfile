FROM golang as compiler
RUN CGO_ENABLED=0 go get -a -ldflags '-s' \
github.com/stephensmithwick/trackl

FROM scratch
COPY --from=compiler /go/bin/trackl .
EXPOSE 8080
CMD ["./trackl"]

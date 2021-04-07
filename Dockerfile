FROM golang:alpine as builder
LABEL version=0.4.0-pre.0

RUN apk add --no-cache git

RUN go get github.com/ericchiang/pup

WORKDIR $GOPATH/src/github.com/ericchiang/pup
RUN pwd
RUN ls -al

RUN go build -a -ldflags '-s -w -extldflags "-static"' -o /bin/pup

#----------#

FROM scratch

COPY --from=builder /bin/pup /pup

ENTRYPOINT [ "/pup" ]
CMD [ "--help" ]

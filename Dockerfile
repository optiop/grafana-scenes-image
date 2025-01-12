FROM golang:1.22.4-alpine AS go-builder

RUN apk add --no-cache git

RUN git clone https://github.com/magefile/mage  && cd mage && go run bootstrap.go && cd ..

FROM node:23-bookworm 

COPY --from=go-builder /go/bin/mage /usr/local/bin/mage
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        golang \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/bin/bash" ]
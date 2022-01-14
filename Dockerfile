FROM rancher/hardened-build-base:v1.17.5b7 AS builder
RUN apk --no-cache add \
    curl \
    file \
    git \
    gcc \
    bsd-compat-headers \
    py-pip \
    pigz

COPY . /build

FROM alpine:3.15
RUN apk --no-cache add \
    ca-certificates

COPY --from=builder /build/cmd/gen-release-notes/bin/gen-release-notes /usr/local/bin
COPY --from=builder /build/cmd/backport/bin/backport /usr/local/bin
COPY --from=builder /build/pkg/*-sh/* /usr/local/bin
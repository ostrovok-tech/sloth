# Set also `ALPINE_ARCH` ARG here so we can use it on all the `FROM`s. 
ARG ALPINE_ARCH

FROM golang:1.23.0-alpine as build-stage

LABEL org.opencontainers.image.source "https://github.com/ostrovok-tech/sloth"
LABEL org.opencontainers.image.description "Images of Sloth fork from https://github.com/ostrovok-tech/sloth"
LABEL org.opencontainers.image.licenses "Apache-2.0"

# hadolint global ignore=DL3018
RUN apk --no-cache add g++ git make curl bash tree

# Required by the built script for setting verion and cross-compiling.
ARG VERSION
ENV VERSION=${VERSION}

ARG ARCH
ENV GOARCH=${ARCH}

# Compile.
WORKDIR /src
COPY . .
RUN ./scripts/build/bin/build-raw.sh

# Although we are on an specific architecture (normally linux/amd64) our go binary has been built for
# ${ARCH} specific architecture.
# To make portable our building process we base our final image on that same architecture as the binary 
# to obtain a resulting ${ARCH} image independently where we are building this image.
FROM ${ALPINE_ARCH}/alpine:3

COPY --from=build-stage /src/bin/sloth /usr/local/bin/sloth

ENTRYPOINT ["/usr/local/bin/sloth"]

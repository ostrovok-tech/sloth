FROM golang:1.23.0

LABEL org.opencontainers.image.source https://github.com/ostrovok-tech/sloth

ARG GOLANGCI_LINT_VERSION="1.60.3"
ARG MOCKERY_VERSION="2.45.0"
ARG GOMARKDOC_VERSION="1.1.0"
ARG HELM_VERSION="3.10.0"
ARG ostype=Linux

ARG WGET="wget --progress=dot:giga"

ARG uid=1000
ARG gid=1000

ARG CACHE_DIR=/tmp/cache

# hadolint global ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y git bash zip && rm rm -rf /var/lib/apt/lists/*

RUN ${WGET} https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz && \
 tar zxvf golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz --strip 1 -C /usr/local/bin/ && \
 rm golangci-lint-${GOLANGCI_LINT_VERSION}-linux-amd64.tar.gz && \
 \
 ${WGET} https://github.com/vektra/mockery/releases/download/v${MOCKERY_VERSION}/mockery_${MOCKERY_VERSION}_Linux_x86_64.tar.gz && \
 tar zxvf mockery_${MOCKERY_VERSION}_Linux_x86_64.tar.gz -C /tmp && \
 mv /tmp/mockery /usr/local/bin/ && \
 rm mockery_${MOCKERY_VERSION}_Linux_x86_64.tar.gz && \
 \
 ${WGET} https://github.com/princjef/gomarkdoc/releases/download/v${GOMARKDOC_VERSION}/gomarkdoc_${GOMARKDOC_VERSION}_linux_amd64.tar.gz && \
 tar zxvf gomarkdoc_${GOMARKDOC_VERSION}_linux_amd64.tar.gz -C /tmp && \
 mv /tmp/gomarkdoc_${GOMARKDOC_VERSION}_linux_amd64/gomarkdoc /usr/local/bin/ && \
 rm -rf gomarkdoc_${GOMARKDOC_VERSION}_linux_amd64.tar.gz /tmp/gomarkdoc_${GOMARKDOC_VERSION}_linux_amd64 && \
 \
 ${WGET} https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
 tar zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz -C /tmp && \
 mv /tmp/linux-amd64/helm /usr/local/bin/ && \
 rm -rf helm-v${HELM_VERSION}-linux-amd64.tar.gz /tmp/linux-amd64

# Create user.
RUN bash -c 'if [ ${ostype} == Linux ]; then addgroup -gid $gid app; else addgroup app; fi && \
 adduser --disabled-password -uid $uid --ingroup app --gecos "" app && \
 chown app:app -R /go'

# Fill Go apps cache:
# Main app.
# hadolint global ignore=DL3059
RUN mkdir -p "${CACHE_DIR}"
COPY go.mod go.sum ${CACHE_DIR}/
RUN chown app:app -R "${CACHE_DIR}"

USER app
WORKDIR "${CACHE_DIR}"
RUN go mod download

# Helm testing app.
COPY deploy/kubernetes/helm/sloth/tests/go.mod deploy/kubernetes/helm/sloth/tests/go.sum ${CACHE_DIR}/
RUN go mod download

USER app
WORKDIR /src

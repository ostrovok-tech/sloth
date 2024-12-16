#!/usr/bin/env sh

set -e

[ -z "$VERSION" ] && echo "VERSION env var is required." && exit 1
[ -z "$IMAGE" ] && echo "IMAGE env var is required." && exit 1
[ -z "$DOCKER_FILE_PATH" ] && echo "DOCKER_FILE_PATH env var is required." && exit 1

# By default use amd64 architecture.
DEF_ARCH=amd64
DEF_REF_NAME="development"

ARCH=${ARCH:-$DEF_ARCH}
REF_NAME=${REF_NAME:-$DEF_REF_NAME}

IMAGE_TAG_ARCH="${IMAGE}:${VERSION}-${ARCH}"

# Guess Alpine image arch. Take the same as $ARCH by default.
ALPINE_ARCH="${ARCH}"

case $ARCH in
	arm64)
		ALPINE_ARCH="arm64v8"
		;;

	arm)
		ALPINE_ARCH="arm32v7"
		;;
esac

# Build image.
echo "Building image ${IMAGE_TAG_ARCH}..."
docker build \
	--build-arg VERSION="${VERSION}" \
	--build-arg ARCH="${ARCH}" \
	--build-arg ALPINE_ARCH="${ALPINE_ARCH}" \
	--build-arg REF_NAME="${REF_NAME}" \
	-t "${IMAGE_TAG_ARCH}" \
	-f "${DOCKER_FILE_PATH}" .

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade --yes && apt install --no-install-recommends --yes \
    bc \
    build-essential \
    ca-certificates \
    ccache \
    cpio \
    file \
    git \
    libncurses-dev \
    rsync \
    screen \
    unzip \
    wget \
    wpasupplicant

USER ubuntu

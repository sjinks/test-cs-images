ARG VARIANT=3.17
FROM alpine:${VARIANT}

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN apk add --no-cache \
    runit \
    bash \
    openssh-client \
    gnupg \
    procps \
    lsof \
    htop \
    net-tools \
    psmisc \
    curl \
    wget \
    rsync \
    ca-certificates \
    unzip \
    zip \
    nano \
    vim \
    less \
    jq \
    libgcc \
    libstdc++ \
    krb5-libs \
    libintl \
    libssl1.1 \
    lttng-ust \
    tzdata \
    userspace-rcu \
    zlib \
    sudo \
    coreutils \
    sed \
    grep \
    which \
    ncdu \
    shadow \
    strace \
    mandoc man-pages \
    git && \
    ln -sf /sbin/runit-init /sbin/init && \
    groupadd --gid "${USER_GID}" "${USERNAME}" && \
    useradd -s /bin/bash --uid "${USER_UID}" --gid "${USER_GID}" -m "${USERNAME}" && \
    echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > "/etc/sudoers.d/${USERNAME}" && \
    chmod 0440 "/etc/sudoers.d/${USERNAME}"

ADD rootfs /

ENTRYPOINT [ "/sbin/init" ]

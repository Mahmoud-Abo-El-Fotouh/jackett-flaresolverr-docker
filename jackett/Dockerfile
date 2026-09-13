FROM alpine:3.20
ENV JACKETT_VERSION=latest\
    XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/config
RUN apk add --no-cache\
    ca-certificates \
    curl \
    jq \
    tar \
    tzdata \
    icu-libs \
    krb5-libs \
    libgcc \
    libintl \
    libssl3 \
    libstdc++ \
    zlib\
    su-exec
RUN addgroup -g 1000 jackett && adduser -u 1000 -G jackett -D jackett
COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh
VOLUME ["/config"]
EXPOSE 9117
ENTRYPOINT ["/entrypoint.sh"]

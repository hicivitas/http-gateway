FROM ubuntu:bionic
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_ARG0=/sbin/entrypoint.sh \
    DEBIAN_FRONTEND=noninteractive

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.4.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
RUN apt-get update && \
	apt-get install -y shadowsocks-libev privoxy && \
	# workaround for https://github.com/just-containers/s6-overlay/issues/158
    ln -s /init /init.entrypoint && \
	apt-get autoremove -y && \
	apt-get clean

COPY ./root /

ENTRYPOINT ["/init.entrypoint"]
CMD ["start"]

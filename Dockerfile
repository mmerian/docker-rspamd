FROM debian:stretch-slim

ENV RSPAMD_USER=_rspamd
ENV RSPAMD_GROUP=_rspamd

RUN apt-get update \
    && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends \
    lsb-release \
    wget \
    ca-certificates \
    gnupg

RUN wget -O- https://rspamd.com/apt-stable/gpg.key | apt-key add -

RUN echo "deb [arch=amd64] http://rspamd.com/apt-stable/ `lsb_release -c -s` main" > /etc/apt/sources.list.d/rspamd.list
RUN echo "deb-src [arch=amd64] http://rspamd.com/apt-stable/ `lsb_release -c -s` main" >> /etc/apt/sources.list.d/rspamd.list

RUN apt-get update \
    && apt-get install -y --no-install-recommends rspamd \
    && apt-get clean

VOLUME /etc/rspamd/local.d
VOLUME /var/lib/rspamd

COPY start-rspamd.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-rspamd.sh

ENTRYPOINT ["/usr/local/bin/start-rspamd.sh"]

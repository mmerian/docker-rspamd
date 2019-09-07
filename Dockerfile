FROM debian:buster-slim

ENV RSPAMD_USER=_rspamd
ENV RSPAMD_GROUP=_rspamd

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gnupg && \
    apt-key adv --fetch-keys https://rspamd.com/apt-stable/gpg.key && \
    echo "deb [arch=amd64] http://rspamd.com/apt-stable/ buster main" > /etc/apt/sources.list.d/rspamd.list && \
    echo "deb-src [arch=amd64] http://rspamd.com/apt-stable/ buster main" >> /etc/apt/sources.list.d/rspamd.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends rspamd && \
    apt-get clean

VOLUME /etc/rspamd/local.d
VOLUME /var/lib/rspamd

COPY start-rspamd.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-rspamd.sh

CMD ["/usr/local/bin/start-rspamd.sh"]

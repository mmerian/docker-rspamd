#!/usr/bin/env bash

if [ ! -f /etc/rspamd/local.d/logging.inc ]; then
    echo 'Configuring rspamd for console logging'
    echo 'type = console' > /etc/rspamd/local.d/logging.inc
fi

chown -R $RSPAMD_USER:$RSPAMD_GROUP /var/lib/rspamd
/usr/bin/rspamd -u $RSPAMD_USER -g $RSPAMD_GROUP -f -c /etc/rspamd/rspamd.conf

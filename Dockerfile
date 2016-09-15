FROM puppet/puppetserver-standalone:2.4.0
MAINTAINER Henry Dobson "henry@pebbleit.com"

ENV PUPPETDB_TERMINUS_VERSION="4.2.0"

LABEL com.puppet.version=$PUPPET_SERVER_VERSION com.puppet.git.sha="d5e378b4ac1775b7a8125208a65e0e5ef2823411" com.puppet.buildtime="2016-08-24T07:58:00Z"

RUN apt-get update && \
    apt-get install --no-install-recommends -y puppetdb-termini="$PUPPETDB_TERMINUS_VERSION"-1puppetlabs1 && \
    apt-get install --no-install-recommends -y python && \
    apt-get install --no-install-recommends -y python-pip && \
    pip install --upgrade pip && \
    pip install duo_client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN touch /var/log/check_csr.log && \
    chmod 777 /var/log/check_csr.log

RUN puppet config set storeconfigs_backend puppetdb --section main && \
    puppet config set storeconfigs true --section main && \
    puppet config set reports puppetdb --section main

COPY puppetdb.conf /etc/puppetlabs/puppet/

COPY Dockerfile /

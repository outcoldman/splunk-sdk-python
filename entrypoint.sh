#!/bin/bash

set -e

SPLUNK_VERSION=${SPLUNK_VERSION:-6.1.8}
SPLUNK_BUILD=${SPLUNK_BUILD:-266909}

mkdir -p ${SPLUNK_HOME}
curl -L https://download.splunk.com/products/splunk/releases/${SPLUNK_VERSION}/splunk/linux/splunk-${SPLUNK_VERSION}-${SPLUNK_BUILD}-Linux-x86_64.tgz | tar xz --strip 1 -C ${SPLUNK_HOME}
mkdir -p ${SPLUNK_HOME}/etc/apps/sdk-app-collection
curl -L https://github.com/outcoldman/sdk-app-collection/archive/master.tar.gz | tar xz --strip 1 -C ${SPLUNK_HOME}/etc/apps/sdk-app-collection

${SPLUNK_HOME}/bin/splunk start --accept-license --answer-yes --no-prompt

python setup.py test

${SPLUNK_HOME}/bin/splunk stop

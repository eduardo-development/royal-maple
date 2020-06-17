#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://542d4e3a6317.ngrok.io/project/5eea09404375da07c0e38edc/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://542d4e3a6317.ngrok.io/pull/5eea09404375da07c0e38edc 
fi
curl -s -X POST https://542d4e3a6317.ngrok.io/project/5eea09404375da07c0e38edc/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://542d4e3a6317.ngrok.io/project/5eea09404375da07c0e38edc/webhook/build/publish > /dev/null

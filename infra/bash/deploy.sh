#!/bin/bash

set -e

stack="$1"

exec 5>&1
LAUNCH_OUTPUT=$(sceptre launch -y ${stack} 2>&1 |tee /dev/fd/5; exit ${PIPESTATUS[0]})

set +x
SUCCESS=$(echo ${LAUNCH_OUTPUT} | grep _FAILED | wc -l)
set -x
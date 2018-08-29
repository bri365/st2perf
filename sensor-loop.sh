#!/usr/bin/env bash

for i in `seq 1 100`; do
  /opt/stackstorm/virtualenvs/stackstorm/bin/st2-register-content --config-file=/etc/st2/st2.conf --register-sensors --register-pack=/opt/stackstorm/packs/performance
  sleep 300
  echo -n '.'
done

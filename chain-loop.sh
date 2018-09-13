#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo 'base output file name required'
  exit 1
else
  basename="$1"
fi

top -b -c -i -d .1 > ${basename}.top.txt &

echo -n 'delay action 0.1 seconds'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.delay_0_1.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":0.1}' > run_action
  touch run_action.ok
  echo -n '.'
  sleep 10
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.delay_0_1.stop.txt
echo '.'

echo -n 'delay action 1.0 seconds'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.delay_1_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.0}' > run_action
  touch run_action.ok
  echo -n '.'
  sleep 10
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.delay_1_0.stop.txt
echo '.'

echo -n 'action chain delay 0.1 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_0_1.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":0.1,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 50
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_0_1.stop.txt
echo '.'

echo -n 'action chain delay 0.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_0_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":0.5,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 50
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_0_5.stop.txt
echo '.'

echo -n 'action chain delay 1.0 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_1_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.0,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 60
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_1_0.stop.txt
echo '.'

echo -n 'action chain delay 1.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_1_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 60
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_1_5.stop.txt
echo '.'

echo -n 'action chain delay 3 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_3_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":3.0,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 90
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_3_0.stop.txt
echo '.'

echo -n 'action chain delay 3.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_3_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":3.5,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 90
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_3_5.stop.txt
echo '.'

echo -n 'action chain delay 5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_5_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":5.0,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 100
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_5_0.stop.txt
echo '.'

echo -n 'action chain delay 5.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_5_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":5.5,"iterations":10}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 110
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.chain_10_5_5.stop.txt
echo '.'

cat /var/log/st2/st2action*.log > ${basename}.actionlogs.log
kill `pidof top`

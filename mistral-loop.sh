#!/usr/bin/env bash

if [[ -z "$1" ]]; then
  echo 'base output file name required'
  exit 1
else
  basename="$1"
fi

top -b -c -i -d .1 > ${basename}.top.txt &

echo -n 'mistral workflow delay 0.1 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_0_1.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":0.1,"iterations":10,"concurrency":1,"chain":true}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 20
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_0_1.stop.txt
echo '.'

echo -n 'mistral workflow delay 0.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_0_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":0.5,"iterations":10,"concurrency":1,"chain":true}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 20
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_0_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 1.0 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_1_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.0,"iterations":10,"concurrency":1,"chain":true}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 40
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_1_0.stop.txt
echo '.'

echo -n 'mistral workflow delay 1.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_1_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":10,"concurrency":1,"chain":true}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 40
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_1_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 1.5 seconds 10 times with concurrency 1'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_1_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":10,"concurrency":1,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 40
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_1_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 1.5 seconds 10 times with concurrency 2'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_2_1_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":10,"concurrency":2,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 40
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_2_1_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 1.5 seconds 10 times with concurrency 4'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_4_1_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":10,"concurrency":4,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 40
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_4_1_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 1.5 seconds 10 times with concurrency 8'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_8_1_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":10,"concurrency":8,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 40
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_8_1_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 3 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_3_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":3.0,"iterations":10,"concurrency":1,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 50
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_3_0.stop.txt
echo '.'

echo -n 'mistral workflow delay 3.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_3_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":3.5,"iterations":10,"concurrency":1,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 55
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_3_5.stop.txt
echo '.'

echo -n 'mistral workflow delay 5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_5_0.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":5.0,"iterations":10,"concurrency":1,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 80
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_5_0.stop.txt
echo '.'

echo -n 'mistral workflow delay 5.5 seconds 10 times'
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_5_5.start.txt
for i in `seq 1 5`; do
  echo '{"seconds":5.5,"iterations":10,"concurrency":1,"chain":false}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 85
done
date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_concurrency_1_5_5.stop.txt
echo '.'

cat /var/log/st2/st2action*.log > ${basename}.actionlogs.log
kill `pidof top`

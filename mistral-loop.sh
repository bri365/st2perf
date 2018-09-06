#!/usr/bin/env bash

echo -n 'mistral workflow delay 0.1 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":0.1,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 90
done
echo '.'

echo -n 'mistral workflow delay 0.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":0.5,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 90
done
echo '.'

echo -n 'mistral workflow delay 1.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":1.5,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 120
done
echo '.'

echo -n 'mistral workflow delay 3 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":3.0,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 150
done
echo '.'

echo -n 'mistral workflow delay 3.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":3.5,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 150
done
echo '.'

echo -n 'mistral workflow delay 5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":5.0,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 180
done
echo '.'

echo -n 'mistral workflow delay 5.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":5.5,"iterations":20,"concurrency":1}' > run_mistral
  touch run_mistral.ok
  echo -n '.'
  sleep 180
done
echo '.'

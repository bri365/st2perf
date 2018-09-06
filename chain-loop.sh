#!/usr/bin/env bash

echo -n 'delay action 0.1 seconds'
for i in `seq 1 5`; do
  echo '{"seconds":0.1}' > run_action
  touch run_action.ok
  echo -n '.'
  sleep 10
done
echo '.'

echo -n 'action chain delay 0.1 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":0.1}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 50
done
echo '.'

echo -n 'action chain delay 0.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":0.5}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 50
done
echo '.'

echo -n 'action chain delay 1.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":1.5}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 70
done
echo '.'

echo -n 'action chain delay 3 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":3.0}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 120
done
echo '.'

echo -n 'action chain delay 3.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":3.5}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 120
done
echo '.'

echo -n 'action chain delay 5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":5.0}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 150
done
echo '.'

echo -n 'action chain delay 5.5 seconds 20 times'
for i in `seq 1 5`; do
  echo '{"seconds":5.5}' > run_chain
  touch run_chain.ok
  echo -n '.'
  sleep 160
done
echo '.'

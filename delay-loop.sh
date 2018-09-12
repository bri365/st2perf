#!/usr/bin/env bash

top -b -c -i -d .1 -n 500 > top.delay_0_1.txt &
echo -n 'delay action 0.1 seconds'
for i in `seq 1 5`; do
  echo '{"seconds":0.1}' > run_action
  touch run_action.ok
  echo -n '.'
  sleep 10
done
echo '.'

top -b -c -i -d .1 -n 500 > top.delay_0_5.txt &
echo -n 'delay action 0.5 seconds'
for i in `seq 1 5`; do
  echo '{"seconds":0.5}' > run_action
  touch run_action.ok
  echo -n '.'
  sleep 10
done
echo '.'


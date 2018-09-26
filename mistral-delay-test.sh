#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo "base output file name required"
    exit 1
else
    basename="$1"
fi

top -b -c -i -d .1 > ${basename}.top.txt &

for delay in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 8.0 8.2 8.4 8.6 8.8; do
    echo -n "mistral workflow chain ${delay} seconds 10 times"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":10,\"concurrency\":1,\"mode\":\"chain\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}*10+29")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_chain_10_delay_${delay/./_}.stop.txt
    echo "."
    
    echo -n "mistral workflow ${delay} seconds 10 times with concurrency 1"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_repeat_10_concurrency_1_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":10,\"concurrency\":1,\"mode\":\"repeat\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}*10+29")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_repeat_10_concurrency_1_delay_${delay/./_}.stop.txt
    echo "."
    
    echo -n "mistral workflow ${delay} seconds 10 times with concurrency 10"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_repeat_10_concurrency_10_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":10,\"concurrency\":10,\"mode\":\"repeat\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}+12")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_repeat_10_concurrency_10_delay_${delay/./_}.stop.txt
    echo "."
    
    echo -n "mistral workflow ${delay} seconds 10 times fully parallel"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_parallel_10_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":10,\"concurrency\":0,\"mode\":\"repeat\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}+12")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_parallel_10_delay_${delay/./_}.stop.txt
    echo "."
    
    echo -n "mistral workflow ${delay} seconds 10 times list parallel"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_list_10_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":10,\"concurrency\":0,\"mode\":\"list\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}+12")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_list_10_delay_${delay/./_}.stop.txt
    echo "."
    
    echo -n "mistral workflow ${delay} seconds 32 times fully parallel"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_parallel_32_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":32,\"concurrency\":0,\"mode\":\"repeat\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}+20")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_parallel_32_delay_${delay/./_}.stop.txt
    echo "."
    
    echo -n "mistral workflow ${delay} seconds 32 times list parallel"
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_list_32_delay_${delay/./_}.start.txt
    for i in `seq 1 5`; do
      echo "{\"seconds\":${delay},\"iterations\":32,\"concurrency\":0,\"mode\":\"list\"}" > run_mistral
      touch run_mistral.ok
      echo -n "."
      sleep $(python -c "print ${delay}+20")
    done
    date -u +%Y-%m-%dT%R:%S.%NZ > ${basename}.mistral_list_32_delay_${delay/./_}.stop.txt
    echo "."
done

# capture logs and stop top
cat /var/log/st2/st2action*.log > ${basename}.actionlogs.log
kill `pidof top`

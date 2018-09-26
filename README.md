# Performance pack

This pack contains actions for testing st2 performance

## Actions

* ``delay`` - delay x seconds
* ``chain_delay_10`` - delay x seconds 10 times in an action chain
* ``chain_delay_20`` - delay x seconds 20 times in an action chain
* ``mistral_delay_10`` - delay x seconds 10 times in a simple Mistral workflow chain
* ``mistral_delay`` - delay x seconds, y times, with z concurrency with Mistral
* ``mistral_parallel_delay`` - delay x seconds, y times, with full concurrency with Mistral
* ``mistral_list_delay`` - delay x seconds, y times, with full concurrency with Mistral in a manner most like Connect workflows

## Policies

* ``delay20`` - limit concurrency to 1 (not currently used)

## Rules
* ``start_*`` - rules to start actions based on sensor triggers

## Sensor

* watches ``.../packs/performance`` directory for ``run_*`` files
* ``run_xyz`` files contains json parameters, where "mode" is one of ``chain``, ``repeat``, or ``list`` (e.g. ``{"seconds":1.0,"iterations":20,"concurrency":1,"mode":"list"}``)
* ``run_xyz.ok`` is a semaphore file, informing sensor to read and process json file
* ``run_delay``, ``run_chain``, and ``run_mistral`` are currently supported

## Setup
If running standalone (i.e. on native StackStorm and not as part of Composable Fabric Manager):

``cd /opt/stackstorm/packs``

``git clone git@github.com:bri365/st2perf.git``

Setup the pack virtualenv

``st2 run ``

## Usage

* manual testing ``st2 run performance.chain_delay_20 seconds=0.1``
* sensor/trigger/rule based testing ``./chain-loop``, ``./mistral-loop``, or ``mistral-delay-test``

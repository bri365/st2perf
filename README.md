# Performance pack

This pack contains actions for testing st2 performance

## Actions

* ``delay`` - delay x seconds
* ``chain_delay`` - delay x seconds 20 times in an action chain
* ``mistral_delay`` - delay x seconds, y times, with z concurrency with Mistral

## Policies

* ``delay20`` - limit concurrency to 1

## Sensor

* watches ``.../packs/performance`` directory for ``run_*`` files
* ``run_xyz`` files contains json parameters (e.g. ``{"seconds":1.0,"iterations":20,"concurrency":1}``)
* ``run_xyz.ok`` is a semaphore file, informing sensor to read and process json file
* ``run_chain`` and ``run_mistral`` are currently supported

## Testing

* manual testing ``st2 run performance.chain_delay_20 seconds=0.1``
* sensor/trigger/rule based testing ``./chain-loop`` or ``./mistral-loop``

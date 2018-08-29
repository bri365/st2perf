# Performance pack

This pack contains actions for testing performance issues

## Actions

* ``delay2`` - a two second delay
* ``delay20`` - a twenty second delay
* ``delay2test`` - a workflow with delay2 followed by delay20

## Policies

* ``delay20`` - limit concurrency to 1
* ``delay2test`` - limit concurrency to 10

## Testing

Launch multiple instances of delay workflow for deadlock testing:

* ``for i in `seq 1 100`; do st2 action execute performance.delay2test; done``

Without the ``delay2test`` policy, the actions deadlock

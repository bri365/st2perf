# -*- coding: utf-8 -*-
########################################################################
#
# Copyright (c) 2018, Plexxi Inc. and its licensors.
#
# All rights reserved.
#
# Use and duplication of this software is subject to a separate license
# agreement between the user and Plexxi or its licensor.
#
########################################################################

import glob
import json
import os

from st2reactor.sensor.base import PollingSensor


class PerformanceSensor(PollingSensor):
    """Sensor for performance testing."""

    def __init__(self, sensor_service, config=None, poll_interval=None):
        """Initialize.

        Arguments:
            sensor_service (SensorService): Utility class for logging and dispatching triggers
            config (dict): Configuration data from the packs config.yaml file
            poll_interval (int): The interval between calls to poll()
        """
        super(PerformanceSensor, self).__init__(sensor_service=sensor_service,
                                                config=config,
                                                poll_interval=poll_interval)

        self._logger = self._sensor_service.get_logger(name=self.__class__.__name__)
        self.base_path = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))

    def setup(self, dsn=None):
        """Initialize the sensor.

        Arguments:
            dsn (str): Data Source Name, connection information for the database
        """
        for f in glob.glob('{}/run_*'.format(self.base_path)):
            os.remove(f)

    def poll(self):
        """Poll cycle."""
        for f in glob.glob('{}/run_*'.format(self.base_path)):
            if 'run_action.ok' in f:
                seconds, iterations, concurrency, mode = self.get_params(os.path.splitext(f)[0])
                self.sensor_service.dispatch(
                    trigger="performance.action_delay",
                    payload={'seconds': seconds})
            if 'run_chain.ok' in f:
                seconds, iterations, concurrency, mode = self.get_params(os.path.splitext(f)[0])
                self.sensor_service.dispatch(
                    trigger="performance.chain_delay",
                    payload={'seconds': seconds,
                             'iterations': iterations})
            if 'run_mistral.ok' in f:
                seconds, iterations, concurrency, mode = self.get_params(os.path.splitext(f)[0])
                self.sensor_service.dispatch(
                    trigger="performance.mistral_delay",
                    payload={'seconds': seconds,
                             'iterations': iterations,
                             'concurrency': concurrency,
                             'mode': mode})

    @staticmethod
    def get_params(file_name):
        """Get parameters from run file."""
        try:
            with open(file_name) as run_file:
                data = json.load(run_file)
            seconds = data.get('seconds', 0)
            iterations = data.get('iterations', 1)
            concurrency = data.get('concurrency', 1)
            mode = data.get('mode', 'list')
        except ValueError:
            seconds = 0
            iterations = 1
            concurrency = 1
            mode = 'list'

        os.remove(file_name)
        os.remove('{}.ok'.format(file_name))

        return seconds, iterations, concurrency, mode

    def cleanup(self):
        """Run when sensor is shutdown."""
        pass

    def add_trigger(self, trigger):
        """Run when trigger is created.

        Arguments:
            trigger (trigger):
        """
        pass

    def update_trigger(self, trigger):
        """Run when trigger is updated.

        Arguments:
            trigger (trigger):
        """
        pass

    def remove_trigger(self, trigger):
        """Run when trigger is deleted.

        Arguments:
            trigger (trigger):
        """
        pass

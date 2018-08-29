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

from st2reactor.sensor.base import PollingSensor


class PerformanceSensor(PollingSensor):
    """Sensor for performance testing."""

    # Trigger definitions
    PERFORMANCE_1 = 'performance_1'
    PERFORMANCE_1_TRIGGER = 'performance.{}'.format(PERFORMANCE_1)
    PERFORMANCE_2 = 'performance_2'
    PERFORMANCE_2_TRIGGER = 'performance.{}'.format(PERFORMANCE_2)
    PERFORMANCE_3 = 'performance_3'
    PERFORMANCE_3_TRIGGER = 'performance.{}'.format(PERFORMANCE_3)
    PERFORMANCE_4 = 'performance_4'
    PERFORMANCE_4_TRIGGER = 'performance.{}'.format(PERFORMANCE_4)

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

    def setup(self, dsn=None):
        """Initialize the sensor.

        Arguments:
            dsn (str): Data Source Name, connection information for the database
        """
        self._logger.debug('Sensor setup()')

        self.sensor_service.dispatch(
            trigger=self.PERFORMANCE_1_TRIGGER,
            payload={'seconds': 0.1},
            trace_tag=self.PERFORMANCE_1)

        self.sensor_service.dispatch(
            trigger=self.PERFORMANCE_2_TRIGGER,
            payload={'seconds': 1.1},
            trace_tag=self.PERFORMANCE_2)

        self.sensor_service.dispatch(
            trigger=self.PERFORMANCE_3_TRIGGER,
            payload={'seconds': 1.1},
            trace_tag=self.PERFORMANCE_3)

        self.sensor_service.dispatch(
            trigger=self.PERFORMANCE_4_TRIGGER,
            payload={'seconds': 1.1},
            trace_tag=self.PERFORMANCE_4)

    def poll(self):
        """Poll cycle."""
        pass

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

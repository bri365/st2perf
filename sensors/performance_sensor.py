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

from plexxiconnect import utils
from plexxiconnect.db import pack_config
from plexxiconnect.db.cache import kubernetes_cache
from plexxiconnect.db.model import meta
from plexxiconnect.debug import eventlet_debug
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
        self._kubernetes_cache = None
        self._pack_config = None

        if eventlet_debug.enabled():
            eventlet_debug.log_configuration(self._logger)

    def setup(self, dsn=None):
        """Initialize the sensor.

        Arguments:
            dsn (str): Data Source Name, connection information for the database
        """
        self._logger.debug('Sensor setup()')
        meta.configure_db()

        self._kubernetes_cache = kubernetes_cache.KubernetesCache(dsn=dsn, logger=self._logger)
        self._pack_config = pack_config.PackConfig(logger=self._logger, dsn=dsn)

        for config in utils.get_enabled_configs(self.config):
            self._logger.debug(config)

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

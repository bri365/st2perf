# -*- coding: utf-8 -*-
##########################################################################
#
# Copyright (c) 2018, Plexxi Inc. and its licensors.
#
# All rights reserved.
#
# Use and duplication of this software is subject to a separate license
# agreement between the user and Plexxi or its licensor.
#
##########################################################################

"""
Usage:
  action_log_analysis [options] <action_log_file>...
  action_log_analysis --help

Options:
  -a --after <timestamp>    Only process log entries after this time (e.g. -a 2016-08-15T07:30:45Z)
  -h --help                 Show this screen
  -c --csv                  Output only names and times in CSV format
"""
import time

from datetime import datetime
from docopt import docopt

VERBOSE = True


def read_log_files(log_files, levels=None):
    """Read st2 action log files.

    Arguments:
        log_files list[str]: List of st2actionrunner log files
        levels list[str]: List of log levels to filter by

    Returns:
        list[str]: List of filtered log lines, sorted by time
    """
    if VERBOSE:
        print('Analyzing {} log files'.format(len(log_files)))

    action_log_entries = []
    for log_file in log_files:
        with open(log_file) as f:
            log_entries = f.read().splitlines()
        action_log_entries.extend(log_entries)
        if VERBOSE:
            print('  {} entries from {}'.format(len(log_entries), log_file))
    if VERBOSE:
        print('  {} total log entries'.format(len(action_log_entries)))

    if levels:
        action_log_entries[:] = [entry for entry in action_log_entries if has_level(entry, levels)]
    if VERBOSE:
        print('  {} log entries after level filtering for {}'.format(len(action_log_entries), levels))

    return sorted(action_log_entries)


def has_level(entry, levels):
    """Determine if log entry is one of the requested levels.

    Arguments:
        entry str: A single log file line
        levels list[str]: List of log levels to filter by

    Returns:
        bool: true if log file entry is one of the requested levels
    """
    for level in levels:
        entry_level = entry.split()[3] if len(entry.split()) > 3 else None
        if entry_level == level:
            return True
    return False


def parse_audit_line(audit_line):
    """Parse AUDIT log file line into tuple.

    Arguments:
        audit_line str: a single log file line of AUDIT level

    Returns:
        tuple: (time stamp, log agent, live action id, operation, st2 action name, execution id)
    """
    act = None
    act_id = None
    act_name = None
    act_params = None
    exec_id = None
    tokens = audit_line.split()
    dt = datetime.strptime('{}T{}'.format(tokens[0], tokens[1]), "%Y-%m-%dT%H:%M:%S,%f")
    time_stamp = time.mktime(dt.timetuple()) + (dt.microsecond / 1000000.0)

    agent = tokens[4] if len(tokens) > 4 else None
    if agent == 'action':
        index = audit_line.find('LiveAction.id=')
        act_id = audit_line[index + 14:index + 38]
        index = audit_line.find('ActionExecution.id=')
        exec_id = audit_line[index + 19:index + 43]
        if audit_line.find('execution is changed from') > 0:
            act = tokens[16].replace('.', '')
            if act == 'scheduled':
                start = audit_line.find("'action': u'") + 12
                finish = audit_line[start:].find("'")
                act_name = audit_line[start:start + finish]
                start = audit_line.find("'parameters': {u'seconds': ") + 27
                if start > 0:
                    finish1 = audit_line[start:].find(",")
                    finish2 = audit_line[start:].find("}")
                    act_params = audit_line[start:start + min([finish1, finish2])]
        elif audit_line.find('Action execution requested') > 0:
            act = 'requested'

    elif agent == 'base':
        index = audit_line.find('end_timestamp')
        act_id = audit_line[index - 28:index - 4]
        act = tokens[7].lower()

    elif agent in ['access', 'actionrunner', 'consumers', '__init__', 'misc', 'mixins']:
        # Nothing to do for these agents
        pass

    elif agent == 'scheduler':
        index = audit_line.find("liveaction.LiveActionDB'> (id=")
        act_id = audit_line[index + 30:index + 54]
        act = tokens[8]

    elif agent == 'worker':
        index = audit_line.find('end_timestamp')
        act_id = audit_line[index - 28:index - 4]
        index = audit_line.find('action_execution_db=')
        index2 = audit_line[index:].find('end_timestamp')
        exec_id = audit_line[index + index2 - 28:index + index2 - 4]
        act = tokens[6].lower()

    else:
        print('Unrecognized agent {}: {}'.format(agent, audit_line))

    return dt, time_stamp, agent, act_id, act, act_name, act_params, exec_id


if __name__ == '__main__':
    arguments = docopt(__doc__, help=True, version='Plexxi Connect Action Log Analysis 0.1')
    if arguments['--csv']:
        VERBOSE = False

    lines = read_log_files(arguments['<action_log_file>'], ['AUDIT'])

    live_action_array = []
    live_action_count = 0
    running_actions = 0
    live_actions = {}
    for line in lines:
        # Parse the log file line
        dt, ts, entity, action_id, action, action_name, params, execution_id = parse_audit_line(line)

        if entity == 'action':
            if action_id in live_actions:
                # action exists, add new operation
                live_actions[action_id].append({'datetime': dt,
                                                'timestamp': ts,
                                                'action': action,
                                                'action_id': action_id,
                                                'action_name': action_name,
                                                'action_params': params,
                                                'execution_id': execution_id})
            else:
                # First occurrence of the action
                if action not in ['scheduled', 'delayed', 'requested']:
                    print('ERROR: Unexpected action operation {} from {}: {}'.format(action, entity, line))
                else:
                    live_action_count += 1
                    live_action_array.append(action_id)
                    live_actions[action_id] = [{'datetime': dt,
                                                'timestamp': ts,
                                                'action': action,
                                                'action_id': action_id,
                                                'action_name': action_name,
                                                'action_params': params,
                                                'execution_id': execution_id}]
            # Scheduled actions are set to worker queue
            if action == 'scheduled':
                running_actions += 1

        elif entity == 'base':
            if action_id not in live_actions:
                print('ERROR: base operation {} before action {} was scheduled'.format(action, action_id))
            else:
                if action not in ['completed']:
                    print('Unexpected operation {} from {}: {}'.format(action, entity, line))
                else:
                    running_actions -= 1
                    live_actions[action_id].append({'datetime': dt,
                                                    'timestamp': ts,
                                                    'action': action,
                                                    'action_id': action_id,
                                                    'execution_id': execution_id})

        elif entity == 'worker':
            if action_id not in live_actions and action not in ['canceling']:
                print('ERROR: worker operation {} before action {} was scheduled'.format(action, action_id))
            else:
                if action not in ['launching', 'canceling']:
                    print('Unexpected operation {} from {}: {}'.format(action, entity, line))
                elif action == 'canceling':
                    live_action_count += 1
                    live_action_array.append(action_id)
                    live_actions[action_id] = [{'datetime': dt,
                                                'timestamp': ts,
                                                'action': action,
                                                'action_id': action_id,
                                                'action_name': action_name,
                                                'action_params': params,
                                                'execution_id': execution_id}]

                else:
                    live_actions[action_id].append({'datetime': dt,
                                                    'timestamp': ts,
                                                    'action': action,
                                                    'action_id': action_id,
                                                    'execution_id': execution_id})
            if action == 'canceling':
                running_actions -= 1

        if action == 'scheduled':
            # Print a running total of scheduled actions
            if VERBOSE:
                print('{} scheduled actions at {} adding {} {}'
                  .format(running_actions, datetime.fromtimestamp(ts).strftime('%H:%M:%S.%f'), action_id, action_name))

    # Review the list of live actions and their operations
    for offset, value in enumerate(live_action_array):
        header = '{}: {} '.format(offset, value)
        body = ""
        name = ""
        params = ""
        launched = False
        scheduled = False
        trailer = None
        start_timestamp = live_actions[value][0]['timestamp']
        start_dt = live_actions[value][0]['datetime']
        # Iterate over the live action's operations
        for idx, item in enumerate(live_actions[value]):
            body += '{} '.format(item['action'])
            if item['action'] == 'launching':
                launched = True
            if item['action'] == 'scheduled':
                name = item['action_name']
                params = item['action_params']
                scheduled = True
            if item['action'] == 'completed':
                # trailer = 'in {0:.2f} seconds; start {1}; finish {2}'.format(
                #     item['timestamp'] - start_timestamp, start_dt, item['datetime'])
                trailer = '{0:.2f},{1},{2}'.format(
                    item['timestamp'] - start_timestamp, start_dt, item['datetime'])

        # Print the live action details
        if trailer:
            # print('{} {} {}{}'.format(header, name, body, trailer))
            print('{},{},{}'.format(name, params, trailer))
        elif not scheduled:
            print('ERROR: {} {} never scheduled! {}'.format(header, name, body))
        elif not launched:
            print('ERROR: {} {} never launched! {}'.format(header, name, body))
        else:
            print('ERROR: {} {} never completed! {}'.format(header, name, body))

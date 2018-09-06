import time

from st2actions.runners.pythonrunner import Action


class Delay(Action):
    def run(self, seconds):
        time.sleep(seconds)

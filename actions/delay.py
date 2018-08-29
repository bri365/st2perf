import time

from st2actions.runners.pythonrunner import Action


class Delay(Action):
    def run(self, seconds):
        print time.time()
        time.sleep(seconds)
        print time.time()

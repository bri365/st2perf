from st2actions.runners.pythonrunner import Action


class DelayList(Action):
    def run(self, seconds, iterations):
        return True, [seconds for _ in range(iterations)]

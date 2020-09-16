#import pyximport; pyximport.install(pyimport=True)

import tensorflow as tf
import numpy as np
# import tf_agents as agents

import random


### TRON CONTROLLER ###

class TronController:
    def __init__(self):
        # initializse the calss
        pass

    def play(self, frame):
        # make a game descision
        return random.randrange(5)

    def feedback(self,res):
        # update the RFL Agent
        pass

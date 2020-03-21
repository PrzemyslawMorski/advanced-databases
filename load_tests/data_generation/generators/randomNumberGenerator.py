import numpy as np
import math
import random

class RandomNumberGenerator:

    def getGaussianRand(self = None, number=1):
        return math.floor(random.random() * number)

    def getGaussianListRand(self = None, list=[]):
        return math.floor(random.random() * len(list))

    def flagRandom(self=None, probability=0.5):
        value = random.random()
        if value <= probability:
            return "t"
        return "f"

    def getintRandom(self=None, number=0):
        value = random.random()
        return math.floor(value * number)

    def getListRandom(self=None, l=[]):
        value = random.random()
        return math.floor(value * len(l))

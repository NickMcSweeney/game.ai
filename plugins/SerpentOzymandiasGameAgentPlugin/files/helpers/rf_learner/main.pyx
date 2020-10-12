from main import Memory, Model
#from memory import Memory
#from model import Model

class Learner:

  def __init__(self, num_states, num_actions, batch_size):
    # constructor
    self._num_states = num_states
    self._num_actions = num_actions
    self._batch_size = batch_size

    self._model = Model(num_states, num_actions, batch_size)
    self._mem = Memory(50000)

  

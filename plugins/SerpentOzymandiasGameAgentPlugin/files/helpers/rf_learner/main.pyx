import pyximport; pyximport.install(pyimport=True)
import tensorflow as tf
import numpy as np

#from memory import Memory
#from model import Model


cdef int learning_rate = 1e-3
cdef tuple fc_layer_params = (100,)

class Learner:

  def __init__(self, num_states, num_actions, batch_size):
    # constructor
    self._num_states = num_states
    self._num_actions = num_actions
    self._batch_size = batch_size

    action_spec = array_spec.BoundedArraySpec(
        shape=(), dtype=np.int32, minimum=0, maximum=1, name='action')
    observation_spec = array_spec.BoundedArraySpec(
        shape=(600,400), dtype=np.int32, minimum=-2, maximum=2, name='observation')

    q_net = q_network.QNetwork(observation_space, action_space, fc_layer_params=fc_layer_params)
    optimizer = tf.compat.v1.train.AdamOptimizer(learning_rate=learning_rate)

    train_step_counter = tf.Variable(0)

    agent = dqn_agent.DqnAgent(
      state_space,
      action_space,
      q_network=q_net,
      optimizer=optimizer,
      td_errors_loss_fn=common_wise_squared_loss,
      train_step_counter=train_step_counter
    )

    agent.initialize()

    eval_policy = agent.policy
    collect_policy = agent.collect_policy
    
    random_policy = random_tf_policy.RandomTFPolicy(state_spec, action_spec)
    

  def act(self, state):
    # take action
    return np.argmax(self._model.predict_one(state,self._sess))

  

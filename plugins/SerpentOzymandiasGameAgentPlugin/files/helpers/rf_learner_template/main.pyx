from __future__ import absolute_import, division, print_function

import base64
import imageio
import IPython
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import PIL.Image
import pyvirtualdisplay

import tensorflow as tf

from tf_agents.agents.dqn import dqn_agent
from tf_agents.drivers import dynamic_step_driver
from tf_agents.environments import suite_gym
from tf_agents.environments import tf_py_environment
from tf_agents.eval import metric_utils
from tf_agents.metrics import tf_metrics
from tf_agents.networks import q_network
from tf_agents.policies import random_tf_policy
from tf_agents.replay_buffers import tf_uniform_replay_buffer
from tf_agents.trajectories import trajectory
from tf_agents.utils import common

from memory import *
from model import *
from runner import *

MIN_EPSILON = 0
MAX_EPSILON = 1
GAMMA = 1
BATCH_SIZE = 1
LAMBDA = 1

if __name__ == "__main__":
  env_name = 'zero-ad'
  env = suite_gym.make(env_name)

  num_states = env.env.observation_space.shape[0]
  num_actions = env.env.action_space.n

  model = Model(num_states, num_actions, BATCH_SIZE)
  mem = Memory(50000)

  with tf.Session() as sess:
    sess.run(model.var_init)
    gr = GameRunner(sess, model, env, mem, MAX_EPSILON, MIN_EPSILON, LAMBDA)
    num_episodes = 300
    cnt = 0
    while cnt < num_episodes:
      if cnt % 10 == 0:
        print('Episode {} of {}'.format(cnt+1, num_episodes))
      gr.run()
      cnt += 1
    plt.plot(gr.reward_store)
    plt.show()
    plt.close("all")
    plt.plot(gr.max_x_store)
    plt.show()

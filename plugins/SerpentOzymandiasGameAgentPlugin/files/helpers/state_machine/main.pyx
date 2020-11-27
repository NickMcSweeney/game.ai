import tensorflow as tf
import numpy as np
import keras
import cv2

from ..classifier.main import Classifier
from ..rf_agent.main import Agent

"""
Game agent state machine
interfaces with the ML agent to decide the action to take 
STEP 1: determine focus
STEP 2a: if no focus --> use agent to select something
STEP 2b: if focus --> go into building or unit sub routine
---
+ 'period' to get free unit
+ learner give 'click' location takes resource and population delta
"""
class StateMachine:
  def __init__(self, api):
    # initialize class
    self.api = api
    self._focus_classifier = Classifier()

    # setup rf learners
    #img = cv2.resize(api.get_game_frame().half_resolution_frame, (600, 400), interpolation = cv2.INTER_CUBIC) 
    #img_array = keras.preprocessing.image.img_to_array(img)
    #img_array = tf.expand_dims(img_array, 0) # Create a batch
    #frame_size = img_array.size() 
    #print("frame size: %d" % frame_size)

    self.UnitAgent = Agent.SimplePyEnvironment()

    self.free_unit = True
    self.acted = False

  def take_action(self, game_frame):
    # Fuzzy logic for determining the action to take
    self._focus = self._focus_classifier.classify(game_frame.half_resolution_frame)

    if(self._focus == "unit"):
      # perform unit focus action
      self.handle_unit_action(game_frame.half_resolution_frame)
      self.api.GameAction.clear_selection()
    elif(self._focus == "building"):
      # perform building focus action
      self.create()
      self.api.GameAction.clear_selection()
    else:
      # focus on something
      if (self.free_unit):
        self.api.GameAction.get_idle_worker()
        self.free_unit = False
      else:
        self.free_unit = True
        self.focus()

  #------ ------ Getter/Setter Functions ------ ------
  def get_focus(self):
    # determine what has current focus
    return self._focus
    
  def set_focus(self, focus):
    # set the focus
    self._focus = focus

  #------ ------ Action Functions ------ ------
  def focus(self):
    # focus on something
    #self.api.GameAction.select(coordX, coordY)
    self.api.GameAction.make_random_selection()
    
  def create(self):
    # create unit or research tech at building
    self.api.GameAction.make_random_build()

  def handle_unit_action(self, frame):
    # handle the decision for unit
    # (A) go to point (B) build at point
    if (self.acted):
      # give feedback to agent
      # get points
      points = self.api.GameInterface.get_points()
      food = abs(points["food"]["change"])
      wood = abs(points["wood"]["change"])
      stone = abs(points["stone"]["change"])
      iorn = abs(points["iorn"]["change"])
      pop = abs(points["population"]["change"])
      self.heart.feedback(food,wood,stone,iorn,pop)
      self.acted = False
    else:
      # get action from agent
      (coordX, coordY) = self.heart.act(frame)
      (dimX, dimY) = self.api.get_window()
      (coordX, coordY) = (coordX*dimX, coordY*dimY)
      self.api.GameAction.select(coordX, coordY)
      
      self.acted = True
      
    #self.api.GameAction.make_random_unit_move()

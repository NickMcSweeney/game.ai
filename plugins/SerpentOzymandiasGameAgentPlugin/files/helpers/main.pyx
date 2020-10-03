
"""
Game agent state machine
interfaces with the ML agent to decide the action to take 
"""
class Ozymandias:
  def __init__(self, ml_agent, ml_unit, ml_build, api):
    # initialize class
    self.brain = ml_build # define the ml model to govern building logic
    self.heart = ml_unit # define the ml model to govern unit logic
    self.soul = ml_agent # define the ml model to handle overall strategy
    self.hands = api

  def take_action(self):
    # Fuzzy logic for determining the action to take
    focus = self.get_focus()

    if(focus == "unit"):
      # perform unit focus action
      self.handle_unit_action()
    elif(focus == "building"):
      # perform building focus action
      self.create()
    else:
      # focus on something
      self.focus()

  #------ ------ Getter Functions ------ ------
  def get_focus(self):
    # determine what has current focus
    pass

  #------ ------ Action Functions ------ ------
  def focus(self):
    # determine the current focus
    pass
    
  def create(self):
    # create unit or research tech at building
    pass

  def handle_unit_action(self):
    # handle the decision for unit
    # (A) go to point (B) build at point

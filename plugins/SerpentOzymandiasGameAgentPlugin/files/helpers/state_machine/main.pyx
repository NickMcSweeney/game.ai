
"""
Game agent state machine
interfaces with the ML agent to decide the action to take 
"""
class StateMachine:
  def __init__(self, ml_agent, ml_unit, ml_build, api):
    # initialize class
    self.brain = ml_build # define the ml model to govern building logic
    self.heart = ml_unit # define the ml model to govern unit logic
    self.soul = ml_agent # define the ml model to handle overall strategy
    self.hands = api

    self.free_unit = True

  def take_action(self, focus):
    # Fuzzy logic for determining the action to take
    self._focus = focus

    if(self._focus == "unit"):
      # perform unit focus action
      self.handle_unit_action()
      self.hands.GameAction.clear_selection()
    elif(self._focus == "building"):
      # perform building focus action
      self.create()
      self.hands.GameAction.clear_selection()
    else:
      # focus on something
      if (self.free_unit):
        self.hands.GameAction.get_idle_worker()
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
    self.hands.GameAction.make_random_selection()
    
  def create(self):
    # create unit or research tech at building
    self.hands.GameAction.make_random_build()

  def handle_unit_action(self):
    # handle the decision for unit
    # (A) go to point (B) build at point
    self.hands.GameAction.make_random_unit_move()

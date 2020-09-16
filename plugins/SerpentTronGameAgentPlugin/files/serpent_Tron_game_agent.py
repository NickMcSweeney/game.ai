from serpent.game_agent import GameAgent
from serpent.input_controller import KeyboardKey
import random

from .helpers.TronController import *


class SerpentTronGameAgent(GameAgent):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.frame_handlers["PLAY"] = self.handle_play

        self.frame_handler_setups["PLAY"] = self.setup_play

        self.tc = TronController()

    def setup_play(self):
        print("Starting New Game")
        self.input_controller.tap_key(KeyboardKey.KEY_RETURN)
        self.input_controller.tap_key(KeyboardKey.KEY_DOWN)
        self.input_controller.tap_key(KeyboardKey.KEY_RETURN)

    def handle_play(self, game_frame):
        print("making move")

        choice = self.tc.play(game_frame)

        if choice == 0:
            # go right
            self.input_controller.tap_key(KeyboardKey.KEY_RIGHT)
        elif choice == 1:
            # go left
            self.input_controller.tap_key(KeyboardKey.KEY_LEFT)
        else:
            # do nothing
            pass

        result = 0
        self.tc.feedback(result)

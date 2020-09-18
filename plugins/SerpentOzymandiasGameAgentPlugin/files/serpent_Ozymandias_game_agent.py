import time

from serpent.game_agent import GameAgent
from serpent.input_controller import MouseButton

class SerpentOzymandiasGameAgent(GameAgent):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.frame_handlers["PLAY"] = self.handle_play

        self.frame_handler_setups["PLAY"] = self.setup_play

    def setup_play(self):
        # define the current area of the game
        self.context = "main_menu"

        pass

    def handle_play(self, game_frame):
        if(self.context == "main_menu"):
            print("New Game")
            self.game.api.MainMenu.click_single_player()
            time.sleep(1)
            self.context = "main_menu_single_player"
        elif(self.context == "main_menu_single_player"):
            print("Single Player Game")
            self.game.api.MainMenu.click_matches()
            time.sleep(1)
            self.context = "main_menu_matches"
        elif(self.context == "main_menu_matches"):
            print("Start New Game")
            self.game.api.MainMenu.click_start_game()
            time.sleep(1)
            self.context = "playing_game"
        elif(self.context == "playing_game"):
            print("playing game")

        pass

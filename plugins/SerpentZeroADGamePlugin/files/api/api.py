from serpent.game_api import GameAPI
from serpent.input_controller import MouseButton



class ZeroADAPI(GameAPI):

    def __init__(self, game=None):
        super().__init__(game=game)

    def my_api_function(self):
        print(self.game)
        pass

    class MainMenu:
    
        @classmethod
        def click_single_player(cls):
            api = ZeroADAPI.instance

            frame = api.game.grab_latest_frame()
            preset = api.game.ocr_presets["DEFAULT"]

            api.input_controller.click_string("Single Player", MouseButton.LEFT, frame, 1, preset)
            
        @classmethod
        def click_matches(cls):
            api = ZeroADAPI.instance

            
            frame = api.game.grab_latest_frame()
            preset = api.game.ocr_presets["DEFAULT"]

            api.input_controller.click_string("Matches", MouseButton.LEFT, frame, 1, preset)
            
        @classmethod
        def click_start_game(cls):
            api = ZeroADAPI.instance

            frame = api.game.grab_latest_frame()
            preset = api.game.ocr_presets["DEFAULT"]

            api.input_controller.click_string("Start Game!", MouseButton.LEFT, frame, 1, preset)
            

    class InGame:

        @classmethod
        def my_namespaced_api_function(cls):
            api = ZeroADAPI.instance

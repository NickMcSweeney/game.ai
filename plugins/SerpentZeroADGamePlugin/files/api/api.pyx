from serpent.game_api import GameAPI
from serpent.input_controller import MouseButton
from serpent.sprite import Sprite
from serpent.sprite_locator import SpriteLocator
import serpent.cv
import serpent.ocr
import numpy as np
import skimage.io
from os import listdir
from os.path import isfile, join, abspath


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

    class Game:
        @classmethod
        def get_region_text(cls, region_name):
            api = ZeroADAPI.instance
            game_frame = api.game.grab_latest_frame()
            food_image = serpent.cv.extract_region_from_image(
                game_frame.grayscale_frame,
                api.game.screen_regions[region_name]
            )
            text = serpent.ocr.perform_ocr(food_image)
            return text
        @classmethod
        def make_random_move(cls):
            api = ZeroADAPI.instance

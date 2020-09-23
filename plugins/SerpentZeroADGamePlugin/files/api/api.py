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


    class Sparta:
        @classmethod
        def define_hoplite_sprite(cls):
            api = ZeroADAPI.instance
            
            mypath = abspath("plugins/SerpentZeroADGamePlugin/files/sprites")
            image_files = [mypath+"/"+f for f in listdir(mypath) if isfile(join(mypath, f))]
            
            image_data = [skimage.io.imread(image_file)[..., np.newaxis] for image_file in image_files]

            sprite = Sprite("HOPLITE", image_data=image_data[0])

            for image in image_data:
                sprite.append_image_data(image[..., np.newaxis])

            api.game.sprites["HOPLITE"] = sprite

        @classmethod
        def locate_perioikoi_hoplite(cls):
            api = ZeroADAPI.instance
            frame = api.game.grab_latest_frame()

            # Assuming the existance of "image"
            sprite_to_locate = Sprite("QUERY", image_data=image[..., np.newaxis])

            sprite_locator = SpriteLocator()
            location = sprite_locator.locate(sprite=sprite_to_locate, game_frame=frame)
        @classmethod
        def click_perioikoi_hoplite(cls):
            api = ZeroADAPI.instance
            frame = api.game.grab_latest_frame()

            print("sprites: ")
            print(api.game.sprites)
            print("---")

            # Assuming the existance of "image"
            #sprite_to_locate = Sprite("QUERY", image_data=image[..., np.newaxis])

            #sprite_locator = SpriteLocator()
            #location = sprite_locator.locate(sprite=sprite_to_locate, game_frame=frame)

            #api.input_controller.move(location.x,location.y,0.01)
            #api.input_controller.click(MouseButton.LEFT,0.01)
            

    class InGame:
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
        def my_namespaced_api_function(cls):
            api = ZeroADAPI.instance

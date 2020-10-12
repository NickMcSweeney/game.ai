from serpent.game_api import GameAPI
from serpent.input_controller import MouseButton
from serpent.input_controller import KeyboardKey
from serpent.sprite import Sprite
from serpent.sprite_locator import SpriteLocator
import serpent.cv
import serpent.ocr
import numpy as np
import random
import skimage.io
from os import listdir
from os.path import isfile, join, abspath


class ZeroADAPI(GameAPI):

    def __init__(self, game=None):
        super().__init__(game=game)

    def get_region_text(self, region_name):
        game_frame = self.game.grab_latest_frame()
        region_image = serpent.cv.extract_region_from_image(
            game_frame.grayscale_frame,
            self.game.screen_regions[region_name]
        )
        text = serpent.ocr.perform_ocr(region_image)
        return text
        
    def my_api_function(self):
        print(self.game)
        pass

    class MainMenu:
    
        @classmethod
        def click_single_player(cls):
            api = ZeroADAPI.instance

            frame = api.game.grab_latest_frame()
            preset = api.game.ocr_presets["DEFAULT"]

            api.input_controller.click_string("Single Player", MouseButton.LEFT, frame, 5, preset)
            
        @classmethod
        def click_matches(cls):
            api = ZeroADAPI.instance
            frame = api.game.grab_latest_frame()
            preset = api.game.ocr_presets["DEFAULT"]

            api.input_controller.click_string("Matches", MouseButton.LEFT, frame, 5, preset)
            
        @classmethod
        def click_start_game(cls):
            api = ZeroADAPI.instance

            frame = api.game.grab_latest_frame()
            preset = api.game.ocr_presets["DEFAULT"]

            api.input_controller.click_string("Start Game!", MouseButton.LEFT, frame, 5, preset)

    class GameInterface:
        @classmethod
        def get_points(cls):
            return ZeroADAPI.instance.game.points
        @classmethod
        def update_food_score(cls):
            api = ZeroADAPI.instance
            try:
                food = api.game.points["food"]
                score = int(api.get_region_text("FOOD").replace(" ", ""))
                food["change"] = food["current"] - score;
                food["current"] = score;
            except ValueError as e:
                print(e)
                print("Moving on")
        @classmethod
        def update_wood_score(cls):
            api = ZeroADAPI.instance
            try:
                wood = api.game.points["wood"]
                score = int(api.get_region_text("WOOD").replace(" ", ""))
                wood["change"] = wood["current"] - score;
                wood["current"] = score;
            except ValueError as e:
                print(e)
                print("Moving on")
        @classmethod
        def update_stone_score(cls):
            api = ZeroADAPI.instance
            try:
                stone = api.game.points["stone"]
                score = int(api.get_region_text("STONE").replace(" ", ""))
                stone["change"] = stone["current"] - score;
                stone["current"] = score;
            except ValueError as e:
                print(e)
                print("Moving on")
        @classmethod
        def update_iron_score(cls):
            api = ZeroADAPI.instance
            try:
                iron = api.game.points["iron"]
                score = int(api.get_region_text("IRON").replace(" ", ""))
                iron["change"] = iron["current"] - score;
                iron["current"] = score;
            except ValueError as e:
                print(e)
                print("Moving on")
        @classmethod
        def update_population_score(cls):
            api = ZeroADAPI.instance
            try:
                population = api.game.points["population"]
                score = api.get_region_text("POPULATION").split("/")
                population["change"] = population["current"] - int(score[0])
                population["current"] = int(score[0])
                population["total"] = int(score[1])
            except ValueError as e:
                print(e)
                print("Moving on")

    class GameAction:
        @classmethod
        def move_view(cls):
            # move the view screen by a set amount
            api = ZeroADAPI.instance

        @classmethod
        def select(cls, x, y):
            # click on coords
            ZeroADAPI.instance.input_controller.move(x=x, y=y, duration=0.05)
            ZeroADAPI.instance.input_controller.click(button=MouseButton.LEFT, duration=0.25)
            
        @classmethod
        def make_random_move(cls):
            # make a random mouse movement
            # select (a) right click location (b) left click location (c) right click drag (d) move to random location
            api = ZeroADAPI.instance
            choice = random.randrange(100)

            if(choice < 20):
                # right click location
                print("RIGHT CLICK")
                api.input_controller.click(button=MouseButton.RIGHT, duration=0.25)
            elif(choice < 40):
                # left click location
                print("LEFT CLICK")
                api.input_controller.click(button=MouseButton.LEFT, duration=0.25)
            elif(choice < 50):
                # click and drag
                print("CLICK & DRAG")
                X = random.random()*api.game.window_geometry["width"]
                Y = random.random()*api.game.window_geometry["height"]

                api.input_controller.click_down(button=MouseButton.LEFT, duration=0.25)
                api.input_controller.move(x=X, y=Y, duration=0.05)
                api.input_controller.click_up(button=MouseButton.LEFT, duration=0.25)
            else:
                # move mouse
                print("MOVE")
                X = random.random()*api.game.window_geometry["width"]
                Y = random.random()*api.game.window_geometry["height"]

                api.input_controller.move(x=X, y=Y, duration=0.25)

        @classmethod
        def make_random_unit_move(cls):
            # make a random mouse movement
            # select (a) right click location (b) left click location (c) right click drag (d) move to random location
            api = ZeroADAPI.instance
            choice = random.randrange(100)

            X = random.random()*api.game.window_geometry["width"]
            Y = random.random()*api.game.window_geometry["height"]

            api.input_controller.move(x=X, y=Y, duration=0.25)
            api.input_controller.click(button=MouseButton.RIGHT, duration=0.25)
            
        @classmethod
        def make_random_selection(cls):
            # make a random mouse movement
            # select (a) right click location (b) left click location (c) right click drag (d) move to random location
            api = ZeroADAPI.instance
            choice = random.randrange(100)

            if(choice < 60):
                # move mouse
                print("MOVE")
                X = random.random()*api.game.window_geometry["width"]
                Y = random.random()*api.game.window_geometry["height"]
                api.input_controller.move(x=X, y=Y, duration=0.25)
                
                # left click location
                print("LEFT CLICK")
                api.input_controller.click(button=MouseButton.LEFT, duration=0.25)
            else: 
                # move mouse
                print("MOVE")
                X = random.random()*api.game.window_geometry["width"]
                Y = random.random()*api.game.window_geometry["height"]
                api.input_controller.move(x=X, y=Y, duration=0.25)
                
                # click and drag
                print("CLICK & DRAG")
                X = random.random()*api.game.window_geometry["width"]
                Y = random.random()*api.game.window_geometry["height"]

                api.input_controller.click_down(button=MouseButton.LEFT, duration=0.25)
                api.input_controller.move(x=X, y=Y, duration=0.05)
                api.input_controller.click_up(button=MouseButton.LEFT, duration=0.25)
            
        @classmethod
        def make_random_build(cls):
            # make a random mouse movement
            # select (a) right click location (b) left click location (c) right click drag (d) move to random location
            api = ZeroADAPI.instance
            choice = random.randrange(4)

            keys = [KeyboardKey.KEY_Z,KeyboardKey.KEY_X, KeyboardKey.KEY_C, KeyboardKey.KEY_V]
            selection = keys[choice]
            
            api.input_controller.tap_key(selection)

        @classmethod
        def clear_selection(cls):
            #clear selection
            api = ZeroADAPI.instance
            #api.input_controller.click(button=MouseButton.RIGHT, duration=0.25)
            api.input_controller.tap_key(KeyboardKey.KEY_1)

        @classmethod
        def get_idle_worker(cls):
            # select worker
            api = ZeroADAPI.instance
            api.input_controller.tap_key(KeyboardKey.KEY_PERIOD)
            

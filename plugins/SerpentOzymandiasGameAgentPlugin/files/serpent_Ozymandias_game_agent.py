import time
import random

from serpent.game_agent import GameAgent
from serpent.input_controller import MouseButton

class SerpentOzymandiasGameAgent(GameAgent):

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.frame_handlers["PLAY"] = self.handle_play

        self.frame_handler_setups["PLAY"] = self.setup_play

    def setup_play(self):
        # define the current area of the game
        #self.context = "main_menu"
        self.context = "playing_game"

        self.points = {
            "food": 300,
            "wood": 300,
            "stone": 300,
            "iron": 300
        }

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
            time.sleep(15)
            self.context = "playing_game"
        elif(self.context == "playing_game"):
            print("playing game")
            
            try:
                food_count = int(self.game.api.Game.get_region_text("FOOD").replace(" ", ""))
                wood_count = int(self.game.api.Game.get_region_text("WOOD").replace(" ", ""))
                stone_count = int(self.game.api.Game.get_region_text("STONE").replace(" ", ""))
                iron_count = int(self.game.api.Game.get_region_text("IRON").replace(" ", ""))
                population = self.game.api.Game.get_region_text("POPULATION")

                print("Population: " + population)
                pop_arr = population.split("/")
                current_population = int(pop_arr[0])
                population_cap = int(pop_arr[1])
                print("curr pop %d / pop cap %d" % (current_population,population_cap))

                food_diff = food_count - self.points["food"]
                self.points["food"] = food_count
                wood_diff = wood_count - self.points["wood"]
                self.points["wood"] = wood_count
                stone_diff = stone_count - self.points["stone"]
                self.points["stone"] = stone_count
                iron_diff = iron_count - self.points["iron"]
                self.points["iron"] = iron_count

                print("Food count: ", food_diff)
                print("Wood count: ", wood_diff)
                print("Stone count: ", stone_diff)
                print("Iron count: ", iron_diff)
            except ValueError as e:
                print(e)
                print("Moving on")

            #self.input_controller.move(random.randrange(1000),random.randrange(800),0.1)
            #self.input_controller.click(MouseButton.RIGHT)

        pass

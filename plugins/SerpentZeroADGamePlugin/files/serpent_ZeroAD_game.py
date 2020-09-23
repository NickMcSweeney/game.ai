from serpent.game import Game

from .api.api import ZeroADAPI

from serpent.utilities import Singleton




class SerpentZeroADGame(Game, metaclass=Singleton):

    def __init__(self, **kwargs):
        kwargs["platform"] = "executable"

        kwargs["window_name"] = "0 A.D."

        
        
        kwargs["executable_path"] = "/usr/bin/0ad"
        
        

        super().__init__(**kwargs)

        self.api_class = ZeroADAPI
        self.api_instance = None

    @property
    def screen_regions(self):
        regions = {
            "FOOD": (3, 33, 33, 100), 
            "WOOD": (3, 128, 33, 194),
            "STONE": (3, 222, 33, 290),
            "IRON": (3, 316, 33, 375),
            "POPULATION": (2, 405, 34, 492),
            "SELECT_FREE_UNIT": (1031, 455, 1003, 426)
        }

        return regions

    @property
    def ocr_presets(self):
        presets = {
            "DEFAULT": {
                "extract": {
                    "gradient_size": 3,
                    "closing_size": 10
                },
                "perform": {
                    "scale": 16,
                    "order": 3,
                    "horizontal_closing": 1,
                    "vertical_closing": 1
                }
            }
        }

        return presets

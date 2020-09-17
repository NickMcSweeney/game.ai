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
            "START_GAME_1": (190, 72, 218, 288),
            "START_GAME_2": (192, 300, 219, 536),
            "START_GAME_3": (1005, 1756, 1033, 1896),
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

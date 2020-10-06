from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    # game plugin
    #Extension("plugins.SerpentZeroADGamePlugin.files.serpent_ZeroAD_game",
    #    ["plugins/SerpentZeroADGamePlugin/files/serpent_ZeroAD_game.py"],
    #    include_dirs=[],
    #    libraries=[],
    #    library_dirs=[]),
    # API for game
    Extension("plugins.SerpentZeroADGamePlugin.files.api.api",
        ["plugins/SerpentZeroADGamePlugin/files/api/api.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # game plugin
    #Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.serpent_Ozymandias_game_agent", 
    #    ["plugins/SerpentOzymandiasGameAgentPlugin/files/serpent_Ozymandias_game_agent.py"],
    #    include_dirs=[],
    #    libraries=[],
    #    library_dirs=[]),
    # classifier
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.classifier.main", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/classifier/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # statemachine
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.state_machine.state_machine", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/state_machine/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # utility functions
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.utils.utils", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/utils/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
]
setup(
    name="Global Cython compiler script",
    ext_modules=cythonize(extensions, annotate=True),
    zip_safe=False,
)


from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    # game plugin
    Extension("files.serpent_Ozymandias_game_agent", 
        ["files/serpent_Ozymandias_game_agent.py"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # statemachine
    Extension("files.helpers.state_machine.state_machine",
        ["files/helpers/state_machine/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # utility functions
    Extension("files.helpers.utils.utils", 
        ["files/helpers/utils/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
]
setup(
    name="Ozymandias Game Agent Cython compiler script",
    ext_modules=cythonize(extensions),
    zip_safe=False,
)


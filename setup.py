from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    # API for game
    Extension("plugins.SerpentZeroADGamePlugin.files.api.api",
        ["plugins/SerpentZeroADGamePlugin/files/api/api.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # classifier
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.classifier.main", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/classifier/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # rf learner
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.rf_learner.*", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/rf_learner/*.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # statemachine
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.state_machine.main", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/state_machine/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # utility functions
    Extension("plugins.SerpentOzymandiasGameAgentPlugin.files.helpers.utils.main", 
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/utils/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
]
setup(
    name="Global Cython compiler script",
    ext_modules=cythonize(extensions, annotate=False),
    zip_safe=False,
)


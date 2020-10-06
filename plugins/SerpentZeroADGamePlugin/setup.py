from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    # game plugin
    Extension("*", ["files/serpent_ZeroAD_game.py"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # API for game
    Extension("*", ["files/api/api.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
]
setup(
    name="Zero AD Game Plugin",
    ext_modules=cythonize(extensions),
    zip_safe=False,
)


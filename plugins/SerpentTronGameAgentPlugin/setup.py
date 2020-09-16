from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    Extension(
        "TronController",
        ["clibs/TronController.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[],
    ),
    # Everything but TronController.pyx is included here.
    Extension("*", ["clibs/*.pyx"], include_dirs=[], libraries=[], library_dirs=[]),
]
setup(
    name="GameAI C/C++/Cython packages",
    ext_modules=cythonize(extensions),
)

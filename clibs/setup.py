#from setuptools import setup
#from Cython.Build import cythonize

#setup(
#    name='Cython/C/C++ Libraries',
#    ext_modules=cythonize("*.pyx"),
#    zip_safe=False,
#)

from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    # Game API
    Extension("api", ["api/main.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # Game Agent Helpers
    Extension("helpers", ["helpers/*.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
    # Everything but primes.pyx is included here.
    Extension("*", ["*.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
]
setup(
    name="Game C/Cython/C++ Module",
    ext_modules=cythonize(extensions),
    zip_safe=False,
)


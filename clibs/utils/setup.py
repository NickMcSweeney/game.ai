from setuptools import setup
from Cython.Build import cythonize

setup(
    name='Cython/C/C++ Libraries',
    ext_modules=cythonize("*.pyx"),
    zip_safe=False,
)

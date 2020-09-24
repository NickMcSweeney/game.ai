from setuptools import setup
from Cython.Build import cythonize

setup(
    name='Helpers',
    ext_modules=cythonize("main.pyx"),
    zip_safe=False,
)


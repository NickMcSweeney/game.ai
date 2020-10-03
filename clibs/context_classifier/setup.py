from setuptools import Extension, setup
from Cython.Build import cythonize

extensions = [
    # context classification cnn
    Extension("main", ["src/main.pyx"],
        include_dirs=["libs"],
        libraries=[],
        library_dirs=[]),
    # context classification libraries
    Extension("*", ["libs/*.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[]),
]
setup(
    name="Zero AD CNN for context classifiaction",
    ext_modules=cythonize(extensions),
    zip_safe=False,
)


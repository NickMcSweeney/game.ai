from Cython.Build import cythonize

extensions = [
    Extension(
        "ZeroADAPI",
        ["plugins/SerpentZeroADGamePlugin/files/api/*.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[],
    ),
    Extension(
        "OzymandiasHelpers",
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/helpers/*.pyx"],
        include_dirs=[],
        libraries=[],
        library_dirs=[],
    ),
    Extension(
        "OzymandiasHelpers",
        ["plugins/SerpentOzymandiasGameAgentPlugin/files/ml_models/*.pyx"],
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

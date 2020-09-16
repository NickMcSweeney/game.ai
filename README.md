# Video Game Ai

> With [Serpent.Ai](https://github.com/SerpentAI/SerpentAI)

This a project building a RTS game AI (for now -- maybe others later) using the SerpentAI Framework. The initial goal is to get a version working with 0 A.D. and potentially extend it to work in an Age of Empire game.
This is starting with 0 A.D. because it is OpenSource and hopefully is will make it a bit easier to work with.

## Packages

#### Game Package: [ZeroAD](https://play0ad.com/)

> Open Source, cross-platform, realtime strategy game

#### Game Agent Package: Ozymandias

> AI for playing *0 A.D.*

---

## TODO:

- [ ] setup testing (done using poetry integration)
- [ ] setup subpackage structure
- [ ] define screen regions

---

## Setup

This project used [Poetry](https://github.com/python-poetry/poetry) for managing python version (plus other things).

This project uses the SerpentAI framework and therefore requires **Redis** to be installed and running on your computer. Go [here](https://github.com/SerpentAI/SerpentAI/wiki/Linux-Installation-Guide#redis) for more info.

> If you don't want to bother with all this, just run the `setup.sh` script, it will perform all the following tasks. At that point you are free to *Launch* the AI

+ In *game.ai* `git pull` latest version

#### First Time Setup

+ Run `poetry env use PATH_TO_PYTHON_3.6.5`
    - if you are using **pyenv** to manage versions
    - `pyenv install 3.6.5`
    - `pyenv local 3.6.5`
    - `poetry env use $(pyenv which python)`

+ Run `poetry update && poetry install`
+ Install Tesseract and run `poetry run serpent setup ocr` for language support
+ Run `poetry run serpent setup ml` to enable/install tensorflow

#### Generaly getting started

+ Run `poetry run serpent update` -- this makes sure the framework is up to date

### Launching

+ Run in *terminal 1* `poetry run serpent launch ZeroAD` -- this starts the game running
+ Run in *terminal 2* `poetry run serpent play ZeroAD SerpentOzymandiasGameAgent` -- This starts the Ai

---

## Editing

I am experimenting using Cython with this project as well as C/C++ libraries. Cython will allow interation with C/C++ and compiles Python code (`.pyx`) into C.


## Testing

Testing is handled by Poetry using `pytest`.

As this *should* be a performance critical application, testing will focus on speed using `pytest-benchmark` as well as .

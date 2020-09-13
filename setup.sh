#!/bin/sh

# Run first time project setup

git pull &&\\

echo "\n\nUp to date with GIT\n";

pyenv install 3.6.5 && pyenv local 3.6.5 && poetry env use $(pyenv which python) &&\\

echo "\n\n Py ENV setup.\n Setting up poetry...\n" &&\\

poetry update && poetry install &&\\

echo "\n\n Seting up serpent \n\n" &&\\

poetry run serpent setup ocr && poetry run serpent setup ml && poetry run serpent update &&\\

echo "\n\n==== Completed Project Setup ====\n"

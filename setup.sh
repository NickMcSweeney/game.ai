#!/bin/sh

# Run first time project setup

git pull &&\\

echo ""
echo "Up to date with GIT";

pyenv install -sv 3.6.5 && pyenv local 3.6.5 && poetry env use $(pyenv which python) &&\\

echo ""
echo "Py ENV setup./n Setting up poetry..." &&\\

poetry update && poetry install &&\\

echo ""
echo "Seting up serpent" &&\\

poetry run serpent setup ocr && poetry run serpent setup ml && poetry run serpent update &&\\

echo ""
echo "==== Completed Project Setup ===="

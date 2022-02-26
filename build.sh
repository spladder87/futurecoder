#!/bin/bash

set -eux

rm -rf dist || true
mkdir -p dist/course/

poetry run python -m translations.generate_po_file
poetry run python -m core.generate_static_files

cd frontend
REACT_APP_LANGUAGE=$FUTURECODER_LANGUAGE CI=false npm run build
cd ..

cp -r frontend/build/* dist/course/

npx -y --package=node-sass -- node-sass homepage/static/css -o dist/course
cp -r homepage/* dist/

#!/usr/bin/env bash

./build.sh

docker volume create {{ cookiecutter.package_name|lower }}-output

docker run --rm \
        --memory=4g \
        -v $(pwd)/test/:/input/ \
        -v {{ cookiecutter.package_name|lower }}-output:/output/ \
        {{ cookiecutter.package_name|lower }}

docker run --rm \
        -v {{ cookiecutter.package_name|lower }}-output:/output/ \
        {{ cookiecutter.docker_base_container }} cat /output/metrics.json | python -m json.tool

docker volume rm {{ cookiecutter.package_name|lower }}-output

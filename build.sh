#!/bin/bash

version="0.0.2"
docker build --no-cache=True -t hellofresh/kitchen:$version -f Dockerfile .

#!/bin/bash
docker build -t my_docker_env -f config/my_docker_env.Dockerfile .
docker run -ti -v ${PWD}:/usr/local/bin/my_docker_env -p 8888:8888 my_docker_env -v /dev/video0:/dev/video0
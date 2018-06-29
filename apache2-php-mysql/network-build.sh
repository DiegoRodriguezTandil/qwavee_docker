#!/bin/bash
docker network create -d bridge qwavee-docker-network \
  --subnet=172.28.0.0/16 \
  --ip-range=172.28.5.0/24 \
  --gateway=172.28.5.1 \
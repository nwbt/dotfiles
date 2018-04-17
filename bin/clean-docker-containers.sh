#! /bin/sh
#
# clean-docker-containers.sh
# Copyright (C) 2017  <@C02TF7AMGTFM>
#
# Distributed under terms of the MIT license.
#

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q) 


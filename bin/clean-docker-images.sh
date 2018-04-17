#! /bin/sh
#
# clean-docker-images.sh
# Copyright (C) 2017  <@C02TF7AMGTFM>
#
# Distributed under terms of the MIT license.
#


docker rmi $(docker images -a -q)

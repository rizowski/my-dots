#!/bin/bash
source $PWD/scripts/helpers.sh

npm i -g yarn

YARN_VERSION="$(yarn --version)"
print "YARN Version: $YARN_VERSION"

yarn global add nodemon cwtail updtr serverless

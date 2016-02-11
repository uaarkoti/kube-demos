#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

desc "Update the deployment"
run "cat $(relative deployment.yaml) | sed 's/ v1/ v2/g' | kubectl apply -f- --validate=false"

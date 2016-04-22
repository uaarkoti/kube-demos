#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

desc "Check hostnames service"
run "kubectl --namespace=demos get svc hostnames"
IP=$(kubectl --namespace=demos get svc hostnames \
    -o go-template='{{.spec.clusterIP}}')

desc "Create another pod to access hostnames service"
run "cat curlpod.yaml"
run "kubectl --namespace=demos create -f curlpod.yaml"

desc "See what happens when you nslookup the service name"
run "kubectl --namespace=demos exec -it curlpod nslookup hostnames"
run "kubectl --namespace=demos exec -it curlpod nslookup hostnames.demos"
run "kubectl --namespace=demos exec -it curlpod nslookup hostnames.demos.svc.cluster.local"

desc "See what happens when you access the service name"
run "kubectl --namespace=demos exec -it curlpod \\
     curl hostnames.demos
     "


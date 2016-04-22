#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

if kubectl --namespace=demos get deployments hostnames >/dev/null 2>&1; then
    desc "Revisit our deployment"
    run "kubectl --namespace=demos get deployment hostnames"
else
    desc "Run some pods under a Deployment"
    run "kubectl --namespace=demos run hostnames \\
        --image=gcr.io/google_containers/serve_hostname:1.1 --replicas=5"
fi

desc "Have a look at the pods"
run "kubectl --namespace=demos get pods"

desc "Expose the Deployment as a Service"
run "kubectl --namespace=demos expose deployment hostnames \\
    --port=80 --target-port=9376"

desc "Have a look at the service"
run "kubectl --namespace=demos describe svc hostnames"

IP=$(kubectl --namespace=demos get svc hostnames \
    -o go-template='{{.spec.clusterIP}}')
desc "See what happens when you access the service's IP"
run "gcloud compute ssh --zone=us-central1-b $SSH_NODE --command '\\
    for i in \$(seq 1 10); do \\
        curl --connect-timeout 1 -s $IP && echo; \\
    done \\
    '"
run "gcloud compute ssh --zone=us-central1-b $SSH_NODE --command '\\
    for i in \$(seq 1 500); do \\
        curl --connect-timeout 1 -s $IP && echo; \\
    done | sort | uniq -c; \\
    '"

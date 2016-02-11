#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

desc "Run some pods in a job"
run "cat $(relative job.yaml)"
run "kubectl --namespace=demos create -f $(relative job.yaml)"

desc "See what we did"
run "kubectl --namespace=demos describe job sleeper-job"

desc "See pods run"
while [ "$(kubectl --namespace=demos get job sleeper-job -o go-template='{{.status.succeeded}}')" != 15 ]; do
	run "kubectl --namespace=demos get pods -l demo=jobs"
	run "kubectl --namespace=demos describe job sleeper-job"
done

desc "Final status"
run "kubectl --namespace=demos get pods --show-all -l demo=jobs --sort-by='{.status.phase}'"

#!/bin/bash

. $(dirname ${BASH_SOURCE})/../util.sh

IP=$(kubectl --namespace=demos get svc hostnames \
    -o go-template='{{.spec.clusterIP}}')
desc "See what happens when you access the service's IP"

tmux new -d -s my-session \
    "$(dirname ${BASH_SOURCE})/split1_lhs.sh" \; \
    split-window -h -d "sleep 10; $(dirname $BASH_SOURCE)/split1_rhs.sh" \; \
    attach \;

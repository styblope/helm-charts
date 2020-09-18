#!/bin/bash

# Package a chart and update the helm repo

if [ "$1" == "" ]; then
    echo "Usage: $(basename $0) <chart directory>"
    exit 1
fi

echo "Packaging chart $1"
helm package --save=false -d repo $1 

echo "Updating Helm repo index"
cd repo
helm repo index --url https://raw.githubusercontent.com/styblope/helm-charts/master/repo .
cd ..

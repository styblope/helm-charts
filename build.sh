#!/bin/bash

if [ "$1" == "" ]; then
    echo "Usage: $(basename $0) [directory]..."
    exit 1
fi

echo "Packaging chart $1"
helm package $1
echo "Updating Helm repo index"
helm repo index --url https://raw.githubusercontent.com/styblope/helm-charts/master .

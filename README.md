# helm-charts

## How to publish new chart package

Package the chart

    cd <new chart directory>
    helm package .
    mv <new package.tgz> ..

Update repo index

    cd ..
    helm repo index --url https://raw.githubusercontent.com/styblope/helm-charts/master

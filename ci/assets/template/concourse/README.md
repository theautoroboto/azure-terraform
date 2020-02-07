# Deploy

```With ops files and using credhub```

```
bosh -e fog -d concourse deploy ./pcf-tile-configurator/bosh-deployments/concourse/concourse.yml -l ./pcf-swiss-army/master-params/fog-params.yml -o ./pcf-tile-configurator/bosh-deployments/concourse/ops/cloud-enb.yml -o ./pcf-tile-configurator/bosh-deployments/concourse/ops/concourse-credhub.yml
```

```For all other foundations```

```
bosh -e FOUNDATION -d concourse-workers deploy ./pcf-tile-configurator/bosh-deployments/concourse/workers.yml -l ./pcf-swiss-army/master-params/FOUNDATION-params.yml -o ./pcf-tile-configurator/bosh-deployments/concourse/ops/concourse-proxy.yml



# Configure new team

```
fly -t fog login -n main -c https://concourse.sys.domain.com -u concourse -p 

fly -t fog login -n cloud-enablement -c https://concourse.sys.domain.com -u cloudenb -p pYeLuLIzbzF3lMwT6jTs1nMLRPV4pC
fly -t fog set-pipeline -p hello-credhub -c hello-credhub.yml
```

# Test Credhub integration


# Push pipelines

# Notes
Cloud Enablement user is stored in credhub under ((/p-bosh/credhub/cloud_enablement))

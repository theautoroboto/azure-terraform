#!/bin/bash
# Pre-reqs
# uaac
# om
# bosh
# az
# jq
# texplate
# terraform
#################################
# Required Environment variables
# ARM_ACCESS_KEY  -- 
# ARM_CLIENT_ID
# ARM_CLIENT_SECRET
# TF_VAR_client_id
# TF_VAR_client_secret
# ARM_SUBSCRIPTION_ID
# ARM_TENANT_ID
# TF_VAR_subscription_id
# TF_VAR_tenant_id
# pivnet_token

#################################
# These templates are configured for Availability Sets
# They will need to be changed for Availability Sets
##############################
# VARS
##############################
    system_domain="sys.domain.net"
    director_name="director.domain.net"
    opsman_url="https://opsman.domain.net"
    password=''
    OPSMAN_DECRYPTION_PASSPHRASE=""

    #PKS
    pks_automation_acct="automated-client"
    pks_automation_pass="WJ2Xktj2MdbuR6rh"
    pks_api="api.pks.domain.net"

    ##LDAP
    ldap_host="server.domain.com"
    ldap_group_search_base_dn="OU=Groups,DC=domain,DC=com"
    ldap_user_search_base_dn="OU=Commercial_Users,DC=domain,DC=com"
    ldap_user_username="azpcfldapsvcnp@domain.com"
    ldap_user_password='sumpasswerd'
    ldap_admin_group_dn="CN=sum_group,OU=Groups,DC=domain,DC=com"
    ldap_bind_dn="CN=PCF LDAP user,OU=Service Accounts,DC=domain,DC=com"

    #PRODUCT NAMES
    azure_log_analytics_product_slug=="azure-log-analytics-nozzle"
    cloudcache_product_slug="p-cloudcache"
    azure_sb_product_slug="azure-service-broker"
    pks_product_slug="pivotal-container-service"
    spring_product_slug="p-spring-cloud-services"
    harbor_product_slug="harbor-container-registry"
    pas_product_slug="cf"
    pasw_product_slug="pas-windows"
    sso_product_slug="Pivotal_Single_Sign-On_Service"
    mysql_product_slug="pivotal-mysql"
    splunk_product_slug="splunk-nozzle"
    credhub_sb_product_slug="credhub-service-broker"
    concourse_product_slug="p-concourse"
    healthwatch_product_slug="p-healthwatch"
    rabbitmq_product_slug="p-rabbitmq"
    redis_product_slug="p-redis"
    metrics_product_slug="apm"

    #PRODUCT VERSIONS
    azure_log_analytics_version_regex=^1\.4\..*$
    cloudcache_version_regex=^1\.9\..*$
    harbor_version_regex=^1\.8\..*$
    credhub_sb_version_regex=^1\.4\..*$
    mysql_version_regex=^2\.7\..*$
    spring_version_regex=^3\.1\..*$
    redis_version_regex=^2\.2\..*$
    pks_version_regex=^1\.4\.0.*$
    pas_version_regex=^2\.6\..*$
    pasw_version_regex=^2\.6\..*$
    sso_version_regex=^1\.10\..*$
    splunk_version_regex=^1\.1\..*$
    metrics_version_regex=^1\.6\..*$
    rabbitmq_version_regex=^1\.17\..*$
    azure_sb_version_regex=^1\.11\..*$
    concourse_version_regex=^5\..\..*$
    concourse_stemcell_regex=^315\..*$
    gogs_stemcell="250.79"
    healthwatch_version_regex=^1\.7\..*$

    #CREDHUB
    credhub_version="2.5.9"
    mysql_version="36.19.0"
    uaa_version="74.12.0"
    credhub_static_ip="x.x.33.10"
    credhub_mySQL_proxy_ip="x.x.33.11"
    os_conf_version="21.0.0"
    bbr_sdk_version="1.17.2"
    prometheus_version="25.0.0"
    postgres_version="38"
    bpm_version="1.1.5"
    routing_version="0.192.0"

    # Formatting colors
    RED='\033[0;31m'
    NC='\033[0m'
    BLACK='\033[0;30m'
    GREEN='\033[0;32m'
    BLUE='\033[0;34m'
    WHITE='\033[1;37m'
    WoB='\033[37;44m' #White On Blue
    BoW='\033[30;43m'

    #OM Config
    export OM_TARGET=$opsman_url
    #SAML ONLY
        export OM_CLIENT_ID="om-admin"
        export OM_CLIENT_SECRET="${password}"
    #NON-SAML
        # export OM_CLIENT_ID="om-admin"
        # export OM_CLIENT_SECRET="${password}"

    export AZURE_STORAGE_ACCOUNT="Enter account here"
    #(Storage access_key)
    export ARM_ACCESS_KEY=""
    #(client_id)azppeast-pcf-app
    export ARM_CLIENT_ID=""
    #(client_secret)
    export ARM_CLIENT_SECRET=""
    #(just the subscription)
    export ARM_SUBSCRIPTION_ID=""
    #(tenant_id)
    export ARM_TENANT_ID=""
    export TF_VAR_client_id=
    export TF_VAR_client_secret="t8+"
    export TF_VAR_subscription_id=
    export TF_VAR_tenant_id

    export pivnet_token=""

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# START OF MENU SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# END OF MENU SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    set_the_stage(){
        terraform_opsman
        fresh_opsman
        download_pas
        download_pasw
        download_rabbitmq
        download_healthwatch
        download_harbor
        download_spring
        download_metrics
        download_splunk
        download_sso
        download_azure_sb
        download_mysql
        download_credhub_sb
        download_redis
        download_pks
        download_cloudcache
        pause
    }

    terraform_all(){
        terraform_opsman
        terraform_product pas
        terraform_product pasw
        terraform_product healthwatch
        terraform_product harbor
        terraform_product azure_sb
        terraform_product splunk
        terraform_product redis
        # terraform_product mysql
        terraform_product pks
        terraform_product cloudcache
        pause
    }

    download_all(){
        download_pas
        download_pasw
        download_product rabbitmq $rabbitmq_product_slug $rabbitmq_version_regex
        download_product healthwatch $healthwatch_product_slug $healthwatch_version_regex
        download_product harbor $harbor_product_slug $harbor_version_regex
        download_product spring $spring_product_slug $spring_version_regex
        download_product metrics $metrics_product_slug $metrics_version_regex
        download_product splunk $splunk_product_slug $splunk_version_regex
        download_product sso $sso_product_slug $sso_version_regex
        download_product azure_sb $azure_sb_product_slug $azure_sb_version_regex
        # download_product mysql $mysql_product_slug $mysql_version_regex
        download_product credhub_sb $credhub_sb_product_slug $credhub_sb_version_regex
        download_product redis $redis_product_slug $redis_version_regex
        download_product cloudcache $cloudcache_product_slug $cloudcache_version_regex
        download_product pks $pks_product_slug $pks_version_regex
        pause
    }

    configure_all(){
        
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING PAS~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product pas
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING PASW~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product pasw
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING RABBIT MQ~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product rabbitmq
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING HEALTHWATCH~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product healthwatch
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING HARBOR~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product harbor
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING METRICS~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_metrics
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING SSO~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_sso
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING SPLUNK~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product splunk
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING AZURE SERVICE BROKER~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product azure_sb
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING CREDHUB SERVICE BROKER~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_credhub_sb
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING MYSQL~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product mysql
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING REDIS~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product redis
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING SPRING SERVICES~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_spring
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~STARTING PIVOTAL CLOUD CACHE~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        config_product cloudcache
        # echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        # echo -e  "${WoB}~~~~~~~~STARTING PKS~~~~~~~~${NC}"
        # echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        # config_product pks
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~EVERYTHING HAS COMPLETED~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        pause
    }

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# START OF TERRAFORM SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    terraform_opsman(){
        echo "==================================================================================================================="
        echo "= If this step fails, you may need to add the cert to your trusted store                                          ="
        echo "= url=releases.hashicorp.com                                                                                      ="
        echo "= openssl s_client -showcerts -connect $url:443</dev/null 2>/dev/null | openssl x509 -outform PEM > /tmp/$url.crt ="
        echo "= sudo mv /tmp/$url.crt /usr/local/share/ca-certificates                                                          ="
        echo "= sudo update-ca-certificates --fresh                                                                             ="
        echo "==================================================================================================================="
        cd ../terraforming-opsman
        echo -e  "${BoW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${BoW}~~~~~Terraforming OpsMan~~~~~${NC}"
        echo -e  "${BoW}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        terraform init
        terraform apply -auto-approve

        cd ../scripts
    }
    terraform_product(){
        cd ../terraforming-${1}
        echo -e "${BoW}~~~~~Terraforming ${1}~~~~~${NC}"
        terraform init
        terraform apply -auto-approve
        cd ../scripts
    }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# END OF TERRAFORM SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# All the downloads
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    download_product(){
        # download_product product product_slug version_regex
        product=$1
        product_slug=$2
        version_regex=$3
        echo "Downloading ${product} from Pivnet"
        om -k download-product --output-directory . --pivnet-api-token $pivnet_token --pivnet-file-glob "*.pivotal" --pivnet-product-slug $product_slug --product-version-regex $version_regex --stemcell-iaas azure
        echo "Uploading ${product} to OpsMan"
        if [[ $product_slug == *"spring"* ]]; then
            om -k upload-product -p *"spring"*.pivotal
        else
            om -k upload-product -p "$product_slug"*.pivotal
        fi

        echo "Uploading ${product} Stemcell to OpsMan"
        om -k upload-stemcell -s *.tgz
        echo "Staging ${product}"

        if [[ $product_slug == *"spring"* ]]; then
            om -k stage-product --product-name "p_spring-cloud-services" --product-version $(om tile-metadata --product-path *"spring"*.pivotal --product-version true)
        else
            om -k stage-product --product-name "$product_slug"  --product-version $(om tile-metadata --product-path "$product_slug"*.pivotal --product-version true)
        fi

        echo "Deleting ${product} files"
        rm "$product_slug"*.pivotal
        rm *.tgz
    }
    download_pas(){
        echo "Downloading PAS from Pivnet"
        om -k download-product --output-directory . --pivnet-api-token $pivnet_token --pivnet-file-glob "cf*.pivotal" --pivnet-product-slug $pas_product_slug --product-version-regex $pas_version_regex --stemcell-iaas azure
        echo "Uploading PAS to OpsMan"
        om -k upload-product -p "$pas_product_slug"-*.pivotal
        echo "Uploading PAS Stemcell to OpsMan"
        om -k upload-stemcell -s *.tgz
        echo "Staging PAS"
        om -k stage-product --product-name cf --product-version $(om tile-metadata --product-path "$pas_product_slug"-*.pivotal --product-version true)
        echo "Deleting PAS files"
        rm "$pas_product_slug"-*.pivotal
        rm *.tgz
    }
    download_pasw(){
        mkdir downloads
        echo "Downloading PASW from Pivnet"
        om -k download-product --output-directory ./downloads --pivnet-api-token $pivnet_token --pivnet-file-glob "*.pivotal" --pivnet-product-slug $pasw_product_slug --product-version-regex $pasw_version_regex --stemcell-iaas azure
        om -k download-product --output-directory ./downloads --pivnet-api-token $pivnet_token --pivnet-file-glob "winfs-*.zip" --pivnet-product-slug $pasw_product_slug --product-version-regex $pasw_version_regex
        
        unzip -o ./downloads//winfs-*.zip -d ./downloads/
        chmod +x ./downloads/winfs-injector-linux
        echo "Injecting Tile"
        ./downloads/winfs-injector-linux --input-tile ./downloads/*.pivotal --output-tile ./downloads/pasw-injected.pivotal
        
        echo "Uploading PASW to OpsMan"
        om -k upload-product -p ./downloads/pasw-injected.pivotal
        echo "Uploading PASW Stemcell to OpsMan"
        om -k upload-stemcell -s ./downloads/*.tgz
        echo "Staging PASW"
        om -k stage-product --product-name "$pasw_product_slug" --product-version $(om tile-metadata --product-path ./downloads/pasw-injected.pivotal --product-version true)
        echo "Deleting PASW files"
        rm -rf ./downloads
    }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# End of Downloads
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# START OF INSTALL SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    fresh_opsman (){
        
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~Configuring OpsMan~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "Downloading state"
        az storage blob download -c terraform -f ../yourstate.tfstate -n your-subscription/yourstate.tfstate

        ##############################
        # Configure OpsMan Auth
        ##############################
        #NON-SAML
            # echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
            # echo -e  "${WoB}~~~~~~~~Setting OpsMan INTERNAL Auth~~~~~~~~${NC}"
            # echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
            # om -k configure-authentication --decryption-passphrase "${OPSMAN_DECRYPTION_PASSPHRASE}" -u admin -p "${password}"

        #SAML
            echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
            echo -e  "${WoB}~~~~~~~~Setting OpsMan SAML Auth~~~~~~~~${NC}"
            echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
            om -k configure-saml-authentication -c <(texplate execute ../ci/assets/template/opsman.yml -f <(jq -e --raw-output '.outputs | map_values(.value)' ../yourstate.tfstate) -o yaml)

        ##############################
        # Create UAA User for om
        # gem install cf-uaac
        ##############################
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~Creating local om-admin user~~~~~~~~${NC}"
        echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
        echo "Remember, you need uaac cli"
        echo "Client ID is opsman"
        echo "Client secret is blank"
        uaac target $opsman_url/uaa/ --skip-ssl-validation
        echo "You will need to access {$opsman_url}/uaa/passcode for your passcode"
        uaac token sso get
        uaac client add om-admin --authorized_grant_types client_credentials --authorities opsman.admin --secret $password

        #Setting new SSL
            echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
            echo -e  "${WoB}~~~~~~~~Adding Certificate~~~~~~~~${NC}"
            echo -e  "${WoB}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${NC}"
            om -k update-ssl-certificate --private-key-pem "$(jq -e --raw-output '.outputs.ssl_private_key.value' ../yourstate.tfstate)" --certificate-pem "$(jq -e --raw-output '.outputs.ssl_cert.value' ../yourstate.tfstate)"
        pause
    }

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# All the Configs
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    config_product(){
        echo -e  "${WoB}~~~~~~~~Downloading ${1} state~~~~~~~~~${NC}"
        az storage blob download -c terraform -f ../yourstate.tfstate -n your-subscription/yourstate.tfstate
        om -k configure-product -c <(texplate execute ../ci/assets/template/${1}-config.yml -f <(jq -e --raw-output '.outputs | map_values(.value)' ../yourstate.tfstate) -o yaml)
    }
    install_director (){ 
        echo -e  "${WoB}~~~~~~~~Downloading state~~~~~~~~${NC}"
        az storage blob download -c terraform -f ../yourstate.tfstate -n your-subscription/yourstate.tfstate
        om -k configure-director --config <(texplate execute ../ci/assets/template/director-config.yml -f <(jq -e --raw-output '.outputs | map_values(.value)' ../yourstate.tfstate) -o yaml) || true
    }
    config_credhub_sb(){
        om -k configure-product -c ../ci/assets/template/credhub_sb-config.yml
    }
    config_spring(){
        om -k configure-product -c ../ci/assets/template/spring-config.yml
    }
    config_metrics(){
        om -k configure-product -c ../ci/assets/template/metrics-config.yml
    }
    config_sso(){
        om -k configure-product -c ../ci/assets/template/sso-config.yml
    }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# End Of Configs
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Misc
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    docker_copy(){

        #### TODO -- Create a default project (pcf-admins) to add images to
        docker pull harbor.pks.domain.com/pcf-admins/clitools
        docker login -u admin -p dfDBvknjVKR35WRS harbor.pks.domain.com
        docker tag harbor.pks.domain.com/pcf-admins/clitools harbor.pks.domain.com/pcf-admins/clitools
        docker push harbor.pks.domain.com/pcf-admins/clitools

    }
    install_gogs(){
        director_login
        wget https://s3.amazonaws.com/gogs-boshrelease/compiled-releases/gogs/gogs-5.5.1-ubuntu-xenial-250.9-20190303-095820-715799658-20190303095823.tgz -O ../gogs.tgz
        bosh upload-release ../gogs.tgz
        om -k download-product --output-directory ../ --pivnet-api-token $pivnet_token --pivnet-file-glob "*azure*.tgz" --pivnet-product-slug stemcells-ubuntu-xenial --product-version $gogs_stemcell
        bosh upload-stemcell ../*azure*.tgz
        bosh -d gogs deploy ../ci/assets/template/gogs/gogs-basic.yml -n \
        -v gogs-uri=gogs.sys.domain.com \
        --vars-store gogs-creds.yml

        bosh -d gogs run-errand gogs-admin

        rm ../*azure*.tgz
        gogs_ip=$(bosh -d gogs vms --json | jq -e --raw-output '.Tables[].Rows[] | select(.instance|test("gogs")) | .ips')
        # git remote set-url --add --push origin "https://${gogs_ip}/az-pcf-fog.git"
        git config http.sslVerify false

        git remote add origin https://${gogs_ip}/az-pcf-fog.git
        git config credential.https://x.x.38.18.username gogs
        git config credential.https://x.x.38.18.password sumP@55werd
        git push 
        git remote set-url --delete --push origin "https://${gogs_ip}/az-pcf-fog.git"

    }
    install_concourse-basic(){
        director_login
        echo "Downloading concourse from Pivnet"
        om -k download-product --output-directory ../ --pivnet-api-token $pivnet_token --pivnet-file-glob "*.tgz" --pivnet-product-slug $concourse_product_slug --product-version-regex $concourse_version_regex
        echo "Downloading stemcell from pivnet"
        om -k download-product --output-directory ../ --pivnet-api-token $pivnet_token --pivnet-file-glob "*azure*.tgz" --pivnet-product-slug stemcells-ubuntu-xenial --product-version-regex $concourse_stemcell_regex
        echo "Downloading Postgres from GitHub"
        wget "https://bosh.io/d/github.com/cloudfoundry/postgres-release?v=${postgres_version}" -O ../postgres.tgz
        echo "Downloading bpm"
        wget "https://bosh.io/d/github.com/cloudfoundry-incubator/bpm-release?v=1.0.4" -O bpm.tgz
        echo "Uploading Postgres release director"
        bosh -e useast2 upload-release ../postgres.tgz
        echo "Uploading bpm release director"
        bosh -e useast2 upload-release ../bpm.tgz
        echo "Uploading concourse Stemcell to director"
        bosh -e useast2 upload-stemcell ../*azure*.tgz
        echo "Uploading concourse release director"
        bosh -e useast2 upload-release ../*concourse*.tgz
        echo "Deleting downloaded concourse files"
        rm ../*.tgz
        pause
        bosh -d concourse deploy ../ci/assets/template/concourse/concourse-basic.yml -n
        concourse_ip=$(bosh -d concourse vms --json | jq -e --raw-output '.Tables[].Rows[] | select(.instance|test("concourse")) | .ips')
        fly -t main login -c https://"${concourse_ip}" -n main -u concourse -p c4c0423e2986c15696d4b3d8e582a8f3 -k
        fly -t main sync
        fly -t main sp -p inital-automation -c ../ci/assets/template/concourse/pipeline.yml -n
        fly -t main up -p inital-automation
        fly -t main tj -j inital-automation/publish -w
    }

    install_credhub(){
        director_login
        echo "Downloading Credhub from bosh.io"
        wget "https://bosh.io/d/github.com/pivotal-cf/credhub-release?v=${credhub_version}" -O ../credhub.tgz --no-check-certificate
        echo "Uploading credhub release director"
        bosh -e useast2 upload-release ../credhub.tgz
        echo "Downloading cf-mysql from bosh.io"
        wget "https://bosh.io/d/github.com/cloudfoundry/cf-mysql-release?v=${mysql_version}" -O ../cf-mysql.tgz --no-check-certificate
        echo "Uploading cf-mysql release director"
        bosh -e useast2 upload-release ../cf-mysql.tgz
        echo "Downloading uaa from bosh.io"
        wget "https://bosh.io/d/github.com/cloudfoundry/uaa-release?v=${uaa_version}" -O ../uaa.tgz --no-check-certificate
        echo "Uploading uaa release director"
        bosh -e useast2 upload-release ../uaa.tgz
        wget "https://github.com/shreddedbacon/credhub-webui-boshrelease/releases/download/v0.0.5/credhub-webui-boshrelease-0.0.5.tgz" -O ../credhub-ui.tgz --no-check-certificate
        bosh -e useast2 upload-release ../credhub-ui.tgz
        wget "https://bosh.io/d/github.com/cloudfoundry-incubator/bpm-release?v=1.0.4" -O ../bpm.tgz --no-check-certificate
        bosh -e useast2 upload-release ../bpm.tgz
        rm ../*.tgz

        echo "Make sure you have entered ${credhub_mySQL_proxy_ip} and ${credhub_static_ip} into cloud-config as static IPs."
        cf_name=$(bosh deployments --json | jq -e --raw-output '.Tables[].Rows[].name | select(.| contains("cf-"))')


        bosh -e useast2 -d credhub deploy ../ci/assets/template/credhub-config.yml \
        -v credhub_mySQL_proxy_ip=$credhub_mySQL_proxy_ip \
        -v credhub_static_ips=$credhub_static_ip \
        -o ../ci/assets/template/concourse/credhub-webui-ops.yml \
        -v cf_deployment_name="${cf_name}" --no-redact -n

        bosh -e useast2 -d credhub-webui deploy ../ci/assets/template/concourse/credhub-ui.yml \
        -v credhub_webui_hostname=credhubui.sys.domain.com \
        -v credhub_client_id=credhub_webui \
        -v credhub_client_secret=sumpasswerd \
        -v credhub_server=https://credhub.domain.com:8844 --no-redact -n
    }

    install_concourse(){
        director_login
        read -p "Do you want to download/upload concourse? (y/n) " concourse_download

        if [ "$concourse_download" != "n" ]; then
            ##############################
            # Downlaod/Upload/Stage Concourse
            ##############################
            echo "Downloading concourse from Pivnet"
            # om -k download-product --output-directory ../ --pivnet-api-token $pivnet_token --pivnet-file-glob "*.tgz" --pivnet-product-slug $concourse_product_slug --product-version-regex $concourse_version_regex
            echo "Downloading stemcell from pivnet"
            # om -k download-product --output-directory ../ --pivnet-api-token $pivnet_token --pivnet-file-glob "*azure*.tgz" --pivnet-product-slug stemcells-ubuntu-xenial --product-version-regex $concourse_stemcell_regex
            echo "Downloading UAA from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry/uaa-release?v=${uaa_version}" -O ../uaa.tgz --no-check-certificate
            echo "Downloading Postgres from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry/postgres-release?v=${postgres_version}" -O ../postgres.tgz --no-check-certificate
            echo "Downloafing backup-and-restore-sdk-release from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry-incubator/backup-and-restore-sdk-release?v=${bbr_sdk_version}" -O ../bbr.tgz --no-check-certificate
            echo "Downloaing os-conf from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry/os-conf-release?v=${os_conf_version}" -O ../os-conf.tgz --no-check-certificate
            echo "Downloading bpm"
            wget "https://bosh.io/d/github.com/cloudfoundry-incubator/bpm-release?v=1.0.0" -O bpm.tgz --no-check-certificate
            echo "Uploading concourse Stemcell to director"
            bosh -e useast2 upload-stemcell ../*azure*.tgz
            om -k upload-stemcell -s ../*azure*.tgz
            echo "Uploading concourse release director"
            bosh -e useast2 upload-release ../*concourse*.tgz
            echo "Uploading uaa release director"
            bosh -e useast2 upload-release ../uaa.tgz
            echo "Uploading backup-and-restore-sdk-release release director"
            bosh -e useast2 upload-release ../bbr.tgz
            echo "Uploading Postgres release director"
            bosh -e useast2 upload-release ../postgres.tgz
            echo "Uploading os-conf release director"
            bosh -e useast2 upload-release ../os-conf.tgz
            echo "Uploading bpm release director"
            bosh -e useast2 upload-release ../bpm.tgz
            read -p "Do you want to delete the downloaded concourse files? (y/n) " concourse_delete
            if [ "$concourse_delete" == "y" ]; then
                echo "Deleting downloaded concourse files"
                rm ../*.tgz
            fi
        fi
        pause
        
        credhub login
        credhub_write
        cf_name=$(bosh deployments --json | jq -e --raw-output '.Tables[].Rows[].name | select(.| contains("cf-"))')
        bosh -e useast2 -d concourse deploy ../ci/assets/template/useast2-concourse.yml -v cf_deployment_name="${cf_name}" --no-redact -n

    }
    install_prometheus(){
        
        read -p "Do you want to download/upload prometheus? (y/n) " prometheus_download

        if [ "$prometheus_download" != "n" ]; then
            ##############################
            # Downlaod/Upload/Stage Concourse
            ##############################
            echo "Downloading prometheus from GitHub"
            wget "https://github.com/bosh-prometheus/prometheus-boshrelease/releases/download/v${prometheus_version}/prometheus-${prometheus_version}.tgz" -O ../promtheus.tgz
            echo "Downloading postgres from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry/postgres-release?v=${postgres_version}" -O ../postgres.tgz
            echo "Downloading bpm from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry-incubator/bpm-release?v=${bpm_version}" -O ../bpm.tgz
            echo "Downloading bpm from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry-incubator/bpm-release?v=${bpm_version}" -O ../bpm.tgz
            echo "Downloading routing from GitHub"
            wget "https://bosh.io/d/github.com/cloudfoundry-incubator/cf-routing-release?v=${routing_version}" -O ../routing.tgz
            echo "Downloading Node Exporter from GitHub"
            wget "https://github.com/bosh-prometheus/node-exporter-boshrelease/releases/download/v4.1.0/node-exporter-4.1.0.tgz" -O ../node-exporter.tgz
            director_login
            echo "Uploading prometheus release director"
            bosh -e useast2 upload-release ../promtheus.tgz
            echo "Uploading Node Exporter release director"
            bosh -e useast2 upload-release ../node-exporter.tgz
            echo "Uploading postgres release director"
            bosh -e useast2 upload-release ../postgres.tgz
            echo "Uploading bpm release director"
            bosh -e useast2 upload-release ../bpm.tgz
            echo "Uploading routing release director"
            bosh -e useast2 upload-release ../routing.tgz
            read -p "Do you want to delete the downloaded prometheus files? (y/n) " prometheus_delete
            if [ "$prometheus_delete" == "y" ]; then
                echo "Deleting downloaded prometheus files"
                rm *.tgz
            fi
            pause
        fi

        read -p  "Do you need to know how to prep? (y/n)" prometheus_prep
        
        if [ "$prometheus_prep" != "n" ]; then
            printf "
                ### Create clients for firehose_exporter and cf_exporter
                    # cf_uaa_login
                    # uaac client add cf_exporter \
                    # --name cf_exporter \
                    # --secret sumpasswerd \
                    # --authorized_grant_types client_credentials,refresh_token \
                    # --authorities cloud_controller.admin

                    # credhub set -t password -n /uaa_clients_cf_exporter_secret -w sumpasswerd

                    # uaac client add firehose_exporter \
                    # --name firehose_exporter \
                    # --secret sumpasswerd \
                    # --authorized_grant_types client_credentials,refresh_token \
                    # --authorities doppler.firehose

                    # credhub set -t password -n /uaa_clients_firehose_exporter_secret -w sumpasswerd

                    uaac client add grafana \
                    --scope openid \
                    --secret sumpasswerd \
                    --authorities uaa.none \
                    --autoapprove true \
                    --authorized_grant_types authorization_code \
                    --redirect-uri https://grafana.sys.domain.com/login/generic_oauth
                    
                    # credhub set -t password -n /uaa_clients_grafana_secret -w sumpasswerd

                ######################
                ### Create MySQL user
                ######################
                    # cf_name=$(bosh deployments --json | jq -e --raw-output '.Tables[].Rows[].name | select(.| contains("cf-"))')
                    # mysql_password=$(credhub get -n /p-bosh/"${cf_name}"/mysql-admin-credentials -j | jq -e --raw-output '.value.password')
                    # bosh -d "${cf_name}" ssh mysql/0

                    ####mysql_password Var does not pass over####
                    
                    # mysql -h 127.0.0.1 -u root -p 
                    # enter "${mysql_password}"
                    # CREATE USER 'exporter' IDENTIFIED BY 'sumpasswerd';
                    # GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter' WITH MAX_USER_CONNECTIONS 3;
                    # exit
                    # exit

                    # credhub set -t user -n /p-bosh/prometheus/mysql_exporter -z exporter -w sumpasswerd

                ####################################
                ### Create client for bosh_exporter
                ####################################
                    # uaa_admin_pass=$(om -k curl -p /api/v0/deployed/director/manifest -s | jq -e --raw-output '.instance_groups[].properties.uaa.admin.client_secret')
                    # uaac target director.domain.com:8443 --skip-ssl-validation
                    # uaac token client get admin -s "${uaa_admin_pass}"
                    # uaac client add bosh_exporter --authorized_grant_types client_credentials,refresh_token --authorities bosh.read --scope bosh.read --secret dL92yrTa48ca2xxK
                    # credhub set -n /uaa_bosh_exporter_client_secret -t password -w sumpasswerd
            "
        fi


        echo "Add Node Exporter to Runtime config?" runtime_config
        if [ "$runtime_config" != "n" ]; then
            director_login
            echo 'releases:
  - name: node-exporter
    version: 4.2.0

addons:
  - name: node_exporter
    jobs:
      - name: node_exporter
        release: node-exporter
    include:
      stemcell:
        - os: ubuntu-trusty
        - os: ubuntu-xenial
    properties: {}' > ../runtime-config.yml
            bosh update-runtime-config ../runtime-config.yml
        fi


        ###INSTALL
        director_login
        cf_name=$(bosh deployments --json | jq -e --raw-output '.Tables[].Rows[].name | select(.| contains("cf-"))')

        bosh -d prometheus deploy ../ci/assets/template/prometheus/prometheus-config.yml \
        -o ../ci/assets/template/prometheus/ops/enable-cf-route-registrar.yml \
        -o ../ci/assets/template/prometheus/ops/ldap.yml \
        -o ../ci/assets/template/prometheus/ops/monitor-node.yml \
        -o ../ci/assets/template/prometheus/ops/monitor-concourse.yml \
        -o ../ci/assets/template/prometheus/ops/monitor-bosh.yml \
        -o ../ci/assets/template/prometheus/ops/monitor-cf.yml \
        -o ../ci/assets/template/prometheus/ops/monitor-mysql.yml \
        -o ../ci/assets/template/prometheus/ops/enable-cf-loggregator-v2.yml \
        -o ../ci/assets/template/prometheus/ops/alertmanager-group-by-alertname.yml \
        -o ../ci/assets/template/prometheus/ops/monitor-http-probe.yml \
        -o ../ci/assets/template/prometheus/ops/enable-cf-api-v3.yml \
        -o ../ci/assets/template/prometheus/ops/enable-grafana-uaa.yml \
        -o ../ci/assets/template/prometheus/ops/enable-service-discovery.yml \
        -o ../ci/assets/template/prometheus/ops/enable-anon.yml \
        --var-file bosh_ca_cert=../ci/assets/template/certificates/director-ca.cer \
        -v BOSH_CLIENT="bosh_exporter" \
        -v probe_endpoints=["https://opsman.domain.com, https://canitconnect.apps.domain.com, https://canitconnect.apps.domain.com"] \
        -v BOSH_CLIENT_SECRET="${BOSH_CLIENT_SECRET}" \
        -v PCF_DIRECTOR="director.domain.com" \
        -v PCF_ENV="AzureCloud" \
        -v cf_deployment_name="${cf_name}" --no-redact -n

        grafana_pass=$(credhub get -n /p-bosh/prometheus/grafana_password)
        echo "Your Grafana admin password is ${grafana_pass}"
        
    }
    upload_product(){
        om -k upload-product -p *.pivotal
        echo "Uploading Stemcells to OpsMan"
        om -k upload-stemcell -s *.tgz
        echo "Removing downloaded file(s)"
        rm *.pivotal
        rm *.tgz
    }

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# UPGRADE SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    upgrade_opsman(){
        ########################################
        # Export OpsMan installation
        ########################################
        om -k export-installation --installation ../installation.zip

        terraform_opsman

        ########################################
        # Import install after terraform process
        ########################################
        om -k -d $OPSMAN_DECRYPTION_PASSPHRASE import-installation --installation ../installation.zip

    }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# PKS SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    new_pks_automation_client(){
        pks_uaa_login
        #automated client
        uaac client add automated-client -s FrKYVd2TDuuucnMV --authorized_grant_types client_credentials --authorities pks.clusters.admin,pks.clusters.manage
        pause
    }
    map_pae_pcf(){
        pks_uaa_pass=$(om -k credentials -p pivotal-container-service --credential-reference .properties.pks_uaa_management_admin_client -f secret)
        uaac target "${pks_api}":8443 --skip-ssl-validation
        # Pks Uaa Management Admin Client
        uaac token client get admin -s "${pks_uaa_pass}"
        uaac group map --name pks.clusters.manage CN=PAE_PCF,OU=Cloud_Foundry,OU=Platform_Architecure_and_Engineering,OU=Enterprise_Technology,OU=Groups,DC=domain,DC=com
        uaac group map --name pks.clusters.admin CN=PAE_PCF,OU=Cloud_Foundry,OU=Platform_Architecure_and_Engineering,OU=Enterprise_Technology,OU=Groups,DC=domain,DC=com
        echo "COMPLETED"
        pause
    }
    new_pks_ldap_cluter_admin(){
        pks_uaa_login
        read -p "Enter User Name (IE 10073093@domain.com) " pks_admin_user
        uaac user add "${pks_admin_user}" --emails "${pks_admin_user}" --origin ldap
        pause
    } 
    new_pks_cluter_admin(){
        pks_uaa_login
        read -p "Enter User Name " pks_admin_user
        read -p "Enter Password " pks_admin_password
        uaac user add "${pks_admin_user}" --emails "${pks_admin_user}"@domain.com -p "${pks_admin_password}"
        uaac member add pks.clusters.admin "${pks_admin_user}"
        pause
        #uaac user add 10073093@domain.com --given_name Brian --emails 10073093@domain.com --origin ldap

    }

    pks_login(){
        pks login -a "${pks_api}" --client-name "${pks_automation_acct}" --client-secret "${pks_automation_pass}" --skip-ssl-validation
    }

    pks_storage_class(){
        kubectl create -f storage-class-azure.yml
        kubectl create -f storage-class-azure-file.yml
        kubectl create -f persistent-volume-claim.yml
        helm install storage-release --set persistence.storageClass=ci-storage stable/wordpress --set mariadb.master.persistence.storageClass=ci-storage
        #To see your new storage
        kubectl get pv
    }

    new_pks_cluster(){
        # echo "${pks_api}"
        # echo "${pks_automation_acct}"
        # echo "${pks_automation_pass}"
        # echo "pks login -a "${pks_api}" --client-name "${pks_automation_acct}" --client-secret "${pks_automation_pass}" --skip-ssl-validation"
        # pause
        #log in
        echo "logging into PKS"
        pks login -a "${pks_api}" --client-name "${pks_automation_acct}" --client-secret "${pks_automation_pass}" --skip-ssl-validation

        read -p "Enter your cluster name (IE MyFreshyFreshCluster) " cluster_name
        read -p "Number of Nodes:: " pks_nodes

        pks create-cluster "${cluster_name}" -e "${cluster_name}".pks.domain.com --plan small --num-nodes "${pks_nodes}" --wait
        echo "getting PKS Credentials"
        pks get-credentials "${cluster_name}"
        echo "Follow the additonal steps to create a Load Balancer Found here::https://docs.pivotal.io/runtimes/pks/1-4/azure-cluster-load-balancer.html"
        echo "Now you need to register DNS to the master Node IP(s) to "${cluster_name}".pks.domain.com"
        pause

    }

    pks_deploy_simple_app(){
        pks login -a "${pks_api}" --client-name "${pks_automation_acct}" --client-secret "${pks_automation_pass}" --skip-ssl-validation

    }

    no_proxy_iprange(){
        printf -v no_proxy '%s,' x.x.36.{1..100};
        export no_proxy="${no_proxy%,}";
    }

    pks_deploy_Prometheus(){
        kubectl create namespace prometheus
        kubectl create secret tls prometheus-server-tls --key azure_private.key --cert azure_cert.crt --namespace prometheus
        cd prometheus
        helm install -f values.yaml stable/prometheus --name prometheus --namespace prometheus
        #####################################
        # Deploy Grafana
        cd ../grafana
        kubectl create namespace grafana
        kubectl create secret tls grafana-server-tls --key ../azure_private.key --cert ../azure_cert.crt --namespace grafana
        helm install -f values.yaml stable/grafana --name grafana --namespace grafana
        #####################################
        # Deploy Ingress Controllers
        cd ..
        kubectl create -f nginx-ingress-grafana-rc.yaml --namespace grafana
        kubectl expose rc nginx-ingress-grafana-rc --port="80,443" --type="LoadBalancer" --namespace grafana
        # Deploy prometheus
        kubectl create -f nginx-ingress-prom-rc.yaml --namespace prometheus
        kubectl create -f nginx-ingress-prom-svc.yaml --namespace prometheus
        ####################################
        # TEST
        kubectl get pods,svc,rc,ingress,secrets -n prometheus
        kubectl get pods,svc,rc,ingress,secrets -n grafana

        #After compelte, grab public IPs and register DNS

        #############################################
        # dry run lets you see the rendered yaml
        #helm install --debug --dry-run -f values.yaml stable/prometheus --name prometheus --namespace prometheus > rendered.yaml

        ##############################
        # Delete everything
        kubectl delete pods,svc,rc,ingress,secrets -n grafana --all
        kubectl delete namespace grafana
        helm del --purge grafana
    }

    install_helm(){
        git clone https://github.com/kubernetes/charts.git
        cd charts
        helm init
        helm repo add gitlab https://charts.gitlab.io/
        #https://gitlab.com/gitlab-org/charts/auto-deploy-app
        #helm install auto-deploy-app gitlab/auto-deploy-app --version 0.2.9
    }

    docker_helloworld(){
        echo "Set "
        echo "server: https://etg.pks.domain.com:8443"
        echo "insecure-skip-tls-verify: true"
        echo "then run pks get-crednetials again"
        echo "Did you set the identities???"
        docker build -t hello-world .
        docker --insecure-registry=harbor.sys.domain.com login https://harbor.sys.domain.com
        docker login harbor.sys.domain.com
        docker tag hello-world harbor.sys.domain.com/public/hello-world
        docker push harbor.sys.domain.com/public/hello-world
        helm create helloworld-chart
        helm package helloworld-chart -f helloworld-values.yml --debug
        helm install helloworld helloworld-chart-0.1.0.tgz
        kubectl describe svc helloworld-helloworld-chart
        kubectl describe deployment helloworld-helloworld-chart
    }

    pks_jenkins(){
        helm install jenkins stable/jenkins -f jenkins-values.yml --debug
        jenkins_pass=$(kubectl get secret --namespace default jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode)
        echo "Your Jenkins username is: admin"
        echo "Your Jenkins password is: ${jenkins_pass}"
        kubectl get svc --namespace default -w jenkins

        #Add to ingress-resource and upgrade
        kubectl upgrade -f ingress-resource.yml

        #SmCoDJZX72
        export SERVICE_IP=$(kubectl get svc --namespace default jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
        echo http://$SERVICE_IP:8080/login

    }

    pks_simple_app(){
        kubectl run bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080

    }

    pks_base(){
        kubectl create -f wildcard-cert.yml
    }

    helm_nginx(){
        ###########
        # It works
        ###########
        #Install default Certificate
        kubectl create -f wildcard-cert.yml
        #install nginx ingress controller
        #https://github.com/helm/charts/tree/master/stable/nginx-ingress
        helm install nginx-ingress stable/nginx-ingress -f ingress-controller.yml
        #Install nginx ingress resource
        kubectl create -f ingress-resource.yml
        #Check it
        kubectl get ingress
        kubectl describe ingress etg-ingress

    }
    helm_nginx_try2(){
        #Install default Certificate
        kubectl create -f wildcard-cert.yml
        #new namespace
        kubectl create namespace ingress-basic
        #####This works, but assigns public IP
        helm install etg-nginx stable/nginx-ingress     --namespace ingress-basic --set controller.service.annotations."service.beta.kubernetes.io/azure-load-balancer-internal"=true
        ###############
        #####Crash loop
        helm install etg-nginx stable/nginx-ingress     --namespace ingress-basic -f ingress-controller.yml
        ###############
        #install nginx ingress controller
        helm install nginx-ingress stable/nginx-ingress \
        --namespace ingress-basic \
        --set imageRegistry=harbor.sys.domain.com/public/nginx-ingress-controller \
        --set controller.service.annotations."service.beta.kubernetes.io/azure-load-balancer-internal"=true \
        -f ingress-controller.yml
        #Install nginx ingress resource
        kubectl create -f ingress-resource.yml
        #Check it
        kubectl get ingress
        kubectl describe ingress etg-ingress

    }


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# OTHERS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    director_login(){
        eval "$(om -k bosh-env)"
        bosh -e director.domain.net alias-env azure
        bosh -e useast2 login
    }

    pks_uaa_login(){
        pks_uaa_pass=$(om -k credentials -p pivotal-container-service --credential-reference .properties.pks_uaa_management_admin_client -f secret)
        uaac target "${pks_api}":8443 --skip-ssl-validation
        uaac token client get admin -s "${pks_uaa_pass}"
    }

    bosh_uaa_login(){
        eval "$(om -k bosh-env)"
        echo "Logging into bosh uaa"
        uaac target "${BOSH_ENVIRONMENT}":8443 --skip-ssl-validation

        uaa_admin_pass=$(om -k curl -p /api/v0/deployed/director/manifest -s | jq -e --raw-output '.instance_groups[].properties.uaa.admin.client_secret')
        uaac token client get admin -s "${uaa_admin_pass}"
    }

    cf_uaa_login(){
        eval "$(om -k bosh-env)"
        cf_uaa_user=$(om -k credentials -p cf -c .uaa.admin_client_credentials -t json | jq  -e --raw-output '.identity')
        cf_uaa_password=$(om -k credentials -p cf -c .uaa.admin_client_credentials -t json | jq  -e --raw-output '.password')
        echo "Logging into cf uaa"
        uaac target uaa.sys.domain.net --skip-ssl-validation
        uaac token client get "${cf_uaa_user}" -s "${cf_uaa_password}"
    }

    healthwatch_pcf_group(){
        cf_uaa_login
        uaac group map --name healthwatch.admin "CN=PAE_PCF,OU=Cloud_Foundry,OU=Platform_Architecure_and_Engineering,OU=Enterprise_Technology,OU=Groups,DC=domain,DC=com"
    }

    cf_pcf_group(){
        cf_uaa_login
        uaac group map --name healthwatch.admin "CN=PAE_PCF,OU=Cloud_Foundry,OU=Platform_Architecure_and_Engineering,OU=Enterprise_Technology,OU=Groups,DC=domain,DC=com"
    }

    bosh_pcf_group(){
        cf_uaa_login
        uaac group map --name healthwatch.admin "CN=PAE_PCF,OU=Cloud_Foundry,OU=Platform_Architecure_and_Engineering,OU=Enterprise_Technology,OU=Groups,DC=domain,DC=com"
    }

    make_us_admins(){
        bosh_uaa_login
        uaac group map --name bosh.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name credhub.read "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name scim.write "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name scim.read "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name clients.read "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name clients.write "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name groups.update "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name healthwatch.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name console.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name uaa.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name cloud_controller.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        cf_uaa_login
        uaac group map --name healthwatch.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name console.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name uaa.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name cloud_controller.admin "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name credhub.write "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name credhub.read "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name scim.write "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name scim.read "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name clients.read "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name clients.write "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure
        uaac group map --name groups.update "07c683f5-b749-464a-af0c-105f79fbc429" --origin azure

        #Read-only
        cf_uaa_login
        uaac group map --name cloud_controller.global_auditor "6d6b1356-5de8-4023-8bbf-11727af75058" --origin azure
        uaac group map --name scim.read "6d6b1356-5de8-4023-8bbf-11727af75058" --origin azure
        uaac group map --name usage_service.audit "6d6b1356-5de8-4023-8bbf-11727af75058" --origin azure
        #CHANGE THIS after issue with cloud_controller.global_auditor is fixed
        uaac group map --name cloud_controller.admin "6d6b1356-5de8-4023-8bbf-11727af75058" --origin azure

    }

    azure_login(){
        echo "Logging into Azure"
        az login
        pause
    }

    ssh_opsman(){
        ssh -i ~/.ssh/opsman.priv ubuntu@opsman.domain.com
    }

    cf_stuff(){
        cf login -a api.sys.domain.com --sso --skip-ssl-validation
    }

    cf_create_user(){
        cf_login
        cf create-user 10073093@domain.com --origin azure
        cf set-org-role 10009555@domain.com ce-org OrgManager
    }

    credhub_write(){
        director_login
        credhub login
        az storage blob download -c terraform -f ../yourstate.tfstate -n REPLACE_ME/yourstate.tfstate
        credhub set -n /pcf-services -t value -v "services"
        credhub set -n /ldap_group_search_base_dn -t value -v "${ldap_group_search_base_dn}"
        credhub set -n /ldap_user_search_base_dn -t value -v "${ldap_user_search_base_dn}"
        credhub set -n /certs/default_ca -t certificate -c "$(cat ../yourstate.tfstate | jq -e '.outputs.ssl_cert.value')" -p "$(cat ../yourstate.tfstate | jq -e '.outputs.ssl_private_key.value')"
        credhub set -n /ldap_user -t user -z "${ldap_user_username}" -w "${ldap_user_password}"
        credhub set -n /ldap_host -t value -v "${ldap_host}"
        credhub set -n /system_domain -t value -v "${system_domain}"
        credhub set -n /ldap_admin_group_dn -t value -v "${ldap_admin_group_dn}"
        credhub set -n /ldap_bind_dn -t value -v "${ldap_bind_dn}"
        credhub set -n /certs/wildcard -t certificate -r ../ci/assets/template/certificates/domain.com-CA.cer -c ../ci/assets/template/certificates/domain.com.cer -p ../ci/assets/template/certificates/domain.com_nopass.key
    }
    credhub_concourse_write(){
        concourse_credhub_login
        az storage blob download -c terraform -f ../yourstate.tfstate -n REPLACE_ME/yourstate.tfstate
        credhub set -n /pcf-services -t value -v "services"
        credhub set -n /ldap_group_search_base_dn -t value -v "${ldap_group_search_base_dn}"
        credhub set -n /ldap_user_search_base_dn -t value -v "${ldap_user_search_base_dn}"
        credhub set -n /certs/default_ca -t certificate -c "$(cat ../yourstate.tfstate | jq -e '.outputs.ssl_cert.value')" -p "$(cat ../yourstate.tfstate | jq -e '.outputs.ssl_private_key.value')"
        credhub set -n /ldap_user -t user -z "${ldap_user_username}" -w "${ldap_user_password}"
        credhub set -n /ldap_host -t value -v "${ldap_host}"
        credhub set -n /system_domain -t value -v "${system_domain}"
        credhub set -n /ldap_admin_group_dn -t value -v "${ldap_admin_group_dn}"
        credhub set -n /ldap_bind_dn -t value -v "${ldap_bind_dn}"
        credhub set -n /certs/wildcard -t certificate -r ../ci/assets/template/certificates/domain.com-CA.cer -c ../ci/assets/template/certificates/domain.com.cer -p ../ci/assets/template/certificates/domain.com_nopass.key
    }

    info(){
        echo "Get BOSH creds from https://opsman.domain.com/api/v0/deployed/director/credentials/bosh_commandline_credentials"
        echo "Get UAA Creds from https://opsman.domain.com/api/v0/deployed/director/credentials/uaa_login_client_credentials"
        echo "Get Director Creds from https://opsman.domain.com/api/v0/deployed/director/credentials/director_credentials"
        echo "Get bosh Root CA on OpsMan from /var/tempest/workspaces/default/root_ca_certificate"
        echo "Take that cert, move to /usr/local/share/ca-certificates, and run sudo update-ca-certificates --fresh"
    }

    pause(){
        read -p "Press [Enter] key to continue..." fackEnterKey
    }
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SHOW MENUS SECTION
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    read_upgrade_options(){
        local choice
        read -p "Enter choice [ 1 - x] " choice
        case $choice in
            1) terraform_all ;;
            2) download_all ;;
            3) configure_all ;;
            x) show_main_menu 0;;
            *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
    }

    terraform_menu() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "   T E R R A F O R M - M E N U   "
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. OpsMan"
        echo "2. Harbor"
        echo "3. PKS"
        echo "4. PAS"
        echo "5. PASW"
        echo "6. Healthwatch"
        echo "7. Azure Service Broker"
        echo "x. Main Menu"
    }
    read_terraform_options(){
        local choice
        read -p "Enter choice [ 1 - x] " choice
        case $choice in
            1) terraform_opsman ;;
            2) terraform_harbor ;;
            3) terraform_pks ;;
            4) terraform_pas ;;
            5) terraform_pasw ;;
            6) terraform_healthwatch ;;
            7) terraform_azure_sb ;;
            x) show_main_menu 0;;
            *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
    }
    om_menu() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo "   P C F - M E N U   "
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Fresh opsman install"
        echo "2. Install/Configure Director"
        echo "3. Install/Configure PKS"
        echo "4. Install/Configure Harbor"
        echo "5. Install/Configure PAS"
        echo "6. Install/Configure PASW"
        echo "7. Install/Configure SSO"
        echo "8. Install/Configure Healthwatch"
        echo "9. Install/Configure Azure SB"
        echo "10. Install/Configure RabbitMQ"
        echo "11. Install/Configure Metrics"
        echo "12. Install/Configure Splunk"
        echo "32. Upgrade OpsMan"
        echo "x. Exit"
    }
    read_om_options(){
        local choice
        read -p "Enter choice [ 1 - x] " choice
        case $choice in
            1) fresh_opsman ;;
            2) install_director ;;
            3) install_pks ;;
            4) install_harbor ;;
            5) install_pas ;;
            6) install_pasw ;;
            7) install_sso ;;
            8) install_healthwatch ;;
            9) install_azure_sb ;;
            10) install_rabbitmq ;;
            11) install_metrics ;;
            12) install_splunk ;;
            32) upgrade_opsman ;;
            x) show_main_menu 0;;
            *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
    }
    pks_menu(){	
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~"	
        echo "         PKS         "
        echo "~~~~~~~~~~~~~~~~~~~~~"
        echo "1. New PKS LDAP Cluster Admin"
        echo "2. New PKS UAA Cluster Admin"
        echo "3. Create PKS Automation Account"
        echo "4. Map PAE_PCF to PKS Manage&Admin"
        echo "5. New PKS Cluster"
        echo "x. Return to Main Menu"
    }
    read_pks_options(){
        local choice
        read -p "Enter choice [ 1 - x] " choice
        case $choice in
            1) new_pks_ldap_cluter_admin ;;
            2) new_pks_cluter_admin ;;
            3) new_pks_automation_client ;;
            4) map_pae_pcf ;;
            5) new_pks_cluster ;;
            x) show_om_menu 0 ;;
            *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
    }
    bosh_menu() {
        clear
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "        B O S H - M E N U        "
        echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        echo "1. Terraform Concourse"
        echo "2. Install Concourse"
        echo "3. Terraform Prometheus"
        echo "4. Install Prometheus"
        echo "x. Main Menu"
    }
    read_bosh_options(){
        local choice
        read -p "Enter choice [ 1 - x] " choice
        case $choice in
            1) terraform_concourse ;;
            2) install_concourse ;;
            3) terraform_prometheus ;;
            4) install_prometheus ;;
            x) show_main_menu 0;;
            *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
    }
    show_pks_menu(){
        while true
        do
            pks_menu
            read_pks_options
        done
    }
    show_upgrade_menu(){
        local choice
        choice=$(whiptail --fb --title "[ U P G R A D E - M E N U ]" --menu "Choose your own destiny" 25 78 7 \
        "1" "Terraform All" \
        "2" "Terraform Select Products" \
        "3" "Download All" \
        "4" "Download Select Products" \
        "5" "Configure All" \
        "6" "Configure Select Products" \
        "x" "Back to main menu" 3>&1 1>&2 2>&3)
        case $choice in
            1) terraform_all ;;
            2) terraform_list ;;
            3) download_all ;;
            4) download_list ;;
            5) configure_all ;;
            6) configure_list ;;
            x) show_main_menu 0;;
        esac
    }
    configure_list() {
        local choices
        choices=$(whiptail --checklist  --separate-output --title "[ S E L E C T - M E N U ]" \
        "Select the products you would like to configure" 20 78 10 \
        "PAS" "" OFF \
        "PASW" ""  OFF \
        "HealthWatch" ""  OFF \
        "RabbitMQ" ""  OFF \
        "Harbor" ""  OFF \
        "Metrics" ""  OFF \
        "SSO" ""  OFF \
        "Credhub_Service_Broker" ""  OFF \
        "Splunk" ""  OFF \
        "Azure_Service_Broker" ""  OFF \
        "Spring" ""  OFF \
        "MySQL" ""  OFF \
        "Pivotal_Redis" ""  OFF \
        "Pivotal_Cloud_Cache" ""  OFF \
        "PKS" ""  OFF 3>&1 1>&2 2>&3)
        for choice in $choices; do
            case $choice in
                PAS) config_product pas ;;
                PASW) config_product pasw ;;
                RabbitMQ) config_product rabbitmq ;;
                HealthWatch) config_product healthwatch ;;
                Harbor) config_product harbor ;;
                Metrics) config_metrics ;;
                SSO) config_sso ;;
                Spring) config_spring ;;
                Credhub_Service_Broker) config_credhub_sb ;;
                Splunk) config_product splunk ;;
                Azure_Service_Broker) config_product azure_sb ;;
                MySQL) config_product mysql ;;
                Pivotal_Redis) config_product redis ;;
                Pivotal_Cloud_Cache) config_product cloudcache ;;
                PKS) config_product pks ;;
            esac
        done
        show_upgrade_menu
        
        # Credhub) download_product credhub_sb $credhub_sb_product_slug $credhub_sb_version_regex;;
        # Spring) download_product spring $spring_product_slug $spring_version_regex ;;
        # Metrics) download_product metrics $metrics_product_slug $metrics_version_regex ;;
        # SSO) download_product sso $sso_product_slug $sso_version_regex;;
        # RabbitMQ) download_product rabbitmq $rabbitmq_product_slug $rabbitmq_version_regex ;;

        # "RabbitMQ" ""  OFF \
        # "Credhub" ""  OFF \
        # "Spring" ""  OFF \
        # "SSO" ""  OFF \
    }
    terraform_list() {
        local choices
        choices=$(whiptail --checklist  --separate-output --title "[ S E L E C T - M E N U ]" \
        "Select the products you would like to Terraform" 20 78 10 \
        "OpsMan" "" OFF \
        "PAS" "" OFF \
        "PASW" ""  OFF \
        "HealthWatch" ""  OFF \
        "Harbor" ""  OFF \
        "Splunk" ""  OFF \
        "Azure_Service_Broker" ""  OFF \
        "MySQL" ""  OFF \
        "Pivotal_Redis" ""  OFF \
        "Pivotal_Cloud_Cache" ""  OFF \
        "PKS" ""  OFF 3>&1 1>&2 2>&3)
        for choice in $choices; do
            case $choice in
                OpsMan) terraform_opsman ;;
                PAS) terraform_product pas ;;
                PASW) terraform_product "pasw" ;;
                HealthWatch) terraform_product healthwatch ;;
                Harbor) terraform_product harbor ;;
                Splunk) terraform_product splunk;;
                Azure_Service_Broker) terraform_product azure_sb;;
                MySQL) terraform_product mysql;;
                Pivotal_Redis) terraform_product redis;;
                Pivotal_Cloud_Cache) terraform_product cloudcache;;
                PKS) terraform_product pks;;
            esac
        done
        show_upgrade_menu
        
        # Credhub) download_product credhub_sb $credhub_sb_product_slug $credhub_sb_version_regex;;
        # Spring) download_product spring $spring_product_slug $spring_version_regex ;;
        # Metrics) download_product metrics $metrics_product_slug $metrics_version_regex ;;
        # SSO) download_product sso $sso_product_slug $sso_version_regex;;
        # RabbitMQ) download_product rabbitmq $rabbitmq_product_slug $rabbitmq_version_regex ;;

        # "RabbitMQ" ""  OFF \
        # "Credhub" ""  OFF \
        # "Spring" ""  OFF \
        # "SSO" ""  OFF \
    }
    download_list() {
        local choices
        choices=$(whiptail --fb --checklist  --separate-output --title "[ S E L E C T - M E N U ]" \
        "Select the products you would like to move to OpsMan" 20 78 10 \
        "PAS" "" OFF \
        "PASW" ""  OFF \
        "HealthWatch" ""  OFF \
        "RabbitMQ" ""  OFF \
        "Harbor" ""  OFF \
        "Metrics" ""  OFF \
        "Spring" ""  OFF \
        "Splunk" ""  OFF \
        "SSO" ""  OFF \
        "Azure_Service_Broker" ""  OFF \
        "MySQL" ""  OFF \
        "Credhub" ""  OFF \
        "Pivotal_Redis" ""  OFF \
        "Pivotal_Cloud_Cache" ""  OFF \
        "PKS" ""  OFF 3>&1 1>&2 2>&3)
        for choice in $choices; do
            case $choice in
                PAS) download_pas ;;
                PASW) download_pasw ;;
                HealthWatch) download_product healthwatch $healthwatch_product_slug $healthwatch_version_regex ;;
                RabbitMQ) download_product rabbitmq $rabbitmq_product_slug $rabbitmq_version_regex ;;
                Harbor) download_product harbor $harbor_product_slug $harbor_version_regex ;;
                Spring) download_product spring $spring_product_slug $spring_version_regex ;;
                Metrics) download_product metrics $metrics_product_slug $metrics_version_regex ;;
                Splunk) download_product splunk $splunk_product_slug $splunk_version_regex;;
                SSO) download_product sso $sso_product_slug $sso_version_regex;;
                Azure_Service_Broker) download_product azure_sb $azure_sb_product_slug $azure_sb_version_regex;;
                MySQL) download_product mysql $mysql_product_slug $mysql_version_regex;;
                Credhub) download_product credhub_sb $credhub_sb_product_slug $credhub_sb_version_regex;;
                Pivotal_Redis) download_product redis $redis_product_slug $redis_version_regex;;
                Pivotal_Cloud_Cache) download_product cloudcache $cloudcache_product_slug $cloudcache_version_regex;;
                PKS) download_product pks $pks_product_slug $pks_version_regex;;
            esac
        done
        show_upgrade_menu
    }
    show_terrfaorm_menu() {
        while true
            do
                terraform_menu
                read_terraform_options
            done
    }
    show_om_menu() {
        while true
            do
                om_menu
                read_om_options
            done
    }
    show_bosh_menu() {
        while true
            do
                bosh_menu
                read_bosh_options
            done
    }
    show_main_menu() {
        local choice
        choice=$(whiptail --fb --clear --title "[ M A I N  M E N U ]" --menu "Choose your destiny" 25 78 6 \
        "1" "Terraform Menu" \
        "2" "PCF Menu" \
        "3" "BOSH Demplyments" \
        "4" "Upgrade/Maintenance" \
        "5" "Log into Azure" \
        "x" "Exit" 3>&1 1>&2 2>&3)
        case $choice in
            1) show_terrfaorm_menu ;;
            2) show_om_menu ;;
            3) show_bosh_menu ;;
            4) show_upgrade_menu ;;
            5) azure_login ;;
            x) exit 0;;
        esac
    }

az login --service-principal -u $ARM_CLIENT_ID -p $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID
az account set -s $ARM_SUBSCRIPTION_ID
NEWT_COLORS_0='
    root=green,black
    border=green,black
    title=green,black
    roottext=white,black
    window=green,black
    textbox=white,black
    button=black,green
    compactbutton=white,black
    listbox=white,black
    actlistbox=black,white
    actsellistbox=black,green
    checkbox=green,black
    actcheckbox=black,green
'
NEWT_COLORS_1='
    root=,blue
    checkbox=,blue
    entry=,blue
    label=blue,
    actlistbox=,blue
    helpline=,blue
    roottext=,blue
    emptyscale=blue
    disabledentry=blue,
'
NEWT_COLORS_2='
    root=white,black
    border=black,lightgray
    window=lightgray,lightgray
    shadow=black,gray
    title=black,lightgray
    button=black,cyan
    actbutton=white,cyan
    compactbutton=black,lightgray
    checkbox=black,lightgray
    actcheckbox=lightgray,cyan
    entry=black,lightgray
    disentry=gray,lightgray
    label=black,lightgray
    listbox=black,lightgray
    actlistbox=black,cyan
    sellistbox=lightgray,black
    actsellistbox=lightgray,black
    textbox=black,lightgray
    acttextbox=black,cyan
    emptyscale=,gray
    fullscale=,cyan
    helpline=white,black
    roottext=lightgrey,black
'
export NEWT_COLORS=$NEWT_COLORS_2
trap '' SIGINT SIGQUIT SIGTSTP
show_main_menu

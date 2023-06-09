export AWS_PROFILE := "fedora-community"

all: fmt validate

fmt:
    terraform fmt

init:
    terraform init

validate:
    terraform validate

apply:
    terraform apply

destroy:
    terraform destroy

show:
    terraform show

ip:
    terraform show -json | jq -r '.values.root_module.resources[0].values.public_ip'

ssh:
    !#/bin/bash
    set -euxo pipefail
    ssh -i ~/.ssh/keys/aws core@$(terraform show -json | jq -r '.values.root_module.resources[0].values.public_ip')

config:
    #!/bin/bash
    set -euxo pipefail
    butane --strict --output config.ign config.bu
    aws s3 mb s3://devconfcz2023workshop
    aws s3 cp config.ign s3://devconfcz2023workshop/config.ign
    aws s3 ls s3://devconfcz2023workshop/
    rm ./config.ign

config-http:
    #!/bin/bash
    set -euxo pipefail
    butane --strict --output config.ign config.bu
    scp config.ign fcos.siosm.fr:/srv/www/public/9cb9786aa7d83098053f17605671b91db66ae1c9c7fd510b78fa1b78ce4c306f.ign
    rm ./config.ign

pointer:
    #!/bin/bash
    set -euxo pipefail
    butane --strict pointer.bu | base64 -w 0

pointer-http:
    #!/bin/bash
    set -euxo pipefail
    butane --strict pointer-http.bu | base64 -w 0

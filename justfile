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

config:
    #!/bin/bash
    set -euxo pipefail
    butane --strict --output config.ign config.bu
    aws s3 mb s3://devconfcz2023workshop
    aws s3 cp config.ign s3://devconfcz2023workshop/config.ign
    aws s3 ls s3://devconfcz2023workshop/
    rm ./config.ign

pointer:
    #!/bin/bash
    set -euxo pipefail
    butane --strict pointer.bu | base64 -w 0

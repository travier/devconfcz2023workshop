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
    terraform show -json | jq -r '.values.root_module.resources[].values.public_ip' | grep -v 'null'

ssh:
    #!/bin/bash
    set -euxo pipefail
    ssh -i ~/.ssh/keys/aws core@$(terraform show -json | jq -r '.values.root_module.resources[].values.public_ip' | grep -v 'null')

config:
    butane --strict --output config.ign config.bu

config-s3:
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

launch:
    #!/bin/bash
    set -euxo pipefail
    NAME='devconfcz2023workshop'
    SSHKEY='travier'                  # the name of your SSH key: `aws ec2 describe-key-pairs`
    IMAGE='ami-016a79745fc97446a'     # the AMI ID found on the download page
    DISK='50'                         # the size of the hard disk
    REGION='eu-central-1'             # the target region
    TYPE='m6i.4xlarge'                # the instance type
    USERDATA='config.ign'             # path to your Ignition config
    aws ec2 run-instances                     \
        --region $REGION                      \
        --image-id $IMAGE                     \
        --instance-type $TYPE                 \
        --key-name $SSHKEY                    \
        --user-data "file://${USERDATA}"      \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${NAME}}]" \
        --block-device-mappings "VirtualName=/dev/xvda,DeviceName=/dev/xvda,Ebs={VolumeSize=${DISK}}"

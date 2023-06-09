#!/bin/bash

set -euxo pipefail

butane --strict --output config.ign config.bu
butane --strict --output pointer.ign pointer.bu

aws s3 mb s3://devconfcz2023workshop
aws s3 cp config.ign s3://devconfcz2023workshop/config.ign
aws s3 ls s3://devconfcz2023workshop/

NAME='devconfcz2023workshop'
IMAGE='ami-016a79745fc97446a'     # the AMI ID found on the download page
DISK='100'           # the size of the hard disk
REGION='eu-central-1'  # the target region
TYPE='m5.large'     # the instance type
SUBNET='subnet-xxx' # the subnet: `aws ec2 describe-subnets`
SECURITY_GROUPS='sg-xx' # the security group `aws ec2 describe-security-groups`
USERDATA='pointer.ign' # path to your Ignition config
aws ec2 run-instances                     \
    --region $REGION                      \
    --image-id $IMAGE                     \
    --instance-type $TYPE                 \
    --subnet-id $SUBNET                   \
    --security-group-ids $SECURITY_GROUPS \
    --user-data "file://${USERDATA}"      \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${NAME}}]" \
    --block-device-mappings "VirtualName=/dev/xvda,DeviceName=/dev/xvda,Ebs={VolumeSize=${DISK}}"

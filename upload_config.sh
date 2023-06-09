#!/bin/bash

set -euxo pipefail

butane --strict --output config.ign config.bu

# aws s3 mb s3://devconfcz2023workshop
aws s3 cp config.ign s3://devconfcz2023workshop/config.ign
aws s3 ls s3://devconfcz2023workshop/

rm ./config.ign

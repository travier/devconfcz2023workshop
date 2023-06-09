#!/bin/bash

set -euxo pipefail

butane --strict pointer.bu | base64 -w 0

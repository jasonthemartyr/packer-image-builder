#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: ./build.sh [aws|azure] <path_to_vars_file>"
    exit 1
fi

cloud_provider=$1
vars_file=$2

if [ ! -f "$vars_file" ]; then
    echo "Error: Vars file '$vars_file' not found."
    exit 1
fi

if [ "$cloud_provider" = "aws" ]; then
    cp sources/sources-aws.pkr.hcl .
    packer init .
    packer validate -var-file="$vars_file" .
    packer build -var-file="$vars_file" .
    rm sources-aws.pkr.hcl
elif [ "$cloud_provider" = "azure" ]; then
    cp sources/sources-azure.pkr.hcl .
    packer init .
    packer validate -var-file="$vars_file" .
    packer build -var-file="$vars_file" .
    rm sources-azure.pkr.hcl
else
    echo "Error: Invalid cloud provider input param. Use 'aws' or 'azure'."
    echo "Usage: ./build.sh [aws|azure] <path_to_vars_file>"
    exit 1
fi
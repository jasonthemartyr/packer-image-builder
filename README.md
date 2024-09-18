# packer-image-builder

This is an example repo on how to machine images in a multi-cloud environment. This example is for Azure/AWS but other providers could be added with minimal changes.

## How to use

A set of example GitHub workflows are provided. The main entry point for each build is the `build.sh` script.

Set your input params in a `*.pkvars.hcl` and pass the provider and file name to the `build.sh` script:

```bash
./build.sh aws aws-al2023.pkrvars.hcl
```

The conditional in `build.sh` is only needed if auth is not setup for all cloud providers. If your Packer container/VM is authenticated to AWS and Azure you can initialize both plugins and move each "source" file into the main directory:

```bash
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

```

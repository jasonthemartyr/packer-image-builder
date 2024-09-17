# packer-image-builder

This is an example repo on how to machine images in a multi-cloud environment. This example is for Azure/AWS but other providers could be added with minimal changes.

## How to use

A set of example GitHub workflows are provided. The main entry point for each build is the `build.sh` script.

Set your input params in a `*.pkvars.hcl` and pass the provider and file name to the `build.sh` script:

```bash
./build.sh aws aws-al2023.pkrvars.hcl
```

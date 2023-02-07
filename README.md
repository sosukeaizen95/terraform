# terraform

Create an EC2 instance with a Linux based OS that is accessible over the internet via SSH.

## Inputs

The following inputs should be accepted:

- **Region**: AWS region where the instance will be deployed
- **KeyName**: Name of the SSH key to be installed on the instance
- **InstanceType**: EC2 instance type (i.e size of the instance)
- **SubnetId**: ID of the subnet where the instance will be deployed
- **VpcId**: ID of the VPC where the instance will be deployed

## Outputs

The following outputs should be produced:

- **InstanceId**: ID of the newly created instance
- **PublicIpAddress**: publicly accessible ip address as an output

## Example

```sh
# Initialize the terraform working directory
$ terraform init

# Validate terraform
$ terraform validate

# Reformat Terraform configuration to follow a consistent standard
$ terraform fmt -check=true -diff

# Dry-run
$ terraform plan \
    -var region=${AWS_REGION} \
    -var key_name=${AWS_KEY_NAME} \
    -var instance_type=${AWS_INSTANCE_TYPE} \
    -var subnet_id=${AWS_SUBNET_ID} \
    -var vpc_id=${AWS_VPC_ID} \
    -out=plan.tfplan

# Apply
$ terraform apply -auto-approve \
    -var region=${AWS_REGION} \
    -var key_name=${AWS_KEY_NAME} \
    -var instance_type=${AWS_INSTANCE_TYPE} \
    -var subnet_id=${AWS_SUBNET_ID} \
    -var vpc_id=${AWS_VPC_ID}

...

Outputs:

InstanceId = xxxxx
PublicIpAddress = x.x.x.x
```

## What to Submit

1. Create a new branch with the name: `<your_github_username>`.
2. Submit a [PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) against the `main` branch.

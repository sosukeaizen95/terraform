# terraform

Create an EC2 instance with a Linux based OS that is accessible over the internet via SSH.

## Inputs

To ensure the proper functioning of our GitHub action, please only utilize the specified variables mentioned below:

- **Region**: AWS region where the instance will be deployed
- **KeyName**: Name of the SSH key to be installed on the instance
- **InstanceType**: EC2 instance type (i.e size of the instance)
- **SubnetId**: ID of the subnet where the instance will be deployed
- **VpcId**: ID of the VPC where the instance will be deployed

Using any additional variables beyond the ones listed above may result in our GitHub action getting stuck in an unintended loop. Please adhere to the provided variables to avoid potential issues.

## Outputs

The following outputs should be produced:

- **InstanceId**: ID of the newly created instance
- **PublicIpAddress**: publicly accessible ip address as an output

## Test

Before submitting your PR for review, please ensure that you have executed the following commands to test your code. It is important to run these commands to validate and ensure consistency in your Terraform configuration. You can also utilize the [Makefile](./Makefile) for testing purposes.

```sh
# Reformat Terraform configuration to follow a consistent standard
$ terraform fmt -check=true -diff

# Initialize the terraform working directory
$ terraform init

# Validate terraform
$ terraform validate

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

Outputs:

InstanceId = xxxxx
PublicIpAddress = x.x.x.x
```

Running these commands will help verify the correctness and formatting of your Terraform code. It is essential to complete these steps before raising the PR for review.

## What to Submit

1. [Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) `main` in this repo to your own namespace.
2. Create a new branch in your repo with the name: `<your_github_username>`.
3. Submit a [PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) from your forked repo into the `main` branch of this repo.

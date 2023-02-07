## -----------------------------------------------------------------------------
## Make targets to test Terraform deployments locally.
## -----------------------------------------------------------------------------

# Global variables with a default value. Override as needed when invoking make.
AWS_REGION?="us-west-2"
AWS_KEY_NAME?="infra"
AWS_VPC_ID?="vpc-a6f052c3"
AWS_SUBNET_ID?="subnet-a46befc1"
AWS_INSTANCE_TYPE="t2.micro"

# Static variables.
PLAN_FILEPATH=plan.tfplan
STATE_FILEPATH=terraform.tfstate
PUBLIC_IP=$(shell terraform output -state=${STATE_FILEPATH} -no-color -raw PublicIpAddress)
INSTANCE_ID=$(shell terraform output -state=${STATE_FILEPATH} -no-color -raw InstanceId)
INSTANCE_INFO=$(shell aws ec2 describe-instances --instance-ids ${INSTANCE_ID} | jq -r .Reservations[0].Instances[0])
OS_TYPE=$(shell ssh -i ~/.ssh/keys/${AWS_KEY_NAME} ec2-user@${PUBLIC_IP} "uname -o")

define DEFAULT_ARGS
-var region=${AWS_REGION} \
-var key_name=${AWS_KEY_NAME} \
-var instance_type=${AWS_INSTANCE_TYPE} \
-var subnet_id=${AWS_SUBNET_ID} \
-var vpc_id=${AWS_VPC_ID}
endef

# Avoid name collisions between targets and files.
.PHONY: help fmt init validate plan apply verify plan-destroy destroy clean

# A target to format and present all supported targets with their descriptions.
help : Makefile
		@sed -n 's/^##//p' $<

## fmt		: Run terraform fmt.
fmt:
	terraform fmt -check=true -diff

## init 		: Run terraform init.
init:
	terraform init

## validate 	: Run terraform validate.
validate:
	terraform validate

## plan 		: Run terraform plan.
plan: clean fmt init validate
	terraform plan ${DEFAULT_ARGS} -out=${PLAN_FILEPATH}

## apply 		: Run terraform apply.
apply:
	terraform apply ${DEFAULT_ARGS} -auto-approve -input=false

## verify 	: Verify if the desired outcome was achieved and run destroy.
verify:
	@if [ "${OS_TYPE}" = "GNU/Linux" ]; then\
		echo "Instance is running ${OS_TYPE}";\
		make plan-destroy;\
		make destroy;\
	else\
		echo "${OS_TYPE} is an invalid OS. Terminating the instance.";\
		make plan-destroy;\
		make destroy;\
	fi

## plan-destroy 	: Run terraform plan destroy.
plan-destroy:
	terraform plan -destroy ${DEFAULT_ARGS} -out=${PLAN_FILEPATH}

## destroy 	: Run terraform destroy.
destroy:
	terraform destroy -auto-approve ${DEFAULT_ARGS}

## clean		: Find and remove all terraform cache files.
clean:
	@find . -name ".terraform" -type d -print0 | xargs -0 -I {} rm -rf "{}"
	@find . -name ".terraform.lock.hcl" -type f -print0 | xargs -0 -I {} rm -rf "{}"
	@find . -name "plan.tfplan" -type f -print0 | xargs -0 -I {} rm -rf "{}"
	@find . -name "terraform.tfstate*" -type f -print0 | xargs -0 -I {} rm -rf "{}"

## Makefile for simple demo lambda

# Before running STAGE needs to be exported for the shell ex: 'export STAGE=dev'

FUNCTION=simple-serverless-database
DESCRIPTION="Database configuration for simple serverless demo"
S3_BUCKET="simple-serverless-$(STAGE)-lambda-artifacts-$(REGION)"
REGION=us-east-2
STACK_NAME="$(FUNCTION)-$(REGION)-$(STAGE)"


print-stage:
	@echo
	@echo '***** STAGE=$(STAGE) *****'
	@echo


build:
	sam build


package: build
	@if test -z "$(STAGE)"; then echo "****** STAGE not set. Set STAGE with: export STAGE=env ******"; exit 1; fi
	sam package \
	--s3-bucket $(S3_BUCKET) \
	--template-file template.yaml \
	--output-template-file "package.$(STAGE).yaml"


# simple-serverless-db-user-$(STAGE) needs to be set in SSM
# simple-serverless-db-password-$(STAGE) needs to be set in SSM
deploy: print-stage build package
	sam deploy \
	--no-fail-on-empty-changeset \
	--template-file "package.$(STAGE).yaml" \
	--stack-name $(STACK_NAME) \
	--capabilities CAPABILITY_IAM \
	--region $(REGION) \
	--parameter-overrides StageName=$(STAGE)


.PHONY : package
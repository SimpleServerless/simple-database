# Simple Database
If you're getting started on simple serverless CRUD API one of the more common but more complicated tasks is getting a
realational database set up on your VPC. Also RDS in AWS can get expensive even if you provision the smallest server possible.
This project contains a template.yaml file and Makefile that provides everyting you need to deploy a relational
database to your VPC and keep your costs down as you prototype a serverless API. This project was also created to set up
a database to be used by [Database Connections: Lesson 6](https://github.com/SimpleServerless/simple-db-connection) in 
the Simple Serverless series.

This project assumes a typical VPC configuration with private subnets, and security groups to control access.
I could have made this much simpler and configured it to deploy a database accessible 
by anyone on the Internet and I apologize if VPC, subnets, and security groups trip you up, but this is how a database
should be deployed for a production system, so I hope you find it worth the extra hassle. I hope that many people already 
have a VPC, private subnets, [bastion hosts](https://github.com/SimpleServerless/simple-bastion), and security groups set up and this actually makes it easier for them to get things working securely.

The configuration I used here is a relational Aurora Serverless Postgres deployment. I set the min and max capacity
units to 2 (the lowest allowed). This is plenty for prototyping and will keep your AWS bill low.  Aurora Serverless is not the 
cheapest RDS option if left on, but it does have the unique ability to be configured to spin down when idle and only charges
you for the capacity units used. It will also spin back up in about 30 seconds as soon as 
it gets a request. When it's running you will be charged $0.12/hour. So if you tinker after work for three hours
twice a week and then it runs another hour before spinning down meaning you get charged for 8 hours total of runtime 
you will pay $0.96 in RDS fees for the week. (Disclaimer: Fees vary, this is just an example, don't take my word for it,
you should always set billing alerts on your AWS account, and don't send me your AWS bill if you screw this up).

```
ScalingConfiguration:
  MaxCapacity: 2
  MinCapacity: 2
  AutoPause: !If [IsProdCondition, false, true ]
  SecondsUntilAutoPause: 3600
```

I use a configuration like the one above for the database servers I was responsible for at one of my employers. 
Most teams there ran three 
databases, one for dev, staging and prod, but most teams ran their databases for each environment all the time
rather than configuring them to spin down (`AutoPause: true`) when the non-productions servers are not in use on 
nights and weekends. A while back I calculated what the savings would be if the seven teams at that time used `AutoPause`
for their non-production databases and the annual savings was about $140,000. 
That's a pretty good chunk of money for one line of code.

# Objectives
- Provide a CloudFormation template that can be used to deploy an RDS solution that enables developers to experiment
with building database backed applications on AWS
- Keep costs of protyping on AWS low
- Keep management of the relational database as simple as possible.
- Demonstrate best practices for attaching the database to a VPC and only allowing access via application and bastion security groups

# What is in this repo
This repo provides all the IaC needed (`template.yaml`) to deploy an Aurora Serverless database.

You will find in this repo:
- A CloudFormation template for deploying the database
- A Makefile with all the commands needed to deploy the database


# Requirements

- AWS CLI [install docs](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- SAM CLI [install docs](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- make
- An AWS account with permissions to deploy RDS, create security groups...
- A shell configured with your AWS credentials AWS_DEFAULT_REGION, AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY... 
  [docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
- A VPC 
- A parameter in Systems Manage - Parameter Store with the name VpcId and value of your vpc id: [Parameter Creation](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-create-console.html)
- An RDS subnet group that includes your private subnets. [Subnet Groups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Subnets)
- Optional: template.yaml currently imports a the bastion security group id from [simple-bastion](https://github.com/SimpleServerless/simple-bastion). 
  If you have a different bastion host or don't need one to connect you can remove or change the second `SecurityGroupIngress` section in the template.


# Deploy
```
export set STAGE=dev
git clone git@github.com:SimpleServerless/simple-database.git
cd simple-database
make deploy
```


# Files Explanation
**Makefile:** Make targets for deploying, testing and iterating. See [Make Targets](#make-targets) for more information.

**template.yaml:** CloudFormation template used to deploy resources to AWS.

**sample-data.sql:** SQL that can be used for lessons in the Simple Serverless series.



# Make Targets
Most make targets require that you export a `STAGE` variable (dev, prod, test...). 
This makes it easier to deploy a stacks for multiple environments on the same AWS account.

Note: These targets use SAM to be consistent with the other repos in Simple Serverless, 
but plain-old CloudFormation should work here as well as there are no SAM resources in this template.

**build:** Uses SAM to build and prepare for packaging

**package:** Uses SAM to package application for deployment

**deploy:** Uses SAM and `template.yaml` to deploy the function and supporting infrastructure to AWS.



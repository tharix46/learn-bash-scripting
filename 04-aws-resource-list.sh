#!/usr/bin/env bash
set -euo pipefail

#########################################
# this script automate the process of listing the resources in an AWS account
# Below are the services that are supported by this script:
# 1. EC2
# 2. EBS
# 3. S3 
# 4. IAM
# 5. VPC
# 6. Route53
# 7. RDS
# 8. DynamoDB
# 9. CloudFront
# 10. CloudWatch
# 11. CloudFormation
# 12. Lambda
# 13. SNS
# 14. SQS
#
# to run this script: 
# 1. Ensure the script has executable permissions: chmod +x 04-aws-resource-list.sh
# 2. Execute the script: ./04-aws-resource-list.sh <aws_region> <aws_service>
# Example: ./04-aws-resource-list.sh us-east-1 ec2
#########################################

# Check if the required number of arguments are passed
if [[ $# -ne 2 ]]; then
    echo "usage: $0 <aws_region> <aws_service>"
    echo "eg: $0 us-east-1 ec2"
    exit 1
fi

# Assign arguments to variables
aws_region=$1
aws_service=$2

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Install the AWS CLI and try again."
    exit 1
fi

# Check if the AWS CLI is configured
if ! aws sts get-caller-identity &>/dev/null; then
  echo "AWS CLI is not configured or credentials are invalid."
  exit 1
fi

# List the resources based on the service
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        # aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType]' --output text --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        # aws ec2 describe-volumes --region $aws_region --query 'Volumes[*].[VolumeId,Size,State]' --output table --no-cli-pager
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    route53)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $aws_region"
        aws cloudfront list-distributions --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac
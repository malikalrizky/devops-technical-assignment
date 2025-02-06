DevOps Technical Assignment

Task 1:
Deploy an Amazon EC2 in both the demo and production AWS accounts using Terragrunt.
Upload your code to GitHub

Solution:
This project provisions an EC2 instance in both the demo and production AWS accounts using Terragrunt.
Before deployment, update aws_account_id parameter in /deployment/accounts/*/account.hcl with your AWS account IDs.

cd terragrunt_aws_multi_account/deployment/accounts

terragrunt run-all plan

terragrunt run-all apply
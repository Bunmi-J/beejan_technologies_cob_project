output "vpc_id" {
  value = module.cob_vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.cob_vpc.vpc_cidr
}

output "private_subnet_cidrs" {
  description = "CIDR block of the VPC"
  value = module.cob_vpc.private_subnet_cidrs
}


output "public_subnet_ids" {
  value = module.cob_vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.cob_vpc.private_subnet_ids
}

output "isolated_subnet_ids" {
  value = module.cob_vpc.isolated_subnet_ids
}

output "internet_gateway_id" {
  value = module.cob_vpc.internet_gateway_id
}

output "cob_ec2_instance_profile_name" {
  description = "IAM instance profile name for cob EC2"
  value       = module.cob_iam.cob_ec2_instance_profile_name
}

output "ec2_role_arn" {
  description = "ARN of the EC2 workload role"
  value       = module.cob_iam.ec2_role_arn
}

output "ecs_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.cob_iam.ecs_role_arn
}

output "ec2_instance_ids" {
  description = "cob ec2 instance id"
  value       = module.cob_ec2.ec2_instance_ids
}

output "ec2_private_ips" {
  description = "private ip for cob ec2"
  value       = module.cob_ec2.ec2_private_ips
}

output "security_group_id" {
  description = "id for cob security group"
  value       = module.cob_ec2.security_group_id
}


output "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = module.cob_iam.ecs_execution_role_arn
}


output "ecs_security_group_id" {
    description = "ecs security group id allowed to connect to postgresql referenced by ingress_rule"
    value = module.cob_ecs.ecs_security_group_id
}

output "s3-ids" {
  description = "ARN for the cob s3"
  value       = module.cob_storage.s3-ids
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.cob_storage.s3_bucket_name
}

output "s3-object-arn" {
  description = "ARN for the cob s3 object"
  value       = module.cob_storage.s3-object-arn
}

output "s3-version" {
  description = "version for the cob s3 bucket"
  value       = module.cob_storage.s3-version
}

output "cob_rds_endpoint" {
  description = "RDS endpoint"
  value       = module.cob_rds.cob_rds_endpoint
}

output "cob_rds_address" {
  description = "RDS hostname"
  value       = module.cob_rds.cob_rds_address
}

output "cob_rds_port" {
  description = "RDS port"
  value       = module.cob_rds.cob_rds_port
}

output "cob_rds_database_name" {
  description = "Database name"
  value       = module.cob_rds.cob_rds_database_name
}

output "glue_role_arn" {
    description = "Amazon resource name of the glue role"
    value = module.cob_iam.glue_role_arn
}

output "catalog_database_name" {
    description = "Name of the catalog database name"
    value = module.cob_glue.catalog_database_name
}


output "query_results_bucket_name" {
  description = "S3 bucket used for Athena query results"
  value       = module.cob_athena.query_results_bucket_name
}
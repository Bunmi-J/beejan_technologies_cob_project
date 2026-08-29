# Outputs
### Glue Output 

catalog_database_name = "cob_catalog_database"

###  ECS Outputs

ecs_security_group_id = "sg-006a17a8b5f98bc1e"

### RDS Outputs

cob_rds_address = "cob-project-environment-postgres.cveqouugmgq4.eu-north-1.rds.amazonaws.com"

cob_rds_database_name = "cob_db"

cob_rds_endpoint = "cob-project-environment-postgres.cveqouugmgq4.eu-north-1.rds.amazonaws.com:5432"

cob_rds_port = 5432

###  EC2 Outputs

ec2_instance_ids = [
  "i-08e4657a1c698ac67",
  "i-079baff8ce81e8c9e",
]

ec2_private_ips = [
  "10.0.1.175",
  "10.0.3.127",
]

security_group_id = "sg-0bb280ccf89a71835"

### IAM Outputs

ec2_role_arn = "arn:aws:iam::469935552963:role/system/cob-project-dev-ec2-instance-role"

cob_ec2_instance_profile_name = "cob-project-dev-ec2-instance-profile"

ecs_execution_role_arn = "arn:aws:iam::469935552963:role/cob-project-dev-ecs-execution-role"

ecs_role_arn = "arn:aws:iam::469935552963:role/system/cob-project-dev-ecs-container-role"

glue_role_arn = "arn:aws:iam::469935552963:role/system/cob-glue-service-role"

### VPC Outputs

vpc_cidr = "10.0.0.0/16"

vpc_id = "vpc-072bc14bb4528d675"

internet_gateway_id = "igw-02c1861f989ee693b"

isolated_subnet_ids = [
  "subnet-09fd896b2755d5bdb",
  "subnet-024354beea17090e5",
]

private_subnet_ids = [
  "subnet-08a1555e31196b31e",
  "subnet-0bed3da9af09b15a7",
]

public_subnet_ids = [
  "subnet-02a1780a5e1d2bbf0",
  "subnet-0d1cc4f07a9158bea",
]

### Athena Output
query_results_bucket_name = "cob-project-environment-query-results"

### s3 Outputs

s3-ids = "cob-s3-bucket"

s3-object-arn = "arn:aws:s3:::cob-s3-bucket/cob/test-object"

s3-version = "cob-s3-bucket"

s3_bucket_name = "cob-s3-bucket"


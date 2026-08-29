# Required Input Variables

### VPC Input Variables


  source = "./modules/vpc"

  vpc_name            = "cob"
  
  vpc_cidr            = "10.0.0.0/16"
  
  public_subnet_cidrs  = [
    "10.0.0.0/24",
    "10.0.2.0/24"
  ]
 
  private_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.3.0/24"
  ]
  
  isolated_subnet_cidrs = [
    "10.0.4.0/24",
    "10.0.5.0/24"
  ]
  
  subnet_routetable   = "cob_subnet_routetable"
  
  availability_zones   = var.availability_zones
  
  enable_nat_gateway  = false # change to true when you need private-subnet internet access
  
  nat_gateway         = "public_nat"
  
  project_name = "cob-project"

---


  source = "./modules/iam"

  project_name         = "cob-project"
  
  environment          = "dev"
  
  resource_name = local.resource_name
  
  cob_glue_name = "cob-glue"
  
  glue_role_arn = module.cob_iam.glue_role_arn
  
  source_bucket_name = module.cob_storage.s3_bucket_name
  
  query_results_bucket_name = module.cob_athena.query_results_bucket_name
  
  username = "cob_data_engineer"

---

### s3 Input Variables
  source = "./modules/s3"

  project_name         = "cob-project"
  
  environment          = "dev"
  
  bucket_name          = "cob-s3"
  
  lifecycle_prefix     = "log"
  
  versioning_enabled   = true
  
  enable_lifecycle     = true
  
  enable_object_upload = true
  
  object_key           = "cob/test-object"
  
  object_source        = "${path.root}/files/test-object.txt"
  
  consumer_name        = "data-engineering"

---

### EC2 Input Variables

  source                        = "./modules/ec2"
 
  vpc_id                        = module.cob_vpc.vpc_id
 
  subnet_ids                     = module.cob_vpc.private_subnet_ids
 
  cidr_block                    = module.cob_vpc.vpc_cidr
 
  security_groupname            = "cob1"
 
  ami_id                        = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
 
  instance_type                 = "t3.micro"
 
  keyname                       = "commit-key"
 
  iam_ec2_instance_profile_name = module.cob_iam.cob_ec2_instance_profile_name
 
  project_name                  = "cob-project"
 
  environment                   = "dev"
 
  consumer_name                 = "data-engineering"

  ---


### ECS Input Variables
  
  source           = "./modules/ecs"
  
  vpc_id           = module.cob_vpc.vpc_id
 
  subnet_ids       = module.cob_vpc.private_subnet_ids
 
  public_subnet_ids = module.cob_vpc.public_subnet_ids
 
  cidr_block       = module.cob_vpc.vpc_cidr
 
  security_groupname   = "cob_esc"
 
  ecs_service_name     = "cob_ecs_service"
 
  service_storage_name = "cob_service_storage"
 
  service_task1        = "image_task1"
 
  service_task2        = "image_task2"
 
  task1                = "cob_task_1"
 
  task2                = "cob_task_2"
 
  alb_name             = "cob-ecs-alb"
 
  cob_lb_name          = "cob-lb"
 
  cob_ecs_cluster_name = "cob_ecs_cluster"
 
  project_name         = "cob-project"
 
  environment          = "dev"
 
  consumer_name        = "application-engineering"
 
  execution_role_arn   = module.cob_iam.ecs_execution_role_arn
 
  task_role_arn        = module.cob_iam.ecs_role_arn #module.cob_iam.ecs_container_arn

---



### RDS Input Variables
  source           = "./modules/rds"
  
  project_name = "cob-project"
  
  environment = "environment"
  
  vpc_id = module.cob_vpc.vpc_id
  
  security_groupname = "cob_rds"

  allocated_storage     = 10

  db_name              = "cob_db" 

  engine               = "postgres"

  engine_version       = "17" 

  instance_class       = "db.t4g.micro" 

  db_username             = "var.rds_username" 

  db_password             = var.rds_password

  db_port                 = 5432 
 
  isolated_subnet_ids = module.cob_vpc.isolated_subnet_ids

  ecs_security_group_id = module.cob_ecs.ecs_security_group_id

  publicly_accessible = false
  
  consumer_name = "analytic engineering"

---


### Glue Input variables
  source           = "./modules/glue"

  cob-crawler_name = "cob_crawler"
  
  catalog_database_name = "cob_catalog_database"
  
  catalog_table_name = "cob_catalog_table"
  
  glue_role_arn = module.cob_iam.glue_role_arn
  
  s3_bucket_name = module.cob_storage.s3_bucket_name

---

### Athena Input Variables
  source           = "./modules/athena"
  athena_data_catalog = "cob_athena_catalog"
  #bucket_id  = module.cob_storage.s3-ids
  #athena_database_name = module.cob_glue.catalog_database_name
  consumer_name = "Data_Engineering"
  project_name = "cob-project"
  environment = "dev"
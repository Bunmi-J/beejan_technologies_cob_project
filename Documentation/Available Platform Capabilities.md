# Available Platform Capabilities
## Networking - VPC Components And Subnets
 * **COB VPC module** is responsible for creating networking resources. The module provisions a standard AWS network foundation that can be used by Beejan technologies Engineering workloads. It implements the industry standard three tier architecture across two availability zones with three types of subnets, the public, private, and isolated subnets.  It also provision default security group and ACL for the subnets

* **The public subnet** has direct access to the internet through the internet gateway. Therefore, resources in the public subnet have direct access to the internet. The auto assign IP address is enabled so resources in the public subnet can be reachable. The design and implementation of NAT gateway also enhances cost efficient architecture with the option to enable/disable NAT gateway/elastic IP address. 

* **The private subnet** has no direct access to the internet. It connects through a route table that forwards traffic to the NAT gateway that resides in the public subnet.  Reuseable compute infrastructures like EC2 and ECS are provisioned in the private subnet. 

* **The isolated subnet** has no internet access. COB relational database is provisioned in the isolated subnet. 

* **NAT Gateway** lets resources in the private subnet connect to the internet while hiding their private IP addresses.The NAT gateway changes the private subnet resource IP address to its own when sending requests to the internet and vice versa when it receives response from the internet. 

* **Application Load Balancer** in public subnets automatically distributes incoming traffic across multiple targets, such as EC2 instances, containers, and IP addresses, in one or more Availability Zones. It monitors the health of its registered targets, and routes traffic only to the healthy targets. 
 
* **Route Table** Every subnet must be associated with a route table. The route table contains rules (routes) that determine where network traffic is directed. When a packet needs to leave a subnet, the VPC router looks up the destination IP in the subnet's route table, finds the most specific matching route, and forwards the packet accordingly.AWS creates a main route table for every VPC. Any subnet not explicitly associated with a custom route table uses the main route table.

**Security Group** is a virtual stateful firewall attached to COB EC2, ECS, and RDS. The security group allows you to define inbound and outbound rules, and enforces them.

**VPC Diagram**Add 

# Identity and Access 

The IAM module contains roles and policy documents for EC2, ECS, Glue, and Athena. The module implements reuseable identity and access patterns for creating IAM resources across different workloads while enforcing least-privilege access. The IAM module defines the following; 

**Trust Policy:** This is an IAM role policy that states the principals and the role to assume in a specified AWS account. 

* Principal: Who can assume a role (i.e EC2, Data Engineer). 

* Assumed role: The assumed role permission allowed (i.e Allows sts:Assumerole on the data engineer role) 

**Permission policy:** The policy is a Json format document that lists permissions on resources on which the role is granted access. The policy states what the role can do on stated resources. The policy is then attached to the specified role.  

**IAM Role:** An identity that does not have any permanent credentials. The credentials are temporary STS tokens that auto expires between 15min –12hours.  

**ECS roles** define a temporary identity credentials with permission for ECS service Task and Execution roles to list the task and execute the tasks in the container respectively 

**EC2 role** defines define a temporary identity credentials with permission for EC2 instance. 

**EC2 instance profile** acts as a bridge for the EC2 instance. The instance profile wraps the role so the EC2 instance can use it and allows applications running on an EC2 instance to get temporary security credentials from the instance metadata service. 

**Example of IAM Module diagram showing Data Engineering Role Access**

---

# Object Storage - s3
Storage Module defines the storage bucket, object, versioning, lifecycle management and rules. It implements standardized naming and tagging for the S3 consumer. 

**The lifecycle management** for COB can be enabled or disabled to save cost and improve the storage efficiency. It defines storage rules and data archive expiration.

**s3 Versioning** provides capability for s3 to maintain multiple version of an object within the same bucket. This feature is useful for recoveing from accidental deletion or overwrite. COB s3 has the option to enable or suspend the versioning  feature. Once the versioning is enabled, it can not be disabled but can only be suspended. New objects added to the buckets after suspending versioning will not be versioned but previosly versioned object will remain.  

**Naming and Tagging** are standardized for easy access of objects in the s3 bucket.

---

# Compute - EC2 and ECS

 The compute takes advantages of the provisoned networking and IAM configurations available to workloads without requiring every team to implement resources independently.
## EC2
 **EC2 module** defines the security group inbound and outbound rules for the EC2. The inbound rule allows TCP protocol inbound traffic from port 22 and all outbound traffic in cidr block "0.0.0.0/0". The module launches EC2 instances in two availability zones specified in the COB VPC private subnet using the IAM configurations available in the EC2 role and policy provisioned in the IAM Module to enforce least privilege access.   

* AMI: Operating system used is ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64" 

* Provision of key pair to connect to a Linux instance via SSH 

* Instance type:t3.micro 

## ECS
 **ECS module** defines the security group inbound and outbound rules for the ECS. The inbound rule allows TCP protocol inbound traffic from port 22 and all outbound traffic in cidr block "0.0.0.0/0". The module launches ECS clusters, services, load balancer, target group and listener to connect and forward traffic from NLB to Target group in two availability zones specified in the COB VPC private subnet using the IAM configurations available in the ECS role and policy provisioned in the IAM Module to enforce least privilege access.

 **The task definition** assigns task role, execution role, and container definition for each task with image, cpu, memory, container port, and host port=443. 

 **Listener** connects and forward traffic from NLB to Target group in two availability zones specified in the COB VPC private subnet. 

 **Target group** are the ip addresses of COB apps and other resources

---

# Relational Database Service (RDS)

In order to provide a RDS with reuseability capability and operational effieciency, we configured RDS module block with input and otput variables so that values are not hard coded, and the analytic team can use the reusability feature of this module to provision operational RDS to meet their requirements.. The platform engineer will not need to repeatedly provison design and implement the same infrastructure from scratch, all that is needed to call the root module to call RDS child module.  

**The relational database service** module accounts for the security group inbound and outbound rules for the RDS. The TCP protocol inbound rule allows postgres inbound traffic from port 5432 and outbound traffic in cidr block "0.0.0.0/0".  The RDS module also launches RDS instance with storage capacity to store database, ability to specify the database engine, engine-version, instance_class, db_password, db-port and DB subnet group. The managed RDS is launched in a logically isolated subnet from other networks with no internet path. 

**DB Subnet Group** manages IP addresses and subnets within the multi availability zones for the RDS. It allows the database to securely and automatically fail over to a backup database in a different isolated location (Availability Zone) during an outage. 

**CIDR block** "10.0.4.0/24" &  "10.0.5.0/24" in each isolated subnet is large enough to accommodate spare IP addresses for the RDS to use during maintenance activities, like failover. The analytical team can connect to the RDS instance using the hostname endpoint. 

**ADdd RDS Diagram**

---

# Data Platform Services
With the integration of Amazon Glue and Athen modules, the data platform services can provide capabilities for analytics teams to expose and query data stored in S3 for analytics.  

## AWS Glue Data Catalog 
This is AWS managed service and a centralized metadata repository that stores and manages information about datasets in your S3, making the datasets easy to discover, query and manage. Technical metadata such as table names, database names, column names, data location, and so on are stored in metadata storage. The Glue Data Catalog integrates with Amazon Athena so that data in the databases can be queried directly without having to copy or duplicate the dataset. It uses IAM role and policy defined in the IAM module to manage fine-grained permissions on tables, columns, and rows. 

**The Glue module** uses the default AWS glue catalog to store table metadata and defines the glue catalog database, database table, and glue crawlers to ensure datasets are indexed and discoverable for analytics. 

**Glue crawler:** for data assets in your S3 to be discovered, the crawlers automatically scan data sources, infer the schema and update the catalog. 

 ## Amazon Athena
Athena is another AWS managed service that enables the analytics team to query the data in the database. Athena reads database schema from data catalog, and executes SQL queries without data duplication. The processed data and query results are stored in a dedicated s3 bucket. Athena supports multiple data formats like parquet, json, csv and so on. 

**The Athena module provisions:**

*  Athena catalog which contains databases and their corresponding schema that defines how data is organized into tables. The catalog enables access to the data that is being queried. 

* Athena work group to control where the analytics team query is run and where query results are written to. 

* S3 bucket for query results with versioning and lifecycle management in place to reduce storage cost. 

 

 
 




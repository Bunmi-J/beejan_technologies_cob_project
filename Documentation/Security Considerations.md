# Security Considerations

For the Internal infrastructure provisioning Platform security in place are in layers.

### Network isolation 
To minimize security concerns, VPC components are separated into public, private, and isolated subnets. 
* **Public Subnet** - Resources like ALB and NAT Gateway require direct internet access, therefore they are placed in the public subnet to implement security and prevent unauthorized access. 
* **Private Subnets** has no direct internet access to avoid unathorised access. Resources like EC2 and ECS are provisioned in private subnet and can make outbound connections through NAT gateway.Deletion protection is enabled.

* **Isolated subnet** has no internet access, it is not publicly accessible and no default route to the NAT Gateway. Connection to the RDS is through the RDS endpoint. Deletion protection and storage encryptions are set to true.

### Security groups
**RDS security group** allows PostgreSQL traffic only from the ECS/EC2 security group, rather than from an entire CIDR range.

**EC2 and ECS Security group** allow SSH traffic from private subnet such that only resources in that private subnet CIDR block can potentially reach SSH not traffic from the whole VPC.


###  IAM

For a production environment, the trust policy should be tighten more such that the role trust a specific identity mechanism.

### Terraform state

Terraform state contain sensitive infrastructure information, it should not be pushed to git hub, add to gitignore file. The Terraform state will be securely pushed to an encrypted remote backend like AWS s3:


### Least Priviledge

the use of least privilege is applied for Glue role, EC2, ECS and Athena roles

### Data protection, secrets, logging/monitoring, and 


Your architecture is already moving in the right direction because you've separated public, private, and isolated subnets and are using IAM roles rather than embedding credentials in workloads.
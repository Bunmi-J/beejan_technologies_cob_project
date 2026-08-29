# The Problem COB Solves and How it Solves the problem:

### Problems
As Beejan Technologies grows, different engineering teams within Beejan Technolgies are now using different configurations for provisioning similar resources. Some S3 buckets have versioning enabled while others do not. IAM policies are inconsistent. Naming and tagging conventions vary. Network configurations differ between projects, and infrastructure changes are difficult to track.

COB provides a standardized way for engineers to provision AWS infrastructure without repeatedly designing and implementing the same infrastructure from scratch.  


### How the Problem is Solved

The issue of designing and implementing the same infrastructure from scratch using different configuration is resolved by using Terraform, Infrastructure as Code (IaC) tool to allow platform engineers to define, provision and manage AWS cloud infrastructure by modularizing and sharing declarative configuration files. The modularized configuration files help to standardize how you provision infrastructure and lets you quickly and predictably provision the resources you need. 

**Root Module**

COB Terraform workspace includes configuration files in its root directory, and the root directory is referred to as the root module. 
The COB root module is configured such that it can call any child module declare multiple times within the same configuration. The root module can also call a child module that calls its own nested child module.
Terraform can load modules from multiple sources, i.e Terraform registry, local file system


**Child Module**

Within COB Terraform workspace, child modules are configured using module blocks. The root modules call the child module when you apply a configuration. Once the configuration is applied and approved, terraform provision the child module's resources to your AWS workspace and manages the resources as part of the configuration.

**The platform Engineering now solve the following problems:**

* Reduce the time required to provision infrastructure.-- 

* Standardise common AWS configurations. 

* Encourage secure-by-default infrastructure. 

* Reduce configuration inconsistencies. 

* Make infrastructure reusable across projects and environments. 

* Allow Platform Engineering to improve standards centrally without rewriting every application. 

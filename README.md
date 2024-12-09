# DevOps-Home-Assignment
This assigment contains Infrastructure as Code (IaC) configurations to provision a cloud infrastructure on AWS. It includes a VPC with public and private subnets, a web server hosted on an EC2 instance, and an RDS database instance deployed in the private subnet. The project is implemented using Terraform and AWS CloudFormation. `. 

## Project Structure
```plaintext
/DevOps Home Assignment: Automate Infrastructure Provisioning with Terraform and YAML Deployment
│
├── /terraform
│   ├── main.tf
│   ├── terraform.tfstate (add to .gitignore)
│   ├── terraform.tfvars (if used, add to .gitignore)
│
├── /cloudformation
│   ├── infrastructure.yaml
│
├── README.md
└── LICENSE (optional)
```
**File Descriptions**

***main.tf***:
---
## **Features**
- **VPC**: Includes a VPC with public and private subnets.
- **VM Instance**: Deployed in the public subnet and accessible via port 80 (HTTP).
- **Managed Database**: MySQL RDS instance in the private subnet.
- **Security Groups**:
  - Allow HTTP traffic to the VM instance.
  - Secure communication between the VM and the database.

---

***infrastructure.yaml***:

A CloudFormation YAML template that provides an alternative way to deploy the same infrastructure.

**Key Features**:

VPC and Subnets:
A single VPC with one public and one private subnet per availability zone`. 

Web Application:
An EC2 instance in the public subnet running Nginx.
Security group allowing HTTP (port 80) traffic from the internet`. 

Database:
An RDS MySQL database in the private subnet`. 

Alternative Deployment:
CloudFormation template provided for deploying the same infrastructure`. 


**Extra Step: Custom Web Application**
As part of the EC2 deployment in the public subnet, Nginx was installed and configured with custom content.

Steps Taken:
Installed Nginx:
Installed Nginx on the EC2 instance using yum commands.
Verified the service status using sudo systemctl.

Customized Content:
Edited the default Nginx welcome page by modifying `/usr/share/nginx/html/index.html`.
Replaced the default content with a personalized message:
"Welcome to Eden's Custom Nginx Page!".

Verified Accessibility:
Accessed the EC2 instance's public IP address over HTTP (<http://34.207.139.118/>) to confirm the custom content was displayed.


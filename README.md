# DevOps-Home-Assignment

This assignment contains Infrastructure as Code (IaC) configurations to provision a cloud infrastructure on AWS. It includes a VPC with public and private subnets, a web server hosted on an EC2 instance, and an RDS database instance deployed in the private subnet. The project is implemented using **Terraform** and **AWS CloudFormation**.

---

## Project Structure

```plaintext
/DevOps-Home-Assignment
├── /terraform
│   ├── main.tf
├── /cloudformation
│   ├── infrastructure.yaml
├── README.md
```

---

## File Descriptions

### `main.tf`

This Terraform file defines the core infrastructure, including:

- **VPC**: A VPC with public and private subnets across two availability zones.
- **EC2 Instance**: A web server deployed in the public subnet and accessible via port 80 (HTTP).
- **RDS MySQL Database**: A managed database deployed in the private subnet.
- **Security Groups**:
  - Allow HTTP traffic to the EC2 instance.
  - Enable secure communication between the EC2 instance and the database.

---

### `infrastructure.yaml`

This CloudFormation YAML template provides an alternative approach to deploy the same infrastructure, ensuring compatibility with AWS-native tools.

**Features**:
- VPC with public and private subnets.
- EC2 instance configured to serve as a web application.
- RDS MySQL database in a private subnet.
- Security groups for traffic management.

---

## Deployment Instructions

### Using Terraform

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/EdenYitzhak/DevOps-Home-Assignment.git
   cd DevOps-Home-Assignment
   ```

2. **Deploy the Infrastructure**:
   Navigate to the Terraform directory:
   ```bash
   cd terraform
   terraform init
   terraform apply
   ```
   Confirm the prompt by typing `yes`.

3. **Verify Deployment**:
   - Terraform will output the **public IP of the EC2 instance** and the **RDS database endpoint**.

---

## Extra Step: Custom Web Application

To demonstrate the EC2 deployment in the public subnet, **Nginx** was installed and configured with custom content.

### Steps Taken:

1. **Installed Nginx**:
   - Installed Nginx using `yum` commands.
   - Verified the service status with `sudo systemctl`.

2. **Customized Content**:
   - Edited the default Nginx welcome page (`/usr/share/nginx/html/index.html`).
   - Added a personalized message:  
     **"Welcome to Eden's Custom Nginx Page!"**

3. **Verified Accessibility**:
   - Accessed the web server via its public IP address over HTTP to confirm the custom content.  
     Example: `<http://34.207.139.118/>`

---

## Notes on Best Practices

- **Key Pair**:
  - The AWS key pair for the EC2 instance is hardcoded in `main.tf` for simplicity.
  - **Recommendation**: Use a `terraform.tfvars` file to externalize sensitive data and include it in `.gitignore`.

- **Security**:
  - Configure `.gitignore` to exclude sensitive files like `terraform.tfstate` and `terraform.tfvars`.

---

## Infrastructure Validation

The infrastructure was successfully deployed and tested. Below are screenshots showcasing the setup:

1. **AWS EC2 Instance**:
   A running instance in the public subnet.
   ![EC2 Instance](https://github.com/user-attachments/assets/1e08a4a4-81df-4081-8ec0-4192ba72c0cf)

2. **RDS Database**:
   A MySQL database configured in the private subnet.
   ![RDS Instance](https://github.com/user-attachments/assets/69d211e4-53a4-47d3-be22-d71af86f6f8f)




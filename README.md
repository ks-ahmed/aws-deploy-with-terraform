[![Infrastructure as Code](https://img.shields.io/badge/IaC-100%25-blue?logo=terraform)]()
[![Deployed-With](https://img.shields.io/badge/Deployed%20With-Terraform-green)]()
[![Built-With](https://img.shields.io/badge/Built%20With-AWS%20EC2%2C%20RDS%2C%20VPC-orange)]()

# VettlyAI Cloud Infrastructure - Fully Automated WordPress Deployment on AWS with Terraform

---


Welcome to the VettlyAI infrastructure project — a fully automated, production-ready cloud deployment of WordPress on AWS, built entirely using **Terraform** and modern DevOps best practices. This project showcases my skills in **Infrastructure as Code (IaC)**, **modular Terraform**, **AWS architecture**, **cloud automation**, and **secure VPC design**.

---

## Project Highlights

- **Modular Terraform Architecture**
- **AWS Infrastructure-as-Code (IaC)**
- **EC2 Instance** (Ubuntu) for hosting WordPress
- **Private RDS (MySQL)** backend in private subnets
- **Custom VPC** with public/private subnets, NAT Gateway, and Internet Gateway
- **Secure Networking** via Security Groups and Subnet Isolation
- **Automated provisioning** with `user_data` (cloud-init)
- **Custom Welcome Page** tailored to `vettlyai.com`
- **Project structure** designed for reuse and scalability
- **Deployment-ready**: Just run `terraform apply` and go live!

---

## Architecture Diagram

---

![Screenshot 2025-06-30 035819](https://github.com/user-attachments/assets/609277ec-d465-48d5-b381-626d11c6f0c0)

 
Notes:
- EC2 instance runs WordPress
- RDS MySQL instance is private
- EC2 connects to RDS over port 3306
- NAT Gateway allows private subnets outbound internet access (e.g., to download packages)


---

## Technologies & Tools Used

| Tool/Service        | Purpose                                 |
|---------------------|------------------------------------------|
| **Terraform**       | Infrastructure as Code (IaC)             |
| **AWS EC2**         | Hosting the WordPress site               |
| **AWS RDS (MySQL)** | Managed backend database (private)       |
| **VPC/Subnets**     | Custom network segregation               |
| **Security Groups** | Fine-grained traffic control             |
| **Cloud-init**      | EC2 boot-time automation via `user_data` |
| **Remote SSH Key**  | Secure login with `.pem` keys            |

---

## Project Structure

```bash
.
├── modules/
│   ├── vpc/               # VPC, subnets, gateways, route tables
│   ├── ec2/               # EC2 instance + user_data
│   ├── rds/               # RDS MySQL instance + subnet group
│   ├── key_pair/          # TLS key pair for EC2 access
├── user_data.sh.tpl       # Startup script for WordPress installation
├── terraform.tfvars       # Customizable variables (e.g. region, subnet CIDRs)
├── main.tf                # Root module calls
├── variables.tf
├── outputs.tf
├── README.md              # 👈 You're here

```

## Security & Best Practices

This project follows cloud security best practices to ensure your infrastructure is safe, manageable, and production-ready:

- **`.pem` keys are ignored** using `.gitignore` (`*.pem`) to prevent sensitive credentials from being committed to version control.
- **Secrets and credentials** (e.g., database password) are securely injected using `terraform.tfvars` — **no hardcoded secrets** in the codebase.
- **RDS (MySQL)** is launched in **private subnets**, meaning it is **not accessible from the public internet**.
- **Security groups** are tightly scoped — only the EC2 instance is exposed to HTTP (port 80) and SSH (port 22) traffic from the internet.
- **NAT Gateway** enables instances in private subnets (e.g., RDS, future backends) to access the internet **without exposing them publicly**.

These safeguards align with AWS’s shared responsibility model and real-world DevOps best practices.

  
---


## Conclusion

This project showcases a full-stack, production-grade infrastructure deployment using **Terraform and AWS**, designed with modularity, scalability, and security in mind.

By automating the provisioning of a **WordPress application on EC2**, a **managed MySQL RDS instance**, and a **fully private/public VPC architecture**, you’ve demonstrated your ability to:

- Build modern infrastructure using Infrastructure as Code (IaC)
- Follow cloud architecture best practices for security and reliability
- Implement reusable and organized Terraform modules
- Use `cloud-init` for zero-touch provisioning of servers
- Safely manage sensitive credentials and key pairs
- Work with multiple AWS services (VPC, EC2, RDS, NAT, IGW, ALB)

---

### Built With:

- Terraform
- AWS EC2, RDS, VPC, NAT Gateway, Internet Gateway
- WordPress
- Apache, PHP, MySQL
- Cloud-init (user data scripts)
- Modular codebase with best practices


# 🚀 VettlyAI Cloud Infrastructure - Fully Automated WordPress Deployment on AWS with Terraform

Welcome to the VettlyAI infrastructure project — a fully automated, production-ready cloud deployment of WordPress on AWS, built entirely using **Terraform** and modern DevOps best practices. This project showcases my skills in **Infrastructure as Code (IaC)**, **modular Terraform**, **AWS architecture**, **cloud automation**, and **secure VPC design**.

---

## 📌 Project Highlights

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

## 🖼 Architecture Diagram

![Architecture Diagram](./architecture/vettlyai-architecture.png)

---

## 🛠️ Technologies & Tools Used

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

## 📁 Project Structure

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

---

                      +-------------------------------+
                      |         AWS Region            |
                      |          eu-west-2            |
                      +-------------------------------+
                                   |
                            +-------------+
                            |    VPC      | 10.0.0.0/16
                            +-------------+
                                   |
        +--------------------------+--------------------------+
        |                                                     |
+--------------------+                           +---------------------+
|  Public Subnet 1   | (10.0.0.0/24)             |  Public Subnet 2    |
|   (eu-west-2a)     |                           |   (eu-west-2b)      |
|                    |                           |                     |
|  +-------------+   |                           |                     |
|  | EC2 (WP)    |   |                           |                     |
|  | apache+php  |   |                           |                     |
|  +-------------+   |                           |                     |
|         |          |                           |                     |
|   Internet Gateway -----------------------------→ Public Internet    |
+--------------------+                                                 


        +--------------------------+--------------------------+
        |                                                     |
+---------------------+                          +----------------------+
|  Private Subnet 1   | (10.0.16.0/24)           |  Private Subnet 2    |
|   (eu-west-2a)      |                          |   (eu-west-2b)       |
|                     |                          |                      |
|  +---------------+  |                          |                      |
|  |  RDS (MySQL)  |  |                          |                      |
|  +---------------+  |                          |                      |
+---------------------+                          +----------------------+

Notes:
- EC2 instance runs WordPress
- RDS MySQL instance is private
- EC2 connects to RDS over port 3306
- NAT Gateway allows private subnets outbound internet access (e.g., to download packages)

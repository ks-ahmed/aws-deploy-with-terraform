# 🌐 WordPress Deployment on AWS using Terraform

This repository contains Terraform configuration files to deploy a single-instance WordPress website on Amazon Web Services (AWS). It sets up an EC2 instance, installs Apache, PHP, and WordPress via a `user_data` bootstrap script, and makes the site accessible over HTTP.

---

## 🛠️ Tech Stack

- **Terraform** for Infrastructure as Code
- **AWS EC2** for hosting WordPress
- **Amazon Linux 2** as the operating system
- **Apache + PHP** for web serving
- **WordPress** (latest version)
- Optional: Customize to use **Amazon RDS** for database hosting

---

## 📁 Project Structure

```bash
wordpress-terraform/
├── main.tf           # Main Terraform configuration
├── variables.tf      # Input variables (optional)
├── outputs.tf        # Outputs (e.g. public IP)
├── user_data.sh      # EC2 bootstrap script to install WordPress
```

# Getting Started
## Prerequisites
  - Terraform v1.0 or newer
  - AWS CLI configured (aws configure)
  - SSH key pair available locally (e.g. ~/.ssh/id_rsa.pub)
  - An AWS account with permission to create EC2 instances and security groups

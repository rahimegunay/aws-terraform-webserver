
# Description
This project provides a turnkey solution for deploying a web application using Nginx on AWS EC2 instances with autoscaling and application load balancer. It leverages Terraform to implement Infrastructure as Code (IaC) practices, making it easy to create, build, and publish a web server infrastructure from scratch.

# Requirements
Before getting started, make sure you have the following prerequisites:
1. An active AWS account with an IAM user already created
2. Text editor of your choice (VSCode Recommended)
3. Terraform Installed, you should also have a basic knowldge of how it works.
4. Bash scripting knowledge.

# Is this project suitable for Production?
This project is primarily designed for testing purposes and may not meet all the requirements of a production environment. Production environments typically require additional considerations such as high availability, scalability, load balancing, CI/CD pipeline, logging, monitoring, and security systems. Please ensure to adapt this project according to your specific production requirements and best practices.

# Why Terraform and AWS EC2 with Nginx?
Terraform is a powerful Infrastructure as Code (IaC) tool that allows you to define and manage infrastructure resources in a declarative manner. It provides a consistent and reproducible way to create and modify infrastructure across different cloud providers, including AWS.

AWS EC2 (Elastic Compute Cloud) offers scalable compute capacity in the cloud, allowing you to provision virtual servers on-demand. EC2 instances are well-suited for hosting web applications, providing flexibility, control, and the ability to scale resources based on demand.

NGINX is a popular web server known for its high performance, scalability, and advanced features. It acts as a reverse proxy and load balancer, efficiently handling incoming client requests and distributing them across multiple backend servers. NGINX is often used in production environments to achieve high availability and improve the overall performance of web applications.

By combining Terraform, AWS EC2, and NGINX, you can automate the provisioning of infrastructure, easily scale resources, and leverage the powerful capabilities of NGINX to deliver a robust and performant web application.

# Setting up project environment

1. First step is to create a folder on your device and open it up in VSCode.
2. Execute the command terraform init to setup the project workspace.
3. Execute the command terraform apply to provision the infrastructure. This will create a VPC with Public Subnets, Internet Gateway and EC2 instances with Security Group.
4. Execute the command terraform apply to provision the Autoscaling and Application Load Balancer with Security Group.
5. Testing the infratructure by loading the traffic on.
6. Execute the command terraform destroy to destroy the infrastructure.

# Note
The resources created in this demo pproject may incur cost. So please take care to destroy the infrastructure if you don't need it.
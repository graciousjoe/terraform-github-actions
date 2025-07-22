# Terraform CI/CD with GitHub Actions
This project demonstrates how to automate infrastructure provisioning on AWS using **Terraform** and **GitHub Actions**.
The workflow deploys an **S3 bucket** and a **t2.micro EC2 instance** whenever code is pushed to the 'main' branch.
---
## What is CI/CD?
- **CI** stand for **Continuous Integration**
   In Continuous Integration, a CI tool like GitHub Actions automatically tests and validates code changes before merging them. For example, when you push Terraform code, GitHub Actions runs terraform validate to check for errors.
- **CD** stands for **Continuous Deployment/Delivery**
    In Continuous Delivery, your code is automatically tested, validated, and packaged, but the final deployment still needs a manual approval. 
    For example, GitHub Actions validates and prepares your Terraform plan, however you still have to manually click "Approve" before it applies.

    In Continuous Deployment, after passing the tests, the code is automatically deployed to production without manual approval.
    Example: GitHub Actions validates and automatically runs terraform apply with no human intervention.
    This part of our code in the yaml file ensures that.
    "- name: Terraform Apply
              run: terraform apply -auto-approve"

    In summary, Continuous Delivery is automated up to staging but requires manual approval for production while Continuous Deployment is fully automated with no manual steps.

Together, CI/CD ensures faster, automated, and error-free deployments.

## What is GitHub Actions?
GitHub Actions is a CI/CD automation tool built into GitHub that spins up a temporary server to let you run workflows on GitHub (e.g., push, pull requests) and automate tasks like testing, building, and deploying infrastructure.

##  What does this workflow do?
This GitHub Actions workflow:
1. Triggers on every push to the main branch
2. Checks out the repository code
3. Installs Terraform
4. Configures AWS credentials using GitHub Secrets
5. Initializes Terraform (terraform init)
6. Validates the Terraform code (terraform validate)
7. Plans the deployment (terraform plan)
8. Applies the changes automatically (terraform apply -auto-approve)

## Backend Configuration
This project uses remote backend to store Terrraform state securely in an S3 bucket. When I run terraform init, Terraform automatically configures the backend nd stores the state file in the S3 bucket instead of locally.
This ensures:
1. State is not lost even if the local environment is cleaned
2. Collaboration of multiple people without state conflicts
3. Easier tracking of infrastructure changes 

## How to trigger the workflow
1. Create an empty GitHub repo named terraform-GitHub-actions.
2. In my local project folder, I'll initialize Git and link it to the repo
    git init
    git branch -M main
    git remote add origin (my repo link)
    git add .
    git commit -m "my commit message"
    git push -u origin main
3. After pushing to the main branch, GitHub Actions automatically detects the push and starts running the workflow.
4. In my GitHub repo, under the Actions tab, I can view the workflow progress and logs.
Any future changes pushed to main will trigger the workflow again

## Screenshots 
Screenshots of the workflow run and AWS resources after successful deployment are attached.
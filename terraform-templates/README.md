# Deploying via Terraform Templates

### Prerequisites
    - Azure Subscription
    - Az Cli
    - Terraform v12

1. `az login`
2. `az ad sp create-for-rbac --scopes "/subscriptions/<your-subscription-id>"`
3. Assign Environment Variables:
    ```
    export ARM_SUBSCRIPTION_ID=(subscription id from above)
    export ARM_TENANT_ID=(tenant from Service Principal)
    export ARM_CLIENT_SECRET=(password from Service Principal)
    export ARM_CLIENT_ID=(appId from Servive Principal)
    ```
4. edit terraform.tfvars
5. `terraform init`
6. Optional: `terraform plan -var-file=terraform.tfvars` to validate
7. `terraform apply -var-file=terraform.tfvars`

### Resources
- Azure Batch Pricing: https://azure.microsoft.com/en-us/pricing/details/batch/
- Folding At Home Docker Image: https://github.com/yurinnick/folding-at-home-docker
- FAH Docker Image with GPU support: https://github.com/wandhydrant/folding-at-home-docker-gpu

### TODO:
- Create new docker image with Passkey field
- investigate initial pool size
- `docker run yurinnick/folding-at-home:latest --help` for command line options

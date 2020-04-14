# Deploying via Terraform Templates

### Prerequisites
    - Azure Subscription
    - Az Cli
    - Terraform v12

1. `az login`
2. `az account list --output table` to list available subscriptions
3. `az account set --subscription <your-subscription-id>`
4. `az ad sp create-for-rbac --scopes "/subscriptions/<your-subscription-id>"`
5. Assign Environment Variables:
    ```
    export ARM_SUBSCRIPTION_ID=(subscription id from above)
    export ARM_TENANT_ID=(tenant from Service Principal)
    export ARM_CLIENT_SECRET=(password from Service Principal)
    export ARM_CLIENT_ID=(appId from Servive Principal)
    ```
6. edit the terraform.tfvars with the appropriate values
7. `terraform init`
8. Optional: `terraform plan -var-file=terraform.tfvars` to validate
9. `terraform apply -var-file=terraform.tfvars`
10. File support for batch pool quota increase. [Documentation](https://docs.microsoft.com/en-us/azure/batch/batch-quota-limit#increase-a-quota) for how to do so.
    -  This is currently required to get batch pool resources. Unsure of why. COVID related limits? [Documentation](https://docs.microsoft.com/en-us/azure/batch/batch-quota-limit#resource-quotas) suggests default quotas should be sufficient.

### Resources
- Azure Batch Pricing: https://azure.microsoft.com/en-us/pricing/details/batch/
- Folding At Home Docker Image: https://github.com/yurinnick/folding-at-home-docker
- FAH Docker Image with GPU support: https://github.com/wandhydrant/folding-at-home-docker-gpu

### TODO:
- investigate necessisity of new docker image with Passkey field
- investigate optimal pricing by VM and region
- investigate initial pool size
- `docker run yurinnick/folding-at-home:latest --help` for command line options

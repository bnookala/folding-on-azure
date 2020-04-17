# folding-on-azure

The purpose of this repository is to provide an easy set of steps to deploy [Folding@Home](https://foldingathome.org/) resources on Azure. To maximize compute resources per dollar credit, these templates leverage [Azure Batch](https://azure.microsoft.com/en-us/services/batch/#overview) with [Low Priority VMs](https://docs.microsoft.com/en-us/azure/batch/batch-low-pri-vms).

For people with an active [Visual Studio Subscription](https://visualstudio.microsoft.com/vs/benefits/#azure?cat=visual-studio-enterprise-subscription), this provides a convenient way to _donate_ unused monthly credits for research.

There are two workflows for deployments:
1. [ARM Templates](arm-templates/)
2. [Terraform Templates](terraform-templates/)

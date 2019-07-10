Your business grows, and the demand rises in Europe and Asia. Most of your infrastructure is cloud based. Users are reporting a slow website. Your company is based in USA. To provide the customers in Europe and Asia a better service, your company has decided to replicate the infrastructure already existent in Azure. The company would also like to be able to ensure that any future infrastructure built could be tracked with a version control system like Git.  

You have been asked to choose an appropriate provisioning tool.  Your provisioning tool should be scalable enough to provision resources for even large infrastructures.  It should also be easy to use and easily customizable.  

Which provisioning tool will allow you to replicate your current infrastructure and redeploy into Europe and Asia after tweaking the relevant parameters (Location, Resource groups and subscription)?

## Recommended provisioning tool

Azure Resource Manager templates will enable you to download your USA datacenter configuration as a JSON file, tweak the necessary parameters, and deploy the same infrastructure for Europe and Asia customers in a few minutes.

Let's use our decision criteria to see how Azure Resource Manager templates would help us in this scenario:

| Criteria               | How does it match up?                                        |
| ---------------------- | ------------------------------------------------------------ |
| Scalability            | Recall that Azure Resource Manager templates are highly scalable and ideal in a case like this for deploying large infrastructure. |
| Ease of set up         | It is very easy to create Azure Resource Manager templates. You can even use templates created previously and build on them to make your own changes to an infrastructure. This would be very helpful in our case, since we could simply export the template, and then edit it to provision the same infrastructure in different regions. |
| Management             | Since these templates are only in JSON format, and easily readable and editable, they can easily be introduced into a version control system to track future changes and test templates out before they are even deployed. |
| Interoperability       | Azure Resource Manager templates are designed to be useable with other tools. You can use them with Azure CLI, or PowerShell to automate future deployments for any future infrastructure. Alternatively, you could even use the templates with the Azure Portal to replicate the entire infrastructure with a few clicks. |
| Configuration Language | Azure Resource Manager are JSON based. JSON is very readable.  We would also easily be able to integrate these templates into our current development process and create, run tests, and destroy entire test environments through simple automated processes that fit in to our development workflow. |

Here are the steps that would allow you to create a copy of the current infrastructure in these other regions.

1. For this, you should already have some virtual machines created in Azure. Export the config File (JSON) for their infrastructure with the Azure portal. You can do this by selecting  **Resource groups**, then selecting the resource group you want, then selecting all of the resources you want to export. Once you have done this, select  **Export template > Download**.

1. In order to create a new environment in a different region, all you have to do is edit the (JSON) template you've just downloaded and make necessary changes to properties, to make sure they are reflective of the new region and new infrastructure. You can create a new resource group for the new region at a later stage.  As an example, below we have looked at a virtual machine resource in the template and changed its location to Western Europe.

    ```json
            {
                "type": "Microsoft.Compute/virtualMachines",
                "apiVersion": "2018-10-01",
                "name": "[parameters('virtualMachines_backEndVM_name')]",
                "location": "westeurope",
                "dependsOn": [
                    "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_backendvm672_name'))]"
                ],
                "properties": { ...
                }
            }
    ```

1. Once you've changed all of the necessary values, import the file into Azure with the Azure portal. You can do this by selecting **Create resource**, then searching for and selecting *Template Deployment* in the search field.

1. The template deployment pane appears. Select **Create** > **Build your own template in the editor > Load file**, load your template, then select **Save**, then fill the fields in as appropriate.

1. Agree to the terms and conditions, then select **Purchase**.

You have now deployed an entirely new infrastructure in another region.

## Reasons not to use the other provisioning tools

| Provisioning tool                       | Reason                                                     |
| --------------------------------------- | :----------------------------------------------------------- |
| Custom Script Extension                 | Custom Script Extensions wouldn't create the virtual machines for you. They are designed to add configurations or software to a machine that exists already.  In addition, some configurations could potentially require reboots, and custom scripts would not be an ideal tool for those kinds of configurations. |
| Azure Desired State Configuration (DSC) | DSC is more scalable than custom scripts to set your configurations, and allows for configurations that may require reboots on the machine. But the same problem remains, DSC alone would not help you provision the virtual machines.  You would still need to create an ARM template to ensure the actual machines are replicated. |
| Azure Automation State Configuration    | Azure Automation State Configuration would be a good solution for the configuration needs of a high scale infrastructure that already exists. Once your migration is done, it would be a good tool to use to ensure that all machines have configurations automatically pushed to them and to ensure each machine also provides detailed reporting on its state. But the initial problem still remains, this service would not be used by itself at the first stage of provisioning. |
| Terraform                               | Terraform is useful for making sure multiple resources in multiple different cloud environments are similar. But in this case, we are only dealing with Azure.  In addition, some resources that exist in Azure may not be available to provision using Terraform and may take some time before they are available for provisioning. |
| Chef                                    | You would need to create an additional server for Chef, which can only run on Linux/Unix based machines. In addition, you would also have to learn a language called Ruby to create your configurations. Both of these add unnecessary overhead in terms of time and complexity. |

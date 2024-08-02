VM Image Builder is a fully managed Azure service that's accessible to Azure resource providers. Resource providers configure it by specifying a source image, a customization to perform, and where the new image is to be distributed. A high-level workflow is illustrated in the diagram:

:::image type="content" source="../media/image-builder-flow-e9eefcdf.png" alt-text="A diagram of conceptual golden image for VM Image Builder.":::


You can pass template configurations by using Azure PowerShell, the Azure CLI, or Azure Resource Manager templates, or by using a VM Image Builder DevOps task. When you submit the configuration to the service, Azure creates an *image template resource*. When the image template resource is created, a *staging resource group* is created in your subscription, in the format `IT_\<DestinationResourceGroup>_\<TemplateName>_\(GUID)`. The staging resource group contains files and scripts, which are referenced in the File, Shell, and PowerShell customization in the ScriptURI property.

To run the build, you invoke Run on the VM Image Builder template resource. The service then deploys other resources for the build, such as a VM, network, disk, and network adapter.

If you build an image without using an existing virtual network, VM Image Builder also deploys a public IP and network security group. VM Image Builder connects to the build VM by using Secure Shell (SSH) or Windows Remote Management (WinRM) protocol.

If you select an existing virtual network, the service is deployed via Azure Private Link, and a public IP address isn't required. For more information, see [VM Image Builder networking overview](/azure/virtual-machines/linux/image-builder-networking).

When the build finishes, all resources are deleted, except for the staging resource group and the storage account. You can remove them by deleting the image template resource, or you can leave them in place to run the build again.

For multiple examples, step-by-step guides, configuration templates, and solutions, go to the [VM Image Builder GitHub repository](https://github.com/azure/azvmimagebuilder).

### Security

To help keep your images secure, VM Image Builder:

 -  Enables you to create baseline images (that is, your minimum security and corporate configurations) and allows other departments to customize them further. You can help keep these images secure and compliant by using VM Image Builder to quickly rebuild a golden image that uses the latest patched version of a source image. VM Image Builder also makes it easier for you to build images that meet the Azure Windows security baseline. For more information, see [VM Image Builder - Windows baseline template](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/imagebuilder-windowsbaseline).
 -  Enables you to fetch your customization artifacts without having to make them publicly accessible. VM Image Builder can use your [Azure Managed Identity](/azure/active-directory/managed-identities-azure-resources/overview) to fetch these resources, and you can restrict the privileges of this identity as tightly as required by using Azure role-based access control (Azure RBAC). You can both keep your artifacts secret and prevent tampering by unauthorized actors.
 -  Securely stores copies of customization artifacts, transient compute and storage resources, and their resulting images within your subscription, because access is controlled by Azure RBAC. This level of security, which also applies to the build VM that's used to create the customized image, helps prevent your customization scripts and files from being copied to an unknown VM in an unknown subscription. And you can achieve a high degree of separation from other customers’ workloads by using [Isolated VM offerings](/azure/virtual-machines/isolation) for the build VM.
 -  Enables you to connect VM Image Builder to your existing virtual networks, so that you can communicate with existing configuration servers, such as DSC (desired state configuration pull server), Chef, and Puppet, file shares, or any other routable servers and services.
 -  Can be configured to assign your user-assigned identities to the VM Image Builder build VM (that is, the VM that the VM Image Builder service creates in your subscription and uses to build and customize the image). You can then use these identities at customization time to access Azure resources, including secrets, in your subscription. There's no need to assign VM Image Builder direct access to those resources.w

## OS support

VM Image Builder is designed to work with all Azure Marketplace base operating system images.

> [!NOTE]
> [Get started](https://ms.portal.azure.com/#create/Microsoft.ImageTemplate) with building and validating custom images inside the portal.

## Confidential VM and Trusted Launch Support

VM Image Builder has extended support for TrustedLaunchSupported and ConfidentialVMSupported images, with certain constraints. Below is the list of constraints:

Expand table

| **SecurityType**        | **Support status**                         |
| ----------------------- | ------------------------------------------ |
| TrustedLaunchSupported  | Support as a source image for image builds |
| ConfidentialVMSupported | Support as a source image for image builds |
| TrustedLaunch           | Not supported as a source image            |
| ConfidentialVM          | Not supported as a source image            |

> [!NOTE]
> When using TrustedLaunchSupported images, it's important that the source and distribute must both be TrustedLaunchSupported for it to be supported. If the source is normal and the distribute is TrustedLaunchSupported, or if the source is TrustedLaunchSupported and the distribute is normal Gen2, it's not supported.

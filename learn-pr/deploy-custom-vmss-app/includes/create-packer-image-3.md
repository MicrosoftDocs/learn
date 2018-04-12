To build images, you create a Packer template as a JSON file. In the template, you define builders and provisioners that carry out the actual build process. Packer has a [provisioner for Azure](https://www.packer.io/docs/builders/azure.html) that allows you to define Azure resources, such as the service principal credentials created in the previous step.

Create a file named *ubuntu.json* in the Azure Cloud Shell. To see a list of available editors and create the file, type `sensible-editor ubuntu.json`. Paste the following template into the file:

```json
{
  "builders": [{
    "type": "azure-arm",

    "client_id": "f5b6a5cf-fbdf-4a9f-b3b8-3c2cd00225a4",
    "client_secret": "0e760437-bf34-4aad-9f8d-870be799c55d",
    "tenant_id": "72f988bf-86f1-41af-91ab-2d7cd011db47",
    "subscription_id": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx",

    "managed_image_resource_group_name": "myResourceGroup",
    "managed_image_name": "myPackerImage",

    "os_type": "Linux",
    "image_publisher": "Canonical",
    "image_offer": "UbuntuServer",
    "image_sku": "16.04-LTS",

    "azure_tags": {
        "dept": "Engineering",
        "task": "Image deployment"
    },

    "location": "East US",
    "vm_size": "Standard_DS2_v2"
  }],
  "provisioners": [{
    "execute_command": "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'",
    "inline": [
      "apt-get update",
      "apt-get upgrade -y",
      "apt-get -y install nginx nodejs npm",

      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ],
    "inline_shebang": "/bin/sh -x",
    "type": "shell"
  }]
}
```

At the start of the *builder* section, replace the example Azure credential information with your own values. The information output in the previous steps should be in the correct format and naming convention:

| Parameter                           | Where to obtain |
|-------------------------------------|----------------------------------------------------|
| *client_id*                         | First line of output from `az ad sp` create command - *appId* |
| *client_secret*                     | Second line of output from `az ad sp` create command - *password* |
| *tenant_id*                         | Third line of output from `az ad sp` create command - *tenant* |
| *subscription_id*                   | Output from `az account show` command |

When Packer builds this template:

- the *builder* creates a base Ubuntu 16.04 LTS VM in Azure,
- the *provisioner* installs NGINX, then deprovisions the VM and creates the image,
- and the base resources for the VM are deleted.
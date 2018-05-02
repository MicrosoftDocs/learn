To build images, you create a Packer template as a JSON file. In the template, you define builders and provisioners that carry out the build process. Packer has a [provisioner for Azure](https://www.packer.io/docs/builders/azure.html) that allows you to define Azure resources, such as the service principal credentials, created in the previous step.

Create a file named *ubuntu.json* in the Azure Cloud Shell. To see a list of available editors and create the file, type `sensible-editor ubuntu.json`. Paste the following template into the file:

```json
{
  "builders": [{
    "type": "azure-arm",

    "client_id": "YOUR client_id VALUE HERE",
    "client_secret": "YOUR client_secret VALUE HERE",
    "tenant_id": "YOUR tenant_id VALUE HERE",
    "subscription_id": "YOUR subscription_id VALUE HERE",

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

If you recall, you ran the command

 `az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"` 
 
 to return values for *client_id*, *client_secret* and *tenant_id* and you ran the command 
 
 `az account show --query '{ "subscription_id": "id" }'` 
 
 to return your *subscription_id*.

 In the *builders* section of the template file shown above, replace the Azure credential information placeholders with your own values. The placeholders are of the format  **"YOUR xxxx_xx HERE"**.  

As we'll see in the next step, when Packer builds this template it will use the information in this file to do the following: 

- the *builder* creates a base Ubuntu 16.04 LTS VM in Azure,
- the *provisioner* installs NGINX, Node.js, and NPM, then deprovisions the VM and creates the image,
- and the base resources for the VM are deleted.

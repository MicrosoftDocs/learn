We have a load balancer to take inbound Internet traffic and route it, now we need some Azure VMs to route traffic to. We'll use Linux for this example, but the exact same technique would work with any virtual machine image.

## Create a set of VMs

We're going to create three VMs and group them into an availability set with the Azure CLI. We could have used the portal for this task - but because we're creating multiple resources, it's much easier to do this through a scripting tool.

An alternative approach if you _really_ prefer to use the Azure portal would be to use a _template_. These are JSON instructions which can be used to deploy resources. We could define a template for the virtual machine and then deploy the template multiple times in the Azure portal.

### Create some Azure CLI defaults

1. Start by setting some defaults in the Azure CLI. Every command we use requires a _resource group_ and an optional _location_. Rather than typing that every time, we can set it as a default parameter. Use the pre-created Azure sandbox resource group, and the same location you selected for the Azure Load Balancer. As a reminder, here are the available locations:

    [!include[](../../../includes/azure-sandbox-regions-note.md)]

1. Type this command into the Cloud Shell on the right, replacing the `<location>` placeholder with the location you used for your Azure Load Balancer.

    ```azurecli
    az configure --defaults group=<rgn>[sandbox Resource Group</rgn> location=<location>
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

### Create an availability set

Let's start by creating an _availability set_.

We will need an availability set to group our virtual machines into. We can use the `vm availability-set` command to create one. It just needs a name, we'll use **woodgrove-avail-set**.

```azurecli
az vm availability-set create --name woodgrove-avail-set
```

### Create a configuration script

We want to use the same basic configuration for each of the VMs.

    - Ubuntu Linux
    - nginx web server
    - Node.js
    - Basic website with a single page for testing

The choice of OS is based on the image we select, but the other configuration elements require some scripting. Let's create a local file in the Cloud Shell to install a web server and configure it with a basic site.

1. Open the Cloud Shell Editor by typing `code` in the terminal.

    ```bash
    code
    ```

    This is a built-in editor you can use to create and edit files right in the Cloud Shell environment. The files are saved in Azure in a Storage account created when you launched the Cloud Shell environment.

1. Copy the following script and paste it into the editor window.

    ```script
    #cloud-config
    package_upgrade: true
    packages:
      - nginx
      - nodejs
      - npm
    write_files:
      - owner: www-data:www-data
      - path: /etc/nginx/sites-available/default
        content: |
          server {
            listen 80;
            location / {
              proxy_pass http://localhost:3000;
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection keep-alive;
              proxy_set_header Host $host;
              proxy_cache_bypass $http_upgrade;
            }
          }
      - owner: azureuser:azureuser
      - path: /home/azureuser/myapp/index.js
        content: |
          var express = require('express')
          var app = express()
          var os = require('os');
          app.get('/', function (req, res) {
            res.send('Hello World from host ' + os.hostname() + '!')
          })
          app.listen(3000, function () {
            console.log('Hello world app listening on port 3000!')
          })
    runcmd:
      - service nginx restart
      - cd "/home/azureuser/myapp"
      - npm init
      - npm install express -y
      - nodejs index.js
    ```

1. Save the file - give it the name **cloud-init.txt**. You can use the "..." context menu on the top/right corner of the editor, or use <kbd>Ctrl+S</kbd> in Windows and Linux, and <kbd>Cmd+S</kbd> on macOS.

1. Exit the editor - again you can use the "..." context menu, or an accelerator key (<kbd>Ctrl+Q</kbd>).

1. The file should be on the file system. Try using the `ls` command to list the contents of the folder. You can also `cat` the file to verify the contents.

### Create the virtual machines

Next, let's create three Ubuntu Linux virtual machines with the Azure CLI. We won't cover the options here, but if you are interested in learning more about VM management with the CLI, check out the **Manage virtual machines with the Azure CLI** module.

We also need to create a virtual network interface for each VM. We can use a loop and create them together.

1. Use the `vm-create` command to create three virtual machines in a loop. You can use the following code to:
    - Create a NIC named _woodgrove_NicX_ where X is [1,2,3].
    - Create a VM named _woodgrove-VMX_ where X is [1,2,3].
    - Associate each NIC to the created VNET
    - Associate each VM to the NIC and availability set.

    ```azurecli
    for i in `seq 1 3`; do

        az network nic create --name woodgrove-Nic$i \
            --vnet-name woodgrove-VNET \
            --subnet backendSubnet

    	az vm create --name woodgrove-VM$i \
            --availability-set woodgrove-avail-set \
            --nics woodgrove-Nic$i \
            --image UbuntuLTS \
            --admin-username azureuser \
            --generate-ssh-keys \
            --custom-data cloud-init.txt \
            --no-wait
    done
    ```
    > [!TIP]
    > The command is setting the administrator name to "azureuser" here, you can change that to anything you like. You can also supply a password if you prefer username/password over SSH keys.

1. This will take a while to run - and even when the loop is finished, the VMs won't quite be available. You can switch over to the Azure portal and use the **All Resources** display to see the created resources.

1. You can also use the `vm list` command to see how many VMs have been deployed.

    ```azurecli
    az vm list -o table
    ```

Next we'll talk about how to configure the load balancer.
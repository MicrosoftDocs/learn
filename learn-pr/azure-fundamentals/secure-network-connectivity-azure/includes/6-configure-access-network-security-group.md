In this exercise, you configure network access to a virtual machine (VM) running on Azure.

You start by creating a Linux VM and installing Nginx, a popular web server, on that VM. To make your web server accessible, you then create a network security group (NSG) rule that allows inbound access on port 80 (HTTP).

There are many ways to create and manage VMs, including their network settings. For example, you can use the Azure portal, the Azure CLI, Azure PowerShell, or an Azure Resource Manager (ARM) template.

Here, you use the Azure CLI. The Azure CLI enables you to connect to Azure and run administrative commands on Azure resources. As with other command-line interfaces, you can run commands directly from a terminal or you can add commands to a Bash script or a PowerShell script. The Azure CLI runs on Windows, macOS, or Linux.

Here, you access the Azure CLI from Azure Cloud Shell. Cloud Shell is a browser-based shell experience that you use to manage and develop Azure resources. Think of Cloud Shell as an interactive console that runs in the cloud.

If you're new to the Azure CLI or to Cloud Shell, just follow along.

## Create a Linux virtual machine and install Nginx

Use the following Azure CLI commands to create a Linux VM and install Nginx. After your VM is created, you'll use the Custom Script Extension to install Nginx. The Custom Script Extension is an easy way to download and run scripts on your Azure VMs. It's just one of the many ways you can configure the system after your VM is up and running.

1. From Cloud Shell, run the following `az vm create` command to create a Linux VM:

    ```azurecli
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name my-vm \
      --image UbuntuLTS \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

    Your VM will take a few moments to come up.

    You name the VM **my-vm**. You use this name to refer to the VM in later steps.

1. Run the following `az vm extension set` command to configure Nginx on your VM:

    ```azurecli
    az vm extension set \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --vm-name my-vm \
      --name customScript \
      --publisher Microsoft.Azure.Extensions \
      --version 2.1 \
      --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
      --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
    ```

    This command uses the Custom Script Extension to run a Bash script on your VM. The script is stored on GitHub.

    While the command runs, you can choose to [examine the Bash script](https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh?azure-portal=true) from a separate browser tab.

    To summarize, the script:

    1. Runs `apt-get update` to download the latest package information from the internet. This step helps ensure that the next command can locate the latest version of the Nginx package.
    1. Installs Nginx.
    1. Sets the home page, */var/www/html/index.html*, to print a welcome message that includes your VM's host name.

## Access your web server

In this procedure, you get the IP address for your VM and attempt to access your web server's home page.

1. Run the following `az vm list-ip-addresses` command to get your VM's IP address and store the result as a Bash variable:

    ```azurecli
    IPADDRESS="$(az vm list-ip-addresses \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --name my-vm \
      --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
      --output tsv)"
    ```

1. Run the following `curl` command to download the home page:

    ```bash
    curl --connect-timeout 5 http://$IPADDRESS
    ```

    The `--connect-timeout` argument specifies to allow up to five seconds for the connection to occur.

    After five seconds, you see an error message that states that the connection timed out:

    ```output
    curl: (28) Connection timed out after 5001 milliseconds
    ```

    This message means that the VM was not accessible within the timeout period.

1. As an optional step, try to access the web server from a browser:

    1. Run the following to print your VM's IP address to the console:

        ```bash
        echo $IPADDRESS
        ```

        You see an IP address, for example, *23.102.42.235*.

    1. Copy the IP address that you see to the clipboard.
    1. Open a new browser tab and go to your web server.

        After a few moments, you see that the connection isn't happening. If you wait for the browser to time out, you'll see something like this:

        :::image type="content" source="../media/7-browser-timeout.png" alt-text="A web browser showing an error message that says the connection timed out.":::

        Keep this browser tab open for later.

## List the current network security group rules

Your web server wasn't accessible. To find out why, let's examine your current NSG rules.

1. Run the following `az network nsg list` command to list the network security groups that are associated with your VM:

    ```azurecli
    az network nsg list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --query '[].name' \
      --output tsv
    ```

    You see this:

    ```output
    my-vmNSG
    ```

    Every VM on Azure is associated with at least one network security group. In this case, Azure created an NSG for you called *my-vmNSG*.

1. Run the following `az network nsg rule list` command to list the rules associated with the NSG named *my-vmNSG*:

    ```azurecli
    az network nsg rule list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --nsg-name my-vmNSG
    ```

    You see a large block of text in JSON format in the output. In the next step, you'll run a similar command that makes this output easier to read.

1. Run the `az network nsg rule list` command a second time.

    This time, use the `--query` argument to retrieve only the name, priority, affected ports, and access (**Allow** or **Deny**) for each rule.

    The `--output` argument formats the output as a table so that it's easy to read.

    ```azurecli
    az network nsg rule list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --nsg-name my-vmNSG \
      --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
      --output table
    ```

    You see this:

    ```output
    Name               Priority    Port    Access
    -----------------  ----------  ------  --------
    default-allow-ssh  1000        22      Allow
    ```

    You see the default rule, *default-allow-ssh*. This rule allows inbound connections over port 22 (SSH). SSH (Secure Shell) is a protocol that's used on Linux to allow administrators to access the system remotely.

    The priority of this rule is 1000. Rules are processed in priority order, with lower numbers processed before higher numbers.

By default, a Linux VM's NSG allows network access only on port 22. This enables administrators to access the system. You need to also allow inbound connections on port 80, which allows access over HTTP.

## Create the network security rule

Here, you create a network security rule that allows inbound access on port 80 (HTTP).

1. Run the following `az network nsg rule create` command to create a rule called *allow-http* that allows inbound access on port 80:

    ```azurecli
    az network nsg rule create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --nsg-name my-vmNSG \
      --name allow-http \
      --protocol tcp \
      --priority 100 \
      --destination-port-range 80 \
      --access Allow
    ```

    For learning purposes, here you set the priority to 100. In this case, the priority doesn't matter. You would need to consider the priority if you had overlapping port ranges.

1. To verify the configuration, run `az network nsg rule list` to see the updated list of rules:

    ```azurecli
    az network nsg rule list \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --nsg-name my-vmNSG \
      --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
      --output table
    ```

    You see this both the *default-allow-ssh* rule and your new rule, *allow-http*:

    ```output
    Name               Priority    Port    Access
    -----------------  ----------  ------  --------
    default-allow-ssh  1000        22      Allow
    allow-http         100         80      Allow
    ```

## Access your web server again

Now that you've configured network access to port 80, let's try to access the web server a second time.

1. Run the same `curl` command that you ran earlier:

    ```bash
    curl --connect-timeout 5 http://$IPADDRESS
    ```

    You see this:

    ```html
    <html><body><h2>Welcome to Azure! My name is my-vm.</h2></body></html>
    ```

1. As an optional step, refresh your browser tab that points to your web server.

    You see this:

    :::image type="content" source="../media/7-browser-success.png" alt-text="A web browser showing the home page from the web server. The home page displays a welcome message along with the web server's host name.":::

[!include[](../../../includes/azure-sandbox-cleanup.md)]

Nice work. In practice, you can create a standalone network security group that includes the inbound and outbound network access rules you need. If you have multiple VMs that serve the same purpose, you can assign that NSG to each VM at the time you create it. This technique enables you to control network access to multiple VMs under a single, central set of rules.

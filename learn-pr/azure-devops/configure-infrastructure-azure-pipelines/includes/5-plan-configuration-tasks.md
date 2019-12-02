TODO: Point to Docs page about setting up your own control machine. Promise that link here.

Recall that with Ansible, you use a _control machine_ to manage your systems. A control machine includes the Ansible software, Python, your inventory file, and the playbooks you need to run.

* [Red Hat Ansible instance on Linux](https://azuremarketplace.microsoft.com/marketplace/apps/azure-oss.ansible?azure-portal=true), published by Microsoft.

    You can use this image to bring up a control machine, which includes Ansible, the Azure CLI, and other tools, to manage your fleet.

Two approaches:

1. Create an admin, or "jump" box.
    1. Steps
1. Configure your deployment directly from the agent. (could be Microsoft-hosted or your own. Point to 'own' module.)
    1. Steps
    1. 

Auth types

Auto (MSI) - 
Manual - you provide your own security principal details
Off - ??

### Create a service principal

You've configured Terraform to access the state file remotely. Next, you create the service principal that can authenticate with Azure on your behalf.

During the process, you collect information about your service principal that you'll later need when you run your configuration in Azure Pipelines.

1. Create unique ID (TODO)

    ```bash
    UNIQUE_ID=$RANDOM
    ```

1. Run the following `az account list` to get your Azure subscription ID.

    ```azurecli
    ARM_SUBSCRIPTION_ID=$(az account list \
      --query "[?isDefault][id]" \
      --all \
      --output tsv)
    ```

1. Run the following `az ad sp create-for-rbac` command to create a service principal.

    ```azurecli
    ARM_CLIENT_SECRET=$(az ad sp create-for-rbac \
      --name http://ansible-sp-$UNIQUE_ID \
      --role Contributor \
      --scopes "/subscriptions/$ARM_SUBSCRIPTION_ID" \
      --query password \
      --output tsv)
    ```

    The service principal's name begins with "http://ansible-sp-" and ends with your unique ID.

    **Contributor** is the default role for a service principal. This role has full permissions to read and write to an Azure subscription.

    The output from this command is your only opportunity to retrieve the generated password for the service principal. The `--query` argument reads the password field from the output. The output is assigned to the Bash variable named `ARM_CLIENT_SECRET`.

1. Run the following `az ad sp show` command to get your service principal's client ID and assign the result to a Bash variable named `ARM_CLIENT_ID`.

    ```azurecli
    ARM_CLIENT_ID=$(az ad sp show \
      --id http://ansible-sp-$UNIQUE_ID \
      --query appId \
      --output tsv)
    ```

1. Run the following `az ad sp show` command to get your service principal's tenant ID and assign the result to a Bash variable named `ARM_TENANT_ID`.

    ```azurecli
    ARM_TENANT_ID=$(az ad sp show \
      --id http://ansible-sp-$UNIQUE_ID \
      --query appOwnerTenantId \
      --output tsv)
    ```

1. Run the following `az ad sp list` command to list the service principals in your Azure subscription.

    ```azurecli
    az ad sp list --show-mine --query [].servicePrincipalNames
    ```

    Your SP name begins with **http://ansible-sp-** and ends with your unique ID. Here's an example:

    ```json
    [
      [
        "http://ansible-sp-24382",
        "961badb1-8005-45ae-89da-c1583f58ead5"
      ]
    ]
    ```

    Save somewhere safe for later.

1. Print each of the Bash variables you collected in this part to verify their contents.

    ```bash
    echo $ARM_SUBSCRIPTION_ID
    echo $ARM_CLIENT_SECRET
    echo $ARM_CLIENT_ID
    echo $ARM_TENANT_ID
    ```

    Each value is a GUID, or a long series of letters and numbers.

    Might store these somewhere safe. You'll need them later.

1. TODO: Create credentials file so that control machine can authenticate access to Azure resources.

    ```bash
    echo "\
    [default]
    subscription_id=$ARM_SUBSCRIPTION_ID
    client_id=$ARM_CLIENT_ID
    secret=$ARM_CLIENT_SECRET
    tenant=$ARM_TENANT_ID" | tee credentials
    ```

    ```bash
    cat credentials
    ```

    ```output
    [default]
    subscription_id=00000000-1111-0000-0000-000000000000
    client_id=00000000-2222-0000-0000-000000000000
    secret=00000000-3333-0000-0000-000000000000
    tenant=00000000-4444-0000-0000-000000000000
    ```

## Create the control machine

1. Go to [Red Hat Ansible instance on Linux](https://azuremarketplace.microsoft.com/marketplace/apps/azure-oss.ansible?azure-portal=true) on Azure Marketplace.
1. Select **GET IT NOW**.

    A window appears that details the Terms of Use, Privacy Policy, and Use of Azure Marketplace Terms.
1. Review the terms of service, then select **Continue**.

    You're taken to the Azure portal.
1. Select **Create**.
1. Under **Basics**, fill in these fields:

    * **Name** - *ansiblehost*
    * **User name** - *azureuser*
    * **Authentication type** - *SSH public key*
    * **SSH public key** - Enter the SSH public key that you copied in the previous section.
    * **Subscription** - Select your Azure subscription.
    * **Resource group** - Select **Create new**. Then enter *learn-ansible-control-machine-rg* and select **OK**.
    * **Location** - Choose a location. You can use the same location that you used earlier to create your VMs to manage.

    Select **OK**.

1. Under **Additional Settings**, enter a unique name in the **Domain name label** field, such as *test1234*. For this module, the domain name label isn't important. Then select **OK**.
1. Under **Integration Settings**, select *Auto(MSI)*. Then select **OK**.
1. Under **Summary**, wait for the validation process to finish and then select **OK**.
1. Under **Buy**, scroll to the end and then select **Create**.

    ![](../media/notifications-deployment.png)

## Get your control machine's public IP address

TODO: Hostname instead?

```bash
echo $IPADDRESS
```

## Copy files to your control machine

* SSH private keys => VMs under management
* .cfg file
* inventory file
* Service principal - credentials file

```bash
IPADDRESS=$(az vm list-ip-addresses \
  --resource-group learn-ansible-control-machine-rg \
  --name ansiblehost \
  --query [0].virtualMachine.network.publicIpAddresses[0].ipAddress \
  --output tsv)

scp -i ~/.ssh/id_ansible-vm \
  ~/.ssh/id_ansible-vm \
  azureuser@$IPADDRESS:/home/azureuser/.ssh

scp -i ~/.ssh/id_ansible-vm \
  ~/ansible.cfg \
  azureuser@$IPADDRESS:/home/azureuser

scp -i ~/.ssh/id_ansible-vm \
  azure_rm.yml \
  azureuser@$IPADDRESS:/home/azureuser

scp -i ~/.ssh/id_ansible-vm \
  credentials \
  azureuser@$IPADDRESS:/home/azureuser/.azure
```

## Install the Ansible extension in VS Code

TODO: WHY

The **Ansible** extension is not installed by default in Visual Studio Code. Let's start by installing it:

1. In VS Code, on the **View** menu, select **Extensions**.
1. In the **Search Extensions in Marketplace** textbox, enter *Ansible*, and then select the **Ansible** extension.

    ![Adding the Azure Account extension in VS Code](../media/4-add-ansbile-extension.png)

1. Select **Install**.
1. Select **Reload** to activate the extension.

## Run Ansible from your control machine

Here, you run Ansible from your control machine by using the Ansible extension in VS Code.

You run the Ansible extension from the command palette. The process prompts you for information such as the playbook you want to run and your control machine's hostname.

### Specify additional options in your user settings

There are a few additional options that you need to specify, including the location of your SSH private key and the path to your inventory file. These options are stored in your VS Code user settings. Here's how to TODO:

1. In VS Code, press <kbd>F1</kbd> or select **View > Command Palette** to access the command palette.
1. In the command palette, enter *Preferences: Open User Settings*.

    A tab appears that displays your current settings.

1. In the **User Settings** pane, add this line:

    > [!TIP]
    > User setting are in JSON format. Be sure to add a comma (**,**) to the end of the last setting listed before you add yours.

    ```json
    "ansible.customOptions": "--private-key ~/.ssh/id_ansible-vm -i /home/azureuser/azure_rm.yml"
    ```

    Both path names refer to locations on your control machine.

1. Select **File > Save** to save your settings.

    Your settings resemble this:

    ![](../media/4-vs-code-user-settings.png)

### Create the TODO file

TODO: 

1. In VS Code, open the integrated terminal.
1. Create a directory named *mslearn-ansible* in a location you choose, such as your home directory. Her

    ```bash
    mkdir ~/mslearn-ansible
    ```

    TODO: Don't confuse with what you set up in CS (move this above?)
1. Select **File > New File**.
1. Add this code to your file:

    ```yml
    - hosts: all
      remote_user: azureuser
      become: yes
      tasks:
      - name: Add service accounts
        user:
          name: "{{ item }}"
          comment: service account
          create_home: no
          shell: /usr/sbin/nologin
          password: '*'
          state: present
        loop:
        - testuser1
        - testuser2
    ```

    TODO: It's the same...

1. Select **File > Save As** and then save your file to *users.yml* in your *mslearn-ansible* directory.

### Run Ansible

TODO: 

1. In VS Code, press <kbd>F1</kbd> or select **View > Command Palette** to access the command palette.
1. In the command palette, enter *Ansible: Run Ansible Playbook Remotely via ssh*.
1. When prompted, enter these values:

    * The full path to your playbook file, *users.yml*.
    * Your control machine's public IP address or hostname.

    TODO: When prompted whether to copy your workspace to the remote host, select **no, not show this again**. This TODO. TODO: Asks you per playbook, so you can specify a different value later?

    From the output, you see that (TODO: Succeeded, but no changes are made; show sample output)

    ```output
    PLAY RECAP *********************************************************************************************************************************************************************************************
    vm1_1bbf                   : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    vm2_867a                   : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    ```
You're all done with the tasks for this module. Here, you'll clean up your Azure resources.

> [!IMPORTANT]
> This page contains important cleanup steps. Cleaning up ensures that you're not charged for Azure resources after you complete this module.

## Clean up Azure resources

Delete your VMs under management, your Ansible control machine, and your service principal. Earlier, you worked with Azure resources through Azure Cloud Shell in Visual Studio Code. Here, you do the same.

The easiest way to delete your VMs is to delete their parent resource groups. Deleting a resource group deletes all resources in that group.

To clean up your resource groups:

1. In Visual Studio Code, go to your Cloud Shell session.
1. Run the following `az group delete` command to delete the resource group for your VM deployment, **learn-ansible-rg**.

    ```azurecli
    az group delete --name learn-ansible-rg --yes
    ```

1. Run the following `az group delete` command to delete the resource group for your control machine, **learn-ansible-control-machine-rg**.

    ```azurecli
    az group delete --name learn-ansible-control-machine-rg --yes
    ```

1. As an optional step, run the following `az group list` command after the previous command finishes.

    ```azurecli
    az group list --output table
    ```

    You see that the resource groups **learn-ansible-rg** and **learn-ansible-control-machine-rg** no longer exist.

To delete your service principal:

1. Run the following `az ad sp list` command to list the service principals in your Azure subscription.

    ```azurecli
    az ad sp list --show-mine --query [].servicePrincipalNames
    ```

1. Locate the service principal that you created in this module. The name begins with `http://ansible-sp-`, and ends with your unique ID. Here's an example:

    ```json
    [
      [
        "http://ansible-sp-4962",
        "198244ba-dc73-4561-acea-356c513b0c37"
      ]
    ]
    ```

1. Run the following `az ad sp delete` command to delete your service principal. Replace the name shown here with yours.

    ```azurecli
    az ad sp delete --id http://ansible-sp-4962
    ```

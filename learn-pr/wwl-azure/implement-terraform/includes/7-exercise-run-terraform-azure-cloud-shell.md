Terraform is pre-installed in Azure Cloud Shell so that you can use it immediately, and no extra configuration is required.

Because you can install Terraform on both the Windows and Linux operating systems, you can use either a PowerShell or Bash shell to run it.

In this walkthrough, you create a resource group in Azure using Terraform, in Azure Cloud Shell, with Bash.

The following screenshot displays Terraform running in Azure Cloud Shell with PowerShell.

:::image type="content" source="../media/terraform-command-powershell-ab9d69b2.png" alt-text="Screenshot of Azure Cloud Shell using a PowerShell shell and running the command Terraform. Output from the command displays.":::


The following image is an example of running Terraform in Azure Cloud Shell with a Bash shell.

:::image type="content" source="../media/terraform-bash-shell-running-command-290484fc.png" alt-text="Screenshot of Azure Cloud Shell using a Bash shell running the command Terraform. Output from the command displays.":::


## Editor

You can also use the Azure Cloud Shell editor to review, open, and edit your .tf files. To open the editor, select the braces on the Azure Cloud Shell taskbar.

:::image type="content" source="../media/terraform-editor-open-cf0bb281.png" alt-text="Screenshot of Azure Cloud Shell with the editor open and the file terraform-createrg.tf opened. The braces icon is highlighted on the taskbar.":::


## Prerequisites

 -  You do require an Azure subscription to do these steps. If you don't have one, you can create one by following the steps outlined on the [Create your Azure free account today](https://azure.microsoft.com/free) webpage.

## Steps

The following steps outline how to create a resource group in Azure using Terraform in Azure Cloud Shell, with bash.

1.  Open the Azure Cloud Shell at `https://shell.azure.com`. You can also launch Azure Cloud Shell from within the Azure portal by selecting the Azure Cloud Shell icon.
2.  If prompted, authenticate to Azure by entering your credentials.
3.  In the taskbar, ensure that **Bash** is selected as the shell type.
4.  Create a new .tf file and open the file for editing with the following command:
    
    ```Yml
    vi terraform-createrg.tf
    
    ```

5.  Enter **insert** mode by selecting the **I** key.
6.  Copy and paste the following code into the file:
    
    ```Yml
    provider "azurerm" {
      features {}
    }
    resource "azurerm_resource_group" "rg" {
            name = "testResourceGroup"
            location = "westus"
    }
    
    ```

7.  Exit **insert** mode by selecting the **Esc** key.
8.  Save the file and exit the **vi** editor by entering the following command:
    
    ```Yml
    :wq
    
    ```

9.  Use the following command to initialize Terraform:
    
    ```Terraform
    terraform init
    
    ```
    
    You should receive a message saying Terraform was successfully started.
    
    :::image type="content" source="../media/terraform-azure-cloud-shell-b19d8338.png" alt-text="Screenshot of Azure Cloud Shell with the Bash shell, running the command run terraform init, and displaying its output":::
    

10. Run the configuration .tf file with the following command:
    
    ```Yml
    terraform apply
    
    ```
    
    You should receive a prompt to indicate that a plan has been generated. Details of the changes should be listed, followed by a prompt to apply, or cancel the changes.
    
    :::image type="content" source="../media/terraform-bash-azure-shell-6c4ba5f6.png" alt-text="Screenshot of a Bash shell in Azure Cloud Shell with output from the command terraform apply":::
    

11. Enter a value of **yes**, and then select Enter. The command should run successfully, with an output similar to the following screenshot.
    
    :::image type="content" source="../media/terraform-bash-output-command-92102cb0.png" alt-text="Screenshot of a Bash shell in Azure Cloud Shell with output from the command terraform apply. The option yes to accept changes is highlighted":::
    

12. Open Azure portal and verify the new resource group now displays in the portal.

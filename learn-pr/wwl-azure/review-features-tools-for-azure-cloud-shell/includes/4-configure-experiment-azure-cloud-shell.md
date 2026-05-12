In this unit, you'll learn how to experiment with Azure Cloud Shell.

## Configure the Cloud Shell

1. Access the **Azure portal**.
1. Select the **Cloud Shell** icon in the toolbar.
1. When prompted, select **PowerShell** as your shell.
1. In the **Getting started** pane, select **Mount storage account** to set up persistent storage, or select **No storage account required** for an ephemeral session.
1. If mounting storage: select your subscription from the dropdown, select **Apply**, then select **We'll create a storage account for you** and follow the prompts to create a new resource group and storage account.

## Experiment with Azure PowerShell

1. Wait for your storage to be created and your account to be initialized.
1. At the PowerShell prompt, enter `Get-AzSubscription` to review your subscriptions.
1. Enter `Get-AzResourceGroup` to review resource group information.

## Experiment with the Bash shell

1. Use the drop-down list to switch to the **Bash** shell and confirm your choice.
1. At the Bash shell prompt, enter `az account list` to review your subscriptions. Also, try tab completion.
1. Enter `az resource list` to review resource information.

## Experiment with the Cloud Editor

1. To use the Cloud Editor, enter `code .`. You can also select the **Editor** button (pencil icon) in the toolbar.
1. Select a file from the **navigation** pane; for example, **.profile**.
1. On the editor banner, notice the selections for **Settings**, such as **Text Size**, **Font**, and **Upload/Download files**.
1. Notice the ellipses (**...**) for **Save**, **Close Editor**, and **Open File**.
1. After experimenting, you can close the Cloud Editor.
1. Close Azure Cloud Shell.

In this unit, you'll learn how to experiment with Azure Cloud Shell.

## Configure the Cloud Shell

1. Access the **Azure Portal**.
1. Select the **Cloud Shell** icon on the banner.
1. On the **Welcome to Azure Cloud Shell** page, notice your selections for Bash or PowerShell. Select **PowerShell**.
1. The Azure Cloud Shell requires an Azure file share to persist files. If you have time, select **Learn more** to obtain information about the Cloud Shell storage and the associated pricing.
1. Select your **Subscription**, and then select **Create Storage**.

## Experiment with Azure PowerShell

1. Wait for your storage to be created and your account to be initialized.
1. At the PowerShell prompt, enter **Get-AzSubscription** to review your subscriptions.
1. Enter **Get-AzResourceGroup** to review resource group information.

## Experiment with the Bash shell

1. Use the drop-down list to switch to the **Bash** shell and confirm your choice.
1. At the Bash shell prompt, enter **az account list** to review your subscriptions. Also, try tab completion.
1. Enter **az resource list** to review resource information.

## Experiment with the Cloud Editor

1. To use the Cloud Editor, enter **code .**. You can also select the curly braces icon.
1. Select a file from the **navigation** pane; for example, **.profile**.
1. On the editor banner, notice the selections for **Settings**, such as **Text Size**, **Font**, and **Upload/Download files**.
1. Notice the ellipses (**...**) for **Save**, **Close Editor**, and **Open File**.
1. After experimenting, you can close the Cloud Editor.
1. Close Azure Cloud Shell.

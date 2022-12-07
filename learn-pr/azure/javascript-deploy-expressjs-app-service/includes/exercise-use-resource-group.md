When you use Azure, you need a subscription. Inside the subscription, you create resource groups. Inside the resource groups, you create resources.

In this exercise, you'll:

* Sign in to the Learn sandbox with a user account you use for the entire module. This sandbox gives you a free subscription and resource group to complete this module from Visual Studio Code.
* Find the free sandbox subscription and resource group in Visual Studio Code.

## Sign in to the Learn sandbox

Select the **Sign in to activate sandbox** button at the top of this page to sign in. This step might include reviewing permissions. When you see **Sandbox activated!** with a time remaining on this page, this step is complete.

Make sure you use the same account to sign in to the sandbox and Azure from Visual Studio Code.

## Find the subscription in Visual Studio Code

Find the free sandbox subscription in Visual Studio Code.

1. Open Visual Studio Code.
1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
1. Select **Azure: Sign In to Azure Cloud** to complete the sign-in process.
1. When the listing of Azure clouds appears, select **Azure Cloud**.
1. After the process is finished, your account appears in the bottom bar. An example is `Azure: youremail@mail.com`.
1. Select your account in the bottom bar and filter the list of subscriptions to the sandbox subscription.

    |Subscription name|Value|
    |--|--|
    |**Subscription name**|`Concierge Subscription`|

1. If the sandbox subscription isn't in the list, make sure you're in the correct Azure tenant (authentication group). The Azure tenant for the Learn sandbox is in `604c1504-c6a3-4080-81aa-b33091104187`.
    1. Select <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd> to open the command palette.
    1. Enter **Azure: Select Tenant**.
    1. Select **Enter custom tenent**.
    1. In the text box, enter the sandbox tenant `604c1504-c6a3-4080-81aa-b33091104187`.
    1. Sign back in to Azure for this tenant:
        1. In the command palette, select **Azure: Sign In to Azure Cloud** to complete the sign-in process.
        1. When the listing of Azure clouds appears, select **Azure Cloud**.
        1. After the process is finished, your account appears in the bottom bar. An example is `Azure: youremail@mail.com`.
1. Enable the sandbox subscription **Concierge Subscription**. Clear any other subscription checkboxes so that you can focus while you complete this module.

## Use the Azure resource group extension to find the sandbox resource group

Find the sandbox resource group in Visual Studio Code.

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. The Azure pane has two sections:
    * Resource groups
    * Azure App Service resources
1. Expand the **Resource groups** section, and select the sandbox subscription. Expand the subscription and resource group.
1. The resource group displays an Azure Storage resource for Azure Cloud Shell. This resource was created automatically when you began using the sandbox. If you create more resources, they're added to this resource group.

## Check your work

At this point, your local Visual Studio Code should be correctly configured and connected to the free sandbox for this module. In this exercise:

* You created your sandbox. Check how much time you have left before the sandbox is removed by viewing the top of this Learn exercise.
* You signed in to Azure from Visual Studio Code and found the sandbox subscription, resource group, and resources.

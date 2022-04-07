> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still read along.

You'll troubleshoot a name resolution problem in a later exercise. Use the following instructions and the Azure Cloud Shell on the right of the screen to create the environment for this exercise.

> [!NOTE]
> The resource group <rgn>[sandbox resource group name]</rgn> has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.

In the sandbox to the right, follow these steps:

## Create the exercise environment
Using the Cloud Shell on the right, run these commands to create the example topology.  The environment will take approximately 13 minutes to build.

1. Clone the set up script from GitHub.

   ```powershell
   git clone https://github.com/MicrosoftDocs/mslearn-cloud-hybrid-connectivity networking
   ```

1. Run the set up script.

   ```powershell
   networking/setup.ps1
   ```

1. The script will create all the resources. Wait until it completes, you should see a Lab Environment Created message.

1. You can continue to the next unit as this command runs in the background.

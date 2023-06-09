> [!IMPORTANT]
> You need your own [Azure subscription](https://azure.microsoft.com/free/?azure-portal=true) to complete the exercises in this module. If you don't have an Azure subscription, you can still view the demonstration video in the exercise unit.

1. Select **Sign in** to activate sandbox and sign in using your own credentials.

1. Select **Review permissions**, read and accept to continue.

1. Azure Cloud Shell will authenticate and build and you are ready to start the exercise.

You’ll troubleshoot a name resolution problem in a later exercise. Use the following instructions and the Azure Cloud Shell on the right of the screen to create the environment for this exercise.

> [!NOTE]
> The resource group **sandbox-rg** has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.

In the sandbox to the right, follow these steps:

## Create the exercise environment
Using the Cloud Shell on the right, run these commands to create the example topology.  The environment will take approximately 13 minutes to build.

1. Clone the setup script from GitHub.

   ```console
   git clone https://github.com/MicrosoftDocs/mslearn-name-resolution-issues networking
   ```

1. Run the setup script.

   ```console
   networking/setup.ps1
   ```

1. The script will create all the resources. Wait until it completes, you should see a Lab Environment Created message.

1. You can continue to the next unit as this command runs in the background.

You’ll troubleshoot a name resolution problem in a later exercise. Use the following instructions and the Azure Cloud Shell on the right of the screen to create the environment for this exercise.

> **NOTE**:
> The resource group **sandbox-rg** has been created automatically. Use this as your resource group name. You won't have permission to create additional resource groups in the sandbox.

In the sandbox to the right, follow these steps:

## Create the exercise environment
Using the cloud shell on the right, run these commands to create the example topology.  The environment will take approximately 13 minutes to build.

1. Clone the setup script from GitHub.

```console
git clone hhttps://github.com/MicrosoftDocs/mslearn-cloud-hybrid-connectivity/blob/main/setup.sh networking
```

1. Run the setup script.

```console
bash networking/setup.sh
```

1. The script will create all the resources. Wait until it completes, you should see a Lab Environment Created message.

1. You can continue to the next unit as this command runs in the background.

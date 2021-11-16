You've decided to use the Azure CLI to manage the Azure Machine Learning workspace. Before you start, you need to make sure the Azure CLI and the Azure Machine Learning extension are installed.

Recall the bike company you work for as a machine learning engineer. The customer churn model created by the data science team is the first model you'll train with Azure Machine Learning. You want to show the team which steps you took to create the workspace and train the model. Sharing the steps will make it easy for them to redo and automate your work for future projects. You'll run commands with the Azure CLI (v2) to create and manage the Azure Machine Learning resources. The commands can later be shared with the team for reproducibility and automation.

You'll install the Azure CLI and the extension for Azure Machine Learning. With this set-up, you can manage your Azure Machine Learning workspace.

## Install the Azure CLI

You install the Azure CLI on a Linux, Mac, or Windows computer. With the Azure CLI, you run commands or scripts to manage Azure resources. You can also use the Azure CLI from a browser through the Azure Cloud Shell. No matter which platform you choose, you can execute the same tasks. But, the installation of the Azure CLI, the commands, and scripts are different across platforms.

> [!IMPORTANT]
> To install the Azure CLI on your computer you can use a package manager. Here are the instructions to [install the Azure CLI](/cli/azure/install-azure-cli), based on the platform you choose. You don't need to install the Azure CLI if you use the Azure Cloud Shell. Learn more about how to use [the Azure Cloud Shell in this overview](/azure/cloud-shell/overview).

During *testing and development*, you're likely to work from your local computer. Launch a shell such as cmd.exe on Windows, or Bash on Linux or macOS to use the Azure CLI. In the shell prompt, you run commands and check the result for each command you submit. Since you're creating the Azure Machine Learning workspace for the first time, you'll work with the Azure CLI *interactively* at first.

After testing and development, you'll know which commands you need to use to create the necessary resources. Instead of running commands, you'll want to run *scripts* in *production*. Scripts are a way to *automate repetitive tasks*, like the creation of new Azure Machine Learning workspaces for future projects. To create a script, you simply list the commands you want to execute. You can also run scripts on remote compute, as part of a machine learning operations pipeline.

## Install the Azure Machine Learning extension for CLI (v2)

After you installed the Azure CLI, or set up the Azure Cloud Shell, you need to install the Azure Machine Learning extension so that you can manage Azure Machine Learning resources using the Azure CLI.

### Install on Windows

You can install the Azure Machine Learning extension `ml` with the following command:

```azurecli
az extension add -n ml -y
```

You can then run the help command `-h` to check that the extension is installed and to get a list of commands available with this extension. The list gives an overview of the tasks you can execute with the Azure CLI extension for Azure Machine Learning:

```azurecli
az ml -h
```

### Install on Linux

After you installed the Azure CLI on Linux, you can install the Azure Machine Learning extension. Use Bash to run the following command:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 
az extension add -n ml -y
```

> [!Tip]
> Find a more detailed description to [install and set up the CLI (v2)](/azure/machine-learning/how-to-configure-cli) in the Azure Machine Learning documentation.

## Sign in to Azure

Once you have the Azure CLI and the Azure Machine Learning extension installed, you want to allow the Azure CLI to connect to your Azure subscription. You can connect the CLI to your subscription by authenticating with the `login` command:

```azurecli
az login
```

The `login` command will open up a browser where you can sign in to Azure so that the CLI can use your Azure subscription. If you have multiple subscriptions attached to your account, you can set your active subscription:

```azurecli
az account set -s "<YOUR_SUBSCRIPTION_NAME_OR_ID>"
```

With the Azure Machine Learning extension installed on your computer or in the Azure Cloud Shell, you're ready to start experimenting.

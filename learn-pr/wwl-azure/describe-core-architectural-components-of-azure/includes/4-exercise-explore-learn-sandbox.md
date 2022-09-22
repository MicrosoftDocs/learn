In this exercise, you explore the Learn sandbox. You can interact with the Learn sandbox in three different ways. During exercises, you'll be provided for instructions for at least one of the methods below.

You start by activating the Learn sandbox. Then, you’ll investigate each of the methods to work in the Learn sandbox.

## Activate the Learn Sandbox

If you haven’t already, use the Activate sandbox button above to activate the Learn sandbox.

If you receive a notice saying Microsoft Learn needs your permission to create Azure resource, use the Review permission button to review and accept the permissions. Once you approve the permissions, it may take a few minutes for the sandbox to activate.

## Task 1: Use the PowerShell CLI

Once the sandbox launches, half the screen will be in PowerShell command line interface (CLI) mode. If you’re familiar with PowerShell, you can manage your Azure environment using PowerShell commands.

:::image type="content" source="../media/sandbox-powershell-11569b2c.png" alt-text="Screenshot of the Azure PowerShell CLI at initial launch.":::


> [!TIP]
> You can tell you're in PowerShell mode by the PS before your directory on the command line.

Use the PowerShell Get-date command to get the current date and time.

```powershell
Get-date
```

Most Azure specific commands will start with the letters az. The Get-date command you just ran is a PowerShell specific command. Let's try an Azure command to check what version of the CLI you're using right now.

```powershell
az version
```

## Task 2: Use the BASH CLI

If you’re more familiar with BASH, you can use BASH command instead by shifting to the BASH CLI.

Enter bash to switch to the BASH CLI.

```powershell
bash
```

:::image type="content" source="../media/sandbox-bash-363cf104.png" alt-text="Screenshot of the Azure BASH CLI at initial launch.":::


> [!TIP]
> You can tell you're in BASH mode by the username displayed on the command line. It will be your username@azure.

Again, use the Get-date command to get the current date and time.

```azurecli
Get-date
```

You received an error because Get-date is a PowerShell specific command.

:::image type="content" source="../media/sandbox-bash-date-8b20e391.png" alt-text="Screenshot of BASH error message get-date command not found.":::


Use the date command to get the current date and time.

```azurecli
date
```

Just like in the PowerShell mode of the CLI, you can use the letters az to start an Azure command in the BASH mode. Try to run an update to the CLI with az upgrade.

```azurecli
az upgrade
```

You can change back to PowerShell mode by entering pwsh on the BASH command line.

## Task 3: Use Azure CLI interactive mode

Another way to interact is using the Azure CLI interactive mode. This changes CLI behavior to more closely resemble an integrated development environment (IDE). Interactive mode provides autocompletion, command descriptions, and even examples. If you’re unfamiliar with BASH and PowerShell, but want to use the command line, interactive mode may help you.

Enter az interactive to enter interactive mode.

```azurecli
az interactive
```

Decide whether you wish to send telemetry data and enter YES or NO.

You may have to wait a minute or two to allow the interactive mode to fully initialize. Then, enter the letter “a” and auto-completion should start to work. If auto-completion isn’t working, erase what you’ve entered, wait a bit longer, and try again.

:::image type="content" source="../media/azure-interactive-mode-c8421a2d.png" alt-text="Screenshot of interactive mode with autocompletion providing commands that start with A.":::


Once initialized, you can use the arrow keys or tab to help complete your commands. Interactive mode is set up specifically for Azure, so you don't need to enter az to start a command (but you can if you want to or are used to it). Try the upgrade or version commands again, but this time without az in front.

```azurecli
version
```

```azurecli
upgrade
```

The commands should have worked the same as before, and given you the same results. Use the exit command to leave interactive mode.

```azurecli
exit

```

## Task 4: Use the Azure portal

You’ll also have the option of using the Azure portal during sandbox exercises. You need to use the link provided in the exercise to access the Azure portal. Using the provided link, instead of opening the portal yourself, ensures the correct subscription is used and the exercise remains free for you to complete.

Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to check out the Azure web interface. Once in the portal, you can see all the services Azure has to offer as well as look around at resource groups and so on.

## Continue

You're all set for now. We'll come back to this sandbox later in this module and actually create an Azure resource!

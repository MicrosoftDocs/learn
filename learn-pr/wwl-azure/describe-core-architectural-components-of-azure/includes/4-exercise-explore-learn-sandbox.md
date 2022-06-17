In this exercise, you explore the Learn sandbox. You can interact with the Learn sandbox in three different ways. During exercises, you'll be provided for instructions for at least one of the methods below.

You start by simply activating the Learn sandbox. Then, you’ll investigate each of the methods to work in the Learn sandbox.

## Activate the Learn Sandbox

If you haven’t already, use the Activate sandbox button to activate the Learn sandbox.

:::image type="content" source="../media/sandbox-warning-e8585b5e.png" alt-text="Screenshot of the Activate sandbox button and associated text.":::


If you receive a notice saying Microsoft Learn needs your permission to create Azure resource, use the Review permission button to review and accept the permissions. Once you approve the permissions, it may take a minute or two for the sandbox to activate.

## Use the PowerShell CLI

Once the sandbox launches, half the screen will be in PowerShell command line interface (CLI) mode. If you’re familiar with PowerShell, you can manage your Azure environment using PowerShell commands.

:::image type="content" source="../media/sandbox-powershell-11569b2c.png" alt-text="Screenshot of the Azure PowerShell CLI at initial launch.":::


> [!TIP]
> You can tell your in PowerShell mode by the PS before your directory on the command line.

Use the PowerShell Get-date command to get the current date and time.

```powershell
Get-date
```

## Use the BASH CLI

If you’re more familiar with BASH, you can use BASH command instead by shifting to the BASH CLI.

Enter bash to switch to the BASH CLI.

```powershell
bash
```

:::image type="content" source="../media/sandbox-bash-363cf104.png" alt-text="Screenshot of the Azure BASH CLI at initial launch.":::


> [!TIP]
> You can tell your in BASH mode by the username displayed on the command line. It’ll be your username@azure

Again, use the Get-date command to get the current date and time.

```azurecli
Get-date

```

You received an error because Get-date is a PowerShell specific command.

:::image type="content" source="../media/sandbox-bash-date-8b20e391.png" alt-text="Screenshot of BASH error message "get-date command not found".":::


Use the date command to get the current date and time.

```azurecli
date
```

You can change back to PowerShell mode by entering pwsh on the BASH command line.

## Use Azure CLI interactive mode

An additional way to interact is using the Azure CLI interactive mode. This changes CLI behavior to more closely resemble an integrated development environment (IDE). Interactive mode provides autocompletion, command descriptions, and even examples. If you’re unfamiliar with BASH and PowerShell, but want to use the command line, interactive mode may help you.

Enter az interactive to enter interactive mode.

```azurecli
az interactive
```

Decide wether you wish to send telemetry data and enter YES or NO.

You may have to wait a minute or two to allow the interactive mode to fully initialize. Then, enter the letter “a” and auto-completion should start to work. If auto-completion isn’t working, erase what you’ve entered, wait a bit longer, and try again.

:::image type="content" source="../media/azure-interactive-mode-c8421a2d.png" alt-text="Screenshot of interactive mode with autocompletion providing commands that start with A.":::


Once initialized, you can use the arrow keys or tab to help complete your commands.

Check what resource are currently deployed by either entering the full command or letting interactive mode help.

```azurecli
az resource list –query [].type –output tsv
```

That should give you a truncated list of resources.

Enter exit to leave interactive mode.

```azurecli
exit

```

## Use the Azure portal

You’ll also have the option of using the Azure portal during sandbox exercises. It’s important that you use the link provided in the exercise to access the Azure portal to ensure the exercise remains free for you to complete.

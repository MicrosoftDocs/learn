In this exercise, you explore ways to interact with Microsoft Azure. You can interact with Azure in different ways, including through the web portal or using the Azure command line interface (CLI) with PowerShell or Bash commands.

## Access the Azure Portal

The Azure portal provides a graphic user interface (GUI) to interact with Azure services. You can navigate to different service areas, manage subscriptions and accounts, search for specific services or settings, and so on.

The Azure portal is accessed at [https://portal.azure.com](https://portal.azure.com/?azure-portal=true)

Once you're logged into the portal, you can navigate around Azure using the interface, or you can use the command line interface with PowerShell and BASH commands.

## Use the command line interface

You can use the CLI from within the Azure portal. Once logged into Azure, access the CLI by selecting the Cloud Shell icon. Launching Cloud Shell brings up a CLI window in PowerShell or BASH mode. If you’re familiar with PowerShell, you can manage your Azure environment using PowerShell commands.

To access CloudShell from the Azure portal, select the CloudShell icon.
:::image type="content" source="../media/open-cloudshell.png" alt-text="Screenshot of the Azure Portal action area with the CloudShell icon pointed out.":::

You can quickly change between PowerShell and BASH in the CLI by selecting the **Switch to ...** button or entering `BASH` or `PWSH`.

:::image type="content" source="../media/switch-button.png" alt-text="Screenshot of the Switch to button in the Azure command line interface.":::

:::image type="content" source="../media/sandbox-powershell-11569b2c-7a9a0db5.png" alt-text="Screenshot of the Azure PowerShell CLI at initial launch.":::


> [!TIP]
> When in PowerShell mode, the command line starts with PS. When in BASH mode, the command line starts with your user name@azure.
>
> :::image type="content" source="../media/sandbox-powershell-11569b2c-7a9a0db5.png" alt-text="Screenshot of the Azure PowerShell CLI at initial launch.":::

Use the PowerShell Get-date command to get the current date and time.

```powershell
Get-date
```

The Get-date command is a PowerShell specific command. Most Azure specific commands start with the letters **az**. Let's try an Azure command to check what version of the CLI you're using right now.

```powershell
az version
```

## Task 2: Use the BASH CLI

If you’re more familiar with BASH, you can use BASH commands instead by shifting to the BASH CLI.

Enter bash to switch to the BASH CLI.

```powershell
bash
```

:::image type="content" source="../media/sandbox-bash-363cf104-9c91b89d.png" alt-text="Screenshot of the Azure BASH CLI at initial launch.":::


> [!TIP]
> You can tell you're in BASH mode by the username displayed on the command line, your username@azure.

Again, use the Get-date command to get the current date and time.

```azurecli
Get-date
```

You received an error because Get-date is a PowerShell specific command.

:::image type="content" source="../media/sandbox-bash-date-8b20e391-afa1b510.png" alt-text="Screenshot of BASH error message get-date command not found.":::


Use the date command to get the current date and time.

```azurecli
date
```

Just like in the PowerShell mode of the CLI, use the letters az to start an Azure command in the BASH mode. Try to run an update to the CLI with az upgrade.

```azurecli
az upgrade
```

You can change back to PowerShell mode by entering pwsh on the BASH command line.

## Task 3: Use Azure CLI interactive mode

Another way to interact is using the Azure CLI interactive mode. This changes CLI behavior to more closely resemble an integrated development environment (IDE). Interactive mode provides autocompletion, command descriptions, and even examples. If you’re unfamiliar with BASH and PowerShell, but want to use the command line, interactive mode may help you.

Enter `az interactive` to enter interactive mode.

```azurecli
az interactive
```

Decide whether you wish to send telemetry data and enter YES or NO.

You may have to wait a minute or two to allow the interactive mode to fully initialize. Then, enter the letter “a” and auto-completion should start to work. If auto-completion isn’t working, wait a bit longer and try again.

:::image type="content" source="../media/azure-interactive-mode-c8421a2d-3c3d662b.png" alt-text="Screenshot of interactive mode with autocompletion providing commands that start with A.":::


Once initialized, you can use the arrow keys or tab to help complete your commands. Interactive mode is set up specifically for Azure, so you don't need to enter az to start a command. Try the upgrade or version commands again, but this time without az in front.

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

## Continue

You're all set for now.

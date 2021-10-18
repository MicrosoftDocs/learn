## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control on the right displays **bash**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with bash displayed in the dropdown control.":::

   If **bash** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **bash**.

   :::image type="content" source="media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window that displays the dropdown list for selecting a preferred terminal shell.":::

1. In the terminal, select the plus sign (**+**) to create a new terminal with Bash as the shell.

[!INCLUDE [Upgrade Azure CLI](azure-template-bicep-exercise-upgrade-cli.md)]

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true).

1. To open a Visual Studio Code terminal window, select **Terminal** > **New Terminal**. The window usually opens at the bottom of your screen.

1. If the dropdown control at the right displays **pwsh** or **PowerShell**, the correct shell is open and you can skip to the next section.

   :::image type="content" source="media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with text signifying PowerShell displayed in the dropdown control.":::

   If **pwsh** or **PowerShell** isn't displayed, select the dropdown control, choose **Select Default Shell**, and then select **pwsh** or **PowerShell**.

   :::image type="content" source="media/select-shell.png" alt-text="Screenshot of the Visual Studio Code terminal window that displays the dropdown list for selecting your preferred terminal shell.":::

1. In the terminal, select the plus sign (**+**) to create a new terminal with pwsh or PowerShell as the shell.

[!INCLUDE [Upgrade Azure PowerShell](azure-template-bicep-exercise-upgrade-powershell.md)]

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

## Create a resource group in Azure

::: zone pivot="cli"

To create a new resource group, run this Azure CLI command in the Visual Studio Code terminal:

```azurecli
az group create --name ToyWebsiteTest --location westus
```

::: zone-end

::: zone pivot="powershell"

To create a resource group, run this Azure PowerShell command in the Visual Studio Code terminal:

```azurepowershell
New-AzResourceGroup -Name ToyWebsiteTest -Location westus
```

::: zone-end

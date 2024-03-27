---
author: mumian
ms.topic: include
ms.date: 11/14/2021
ms.author: jgao
---
## Sign in to Azure

::: zone pivot="cli"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've installed the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true) tools.

1. In the **Terminal** menu, select **New Terminal**. The terminal window usually opens in the lower half of your screen.

1. If the shell shown on the right side of the terminal window is **bash**, the correct shell is open and you can skip to the next section.

    :::image type="content" source="media/bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the bash option shown.":::

1. If a shell other than **bash** appears, select the shell dropdown, and then select **Git Bash (Default)**.

    :::image type="content" source="media/select-shell-bash.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the terminal shell dropdown shown and Git Bash Default selected.":::

1. In the list of terminal shells, select **bash**, and then select the plus sign to open a new terminal that uses the **bash** shell.

   :::image type="content" source="media/select-bash-plus.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the bash terminal and the plus sign selected.":::

### Sign in to Azure by using the Azure CLI

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurecli
   az login
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

::: zone pivot="powershell"

To work with resource groups in Azure, sign in to your Azure account from the Visual Studio Code terminal. Be sure that you've [installed Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true).

1. In the **Terminal** menu, select **New Terminal**. The terminal window usually opens in the lower half of your screen.

1. If the shell shown on the right side of the terminal window is **powershell** or **pwsh**, the correct shell is open and you can skip to the next section.

    :::image type="content" source="media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the p w s h option displayed in the shell dropdown.":::

1. If a shell other than **powershell** or **pwsh** appears, select the shell dropdown, and then select **PowerShell**.

    :::image type="content" source="media/select-shell-powershell.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the terminal shell dropdown shown and powershell selected.":::

1. In the list of terminal shells, select **powershell** or **pwsh**, and then select the plus sign to open a new terminal that uses the **powershell** or **pwsh** shell.

   :::image type="content" source="media/select-powershell-plus.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the powershell terminal and the plus sign selected.":::

### Sign in to Azure by using Azure PowerShell

1. In the Visual Studio Code terminal, run the following command to sign in to Azure:

   ```azurepowershell
   Connect-AzAccount
   ```

1. In the browser that opens, sign in to your Azure account.

::: zone-end

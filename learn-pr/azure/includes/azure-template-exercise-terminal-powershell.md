---
author: mumian
ms.topic: include
ms.date: 11/09/2022
ms.author: jgao
---

1. On the **Terminal** menu, select **New Terminal**. The terminal window usually opens in the lower half of your screen.

1. If the shell shown on the right side of the terminal window is **powershell** or **pwsh**, the correct shell is open, and you can skip to the next section.

    :::image type="content" source="media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the pwsh option displayed in the shell dropdown list.":::

1. If a shell other than **powershell** or **pwsh** appears, select the shell dropdown arrow, and then select **PowerShell**.

    :::image type="content" source="media/select-shell-powershell.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the terminal shell dropdown list shown and PowerShell selected.":::

1. In the list of terminal shells, select **powershell** or **pwsh**.

   :::image type="content" source="media/select-powershell.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the PowerShell terminal selected.":::

1. In the terminal, go to the directory where you saved your template. For example, if you saved your template in the _templates_ folder, you can use this command:

   ```azurepowershell
   Set-Location -Path templates
   ```

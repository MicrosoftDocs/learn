---
author: mumian
ms.topic: include
ms.date: 01/15/2025
ms.author: jgao
---

1. On the **Terminal** menu, select **New Terminal**. The terminal window usually opens in the lower half of your screen.

1. If the terminal window displays **pwsh** or **powershell** on the right side, it means the correct shell is already open. Alternatively, if you see a powershell shell icon on the right, you can select it to launch the shell.

    :::image type="content" source="media/pwsh.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the pwsh option displayed in the shell dropdown list.":::

  If a shell other than **pwsh** or **powershell** appears, select the shell dropdown arrow, and then select **PowerShell**.

    :::image type="content" source="media/select-shell-powershell.png" alt-text="Screenshot of the Visual Studio Code terminal window, with the terminal shell dropdown list shown and PowerShell selected.":::

1. In the terminal, go to the directory where you saved your template. For example, if you saved your template in the _templates_ folder, you can use this command:

   ```azurepowershell
   Set-Location -Path templates
   ```

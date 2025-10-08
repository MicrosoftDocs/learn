Use a script editor such as the **Windows PowerShell Integrated Scripting Environment (ISE)** to write the workflow. It enforces workflow syntax and highlights syntax errors. For more information, review the tutorial [Tutorial - Create a PowerShell Workflow runbook in Azure Automation](/azure/automation/learn/automation-tutorial-runbook-textual).

A benefit of using **PowerShell ISE** is that it automatically compiles your code and allows you to save the artifact. Because the syntactic differences between scripts and workflows are significant, a tool that understands both workflows and scripts will save you considerable coding and testing time.

## Workflow syntax

When you create your workflow, begin with the **workflow** keyword, which identifies a workflow command to **PowerShell**. A script workflow requires the **workflow** keyword. Next, name the workflow, and have it follow the **workflow** keyword. The body of the workflow will be enclosed in braces.

### Creating a workflow

1.  A workflow is a **Windows** command type, so select a name with a **verb-noun** format:

    ```powershell
    workflow Test-Workflow
      {
          ...
      }

    ```

### Adding parameters

2.  To add parameters to a workflow, use the **Param** keyword. It's the same technique that you use to add parameters to a function.

### Adding commands

3.  Finally, add your standard **PowerShell** commands:

    ```powershell
    workflow MyFirstRunbook-Workflow
      {
          Param(
                [string]$VMName,
                [string]$ResourceGroupName
            )
            ....
          Start-AzureRmVM -Name $VMName -ResourceGroupName $ResourceGroupName
      }

    ```

## Key workflow features

**PowerShell Workflow** provides additional capabilities beyond standard **PowerShell** scripts:

- **Checkpoints:** Use `Checkpoint-Workflow` to save the workflow state and resume from that point if interrupted.
- **Parallel processing:** Use the `Parallel` keyword to execute multiple tasks simultaneously.
- **InlineScript:** Use `InlineScript` blocks to run standard **PowerShell** code within a workflow when workflow syntax limitations exist.

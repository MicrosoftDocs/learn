**Runbooks** serve as repositories for your custom scripts and workflows. They typically reference **Automation shared resources** such as **credentials**, **variables**, **connections**, and **certificates**.

**Runbooks** can also contain other runbooks, allowing you to build more complex workflows. You can invoke and run runbooks on-demand or according to a schedule using **Automation Schedule** assets.

:::image type="content" source="../media/create-runbook-81c5672e.png" alt-text="Screenshot of the Add Runbook window. In the left pane, Quick Create, create a new runbook is selected. In the right pane, the runbook type dropdown menu displays options such as PowerShell, Python 2, Graphical, and Other. Under Other is PowerShell Workflow, and Graphical PowerShell workflow.":::

## Creating runbooks

When creating **runbooks**, you have two options:

- **Create your runbook and import it:** For more information about creating or importing a runbook in **Azure Automation**, go to [Start a runbook in Azure Automation](/azure/automation/start-runbooks).
- **Modify runbooks from the runbook gallery:** Provides a rich ecosystem of runbooks that are available for your requirements. Visit [Runbook and module galleries for Azure Automation](/azure/automation/automation-runbook-gallery) for more information.

An open-source community also creates runbooks you can apply directly to your use cases.

## Choosing a runbook type

You can choose from different runbook types based on your requirements and **Windows PowerShell** experience:

- **PowerShell runbooks:** If you prefer to work directly with **Windows PowerShell** code.
- **PowerShell Workflow runbooks:** For workflows that require checkpoints and parallel processing.
- **Graphical runbooks:** If you prefer to edit without exposure to the underlying code using the **Azure portal's** graphical editor.

## Runbook types

### Graphical runbooks

**Graphical runbooks** and **Graphical PowerShell Workflow runbooks** are created and edited with the graphical editor in the **Azure portal**. You can export them to a file and import them into another automation account, but you can't create or edit them with another tool.

**Key characteristics:**

- Visual design without code exposure
- Drag-and-drop interface in **Azure portal**
- Ideal for users without scripting experience

### PowerShell runbooks

**PowerShell runbooks** are based on **Windows PowerShell**. You edit the runbook code directly using the text editor in the **Azure portal**. You can also use any offline text editor and import the runbook into **Azure Automation**.

**Key characteristics:**

- Based on **PowerShell** scripting language
- Don't use parallel processing
- Execute commands sequentially
- Faster startup time compared to **PowerShell Workflow runbooks**

### PowerShell Workflow runbooks

**PowerShell Workflow runbooks** are text runbooks based on **Windows PowerShell Workflow**. You directly edit the runbook code using the text editor in the **Azure portal**. You can also use any offline text editor and import the runbook into **Azure Automation**.

**Key characteristics:**

- Use parallel processing for simultaneous task completion
- Support checkpoints for workflow resilience
- Take longer to start than **PowerShell runbooks** because they must be compiled before running
- Ideal for long-running operations that need to resume after interruption

### Python runbooks

You can directly edit the code of the runbook using the text editor in the **Azure portal**, or you can use any offline text editor and import the runbook into **Azure Automation**.

**Key characteristics:**

- Support **Python** libraries
- Must import third-party packages into the **Automation Account** before use
- Useful for integrating with **Python**-based tools and services

> [!NOTE]
> You can't convert runbooks from graphical to textual type and vice versa.

For more information on the different types of runbooks, visit [Azure Automation runbook types](/azure/automation/automation-runbook-types).

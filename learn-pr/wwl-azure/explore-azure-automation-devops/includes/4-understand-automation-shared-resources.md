**Azure Automation** contains shared resources that are globally available to be associated with or used in a runbook.

## Shared resource categories

There are eight shared resource categories:

- **Schedules:** Define one-time or recurring schedules to automatically execute runbooks at specific times.
- **Modules:** Contains **Azure PowerShell modules** that provide cmdlets for managing **Azure resources**.
- **Modules gallery:** Allows you to identify and import **PowerShell modules** into your **Azure Automation account**.
- **Python packages:** Import **Python** packages by uploading **.whl** or **tar.gz** packages for use in **Python runbooks**.
- **Credentials:** Create username and password credentials to securely authenticate against **Azure** or external services.
- **Connections:** Specify **Azure**, **Azure classic certificate**, or **Azure Service Principal** connections for resource authentication.
- **Certificates:** Upload certificates in **.cer** or **.pfx** format for secure authentication and encryption.
- **Variables:** Define encrypted or unencrypted variables of types such as **String**, **Boolean**, **DateTime**, **Integer**, or no specific type.

:::image type="content" source="../media/shared-resources-4e336a1e.png" alt-text="Screenshot of the shared resources section in the Azure Automation account pane. Eight shared resources display, Schedules, Modules, Modules gallery, Python 2 packages, Credentials, Connections, Certificates, and Variables.":::

## Best practices for shared resources

As a best practice, create global assets to be used across your runbooks. This approach saves time and reduces the number of manual edits within individual runbooks.

**Benefits of shared resources:**

- **Consistency:** Use the same credentials, connections, and variables across multiple runbooks.
- **Maintainability:** Update a shared resource once and it applies to all runbooks using it.
- **Security:** Store sensitive information securely in encrypted credentials and variables.
- **Reusability:** Avoid duplicating configuration across multiple runbooks.

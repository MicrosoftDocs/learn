Azure Automation contains shared resources that are globally available to be associated with or used in a runbook.

There are currently eight shared resources categories:

 -  **Schedules**: It allows you to define a one-off or recurring schedule.
 -  **Modules**: Contains Azure PowerShell modules.
 -  **Modules gallery**: It allows you to identify and import PowerShell modules into your Azure automation account.
 -  **Python packages**. Allows you to import a Python package by uploading: **.whl** or **tar.gz** packages.
 -  **Credentials**: It allows you to create username and password credentials.
 -  **Connections**: It allows you to specify Azure, Azure classic certificate, or Azure Service principal connections.
 -  **Certificates**: It allows you to upload certificates in .cer or pfx format.
 -  **Variables**: It allows you to define encrypted or unencrypted variables of types—for example, *String*, *Boolean*, *DateTime*, *Integer*, or no specific type.

:::image type="content" source="../media/shared-resources-4e336a1e.png" alt-text="Screenshot of the shared resources section in the Azure Automation account pane. Eight shared resources display, Schedules, Modules, Modules gallery, Python 2 packages, Credentials, Connections, Certificates, and Variables.":::


As a best practice, always try to create global assets to be used across your runbooks.

It will save time and reduce the number of manual edits within individual runbooks.

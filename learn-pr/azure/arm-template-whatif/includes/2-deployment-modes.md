Azure Resource Manager supports using *deployment modes*. There are two deployment modes:

- **Incremental mode**. The default deployment mode is incremental. In this mode, Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are *added* to the resource group.
- **Complete mode**. When you use this mode, resources not specified in the template are *deleted*. If you know for sure that what's in the template file constitutes the full state of your deployment, then go ahead and use this mode. If you use tools like the Azure CLI or PowerShell to update your state gradually, then incremental mode is the way to go.

   > [!CAUTION]
   > When you run the command in complete mode, whatever resources you have will be removed if they're not mentioned in the template file.

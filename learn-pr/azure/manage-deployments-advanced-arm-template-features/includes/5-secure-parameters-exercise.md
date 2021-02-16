In the previous exercise, you ran a basic Azure Resource Manager (ARM) template that provisions a Linux virtual machine. In this part, you follow a similar process.

This time, instead of passing the password as a parameter, you store the password in Azure Key Vault. To enable the ARM template to access the password, you create a parameter file that references the key vault secret in your subscription.

::: zone pivot="powershell"

[!include[](./powershell/5-exercise-secure-parameters.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azcli/5-exercise-secure-parameters.md)]

::: zone-end

In the previous exercuse, you ran a basic ARM template that provisions a Linux virtual machine (VM). In this part, you follow a similar process.

This time, instead of passing the password as a parameter, you store the password in Azure Key Vault. To enable the ARM template to access the password, you create a parameters file that references the Key Vault secret in your subscription.

::: zone pivot="powershell"

[!include[](./powershell/5-exercise-secure-parameters-powershell.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azcli/5-exercise-secure-parameters-azcli.md)]

::: zone-end

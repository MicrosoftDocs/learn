You will often need to deploy resources, like a VM, that need passwords set during deployment. One way to solve that scenario would be to set a password via a parameter, during deployment. A better way is to store passwords in a Key Vault and read from said Key Vault during deployment.

::: zone pivot="powershell"

[!include[](./powershell/5-exercise-secure-parameters-powershell.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azcli/5-exercise-secure-parameters-azcli.md)]

::: zone-end

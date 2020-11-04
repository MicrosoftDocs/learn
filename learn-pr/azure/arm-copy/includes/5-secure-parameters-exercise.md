You will need to create resources that need passwords set during deployment. A template should not contain passwords so you need to store your secrets in a safe place. Additionally you need to read those secrets when you deploy the template.

::: zone pivot="powershell"

[!include[](./powershell/5-exercise-secure-parameters-powershell.md)]

::: zone-end

::: zone pivot="cli"

[!include[](./azcli/5-exercise-secure-parameters-azcli.md)]

::: zone-end

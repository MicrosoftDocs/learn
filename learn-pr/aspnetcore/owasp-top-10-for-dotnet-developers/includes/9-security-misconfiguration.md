## A05: Security Misconfiguration

With more shifts into highly configurable software, it's not surprising to see this category move up.
The application might be vulnerable if the application is without a rigorous repeatable application security configuration process.

> [!TIP]
> Challenge the defaults.
<!-- :::image type="content" source="../media/abel.png" alt-text="Don't accept the defaults - Abel Wang"::: -->

Security misconfiguration can manifest itself in many places, from `web.cofnig` or `appsettings.json` settings, database account and connectivity configuration, IIS configurations to CI/CD pipeline secret handling or incorrect Azure Role Base Access Control use.

:::image type="content" source="../media/pipeline.png" alt-text="Azure DevOps Library linked with Azure KeyVault":::

The example about demonstrates one of many native integrations between Azure DevOps and Azure Cloud where Azure DevOps Library is linked with Azure KeyVault to securely access secret pipeline parameters.
Secret values should never be found in codebase. The same practice applies to infrastructure as code (IaC) release workflows and CI/CD services themselves.

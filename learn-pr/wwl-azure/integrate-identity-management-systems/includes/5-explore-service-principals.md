Workload identities constitute identity constructs assigned to software workloads (applications, services, scripts, containers) enabling protected environment access. Azure Pipelines and GitHub Actions deployment scenarios require establishing security contexts granting Azure subscription resource provisioning privileges. Workload identities provide these security contexts through integrated authentication and authorization support.

Microsoft Entra ID implements three distinct workload identity classifications:

- **Application:** Microsoft Entra ID object representing global software application definitions established by developers. Application registration creates objects determining token issuance mechanisms, required resource access scopes, and permissible application actions.
- **Service principal:** Microsoft Entra ID object constituting local application representations within specific Entra tenants. Service principal creation occurs during application registration within target usage tenants, utilizing application objects as provisioning templates. Service principal objects define tenant-specific application permissions, accessible resources, and authorized access subjects.
- **Managed identity:** Specialized service principal variant associated with Azure resources enabling autonomous authentication and authorization. Managed identities eliminate credential maintenance requirements through platform-managed credential lifecycle automation.

## Implement service principals

Traditional Azure Pipelines and GitHub Actions Azure subscription access provisioning relies on service principal-based authentication.

### Microsoft Entra applications

Application registration within Microsoft Entra tenant infrastructure establishes identity configurations. Registration workflows determine application usage authorization scope:

- Accounts in the same organizational directory
- Accounts in any organizational directory
- Accounts in any organizational directory and personal Microsoft accounts
- Personal accounts only

  :::image type="content" source="../media/workload-identities-register-application-635f9d16.png" alt-text="Screenshot of register an application feature.":::

## Client secret

Application provisioning completion requires client secret generation establishing authentication credentials.

:::image type="content" source="../media/workload-identities-client-secret-3f9f10d0.png" alt-text="Screenshot of the client secret feature.":::

## Grant permissions

Application identities receive permission grants within Microsoft Entra ID-trusting services and resources including Azure subscription-hosted infrastructure.

## Service principal

Resource access requires security principal representation. Connection establishment necessitates entity knowledge of:

- **TenantID:** Microsoft Entra tenant identifier
- **ApplicationID:** Application identifier (alternatively designated clientID)
- **Client Secret:** Authentication credential

For more information on Service Principals, see [App Objects and Service Principals](/entra/identity-platform/app-objects-and-service-principals).

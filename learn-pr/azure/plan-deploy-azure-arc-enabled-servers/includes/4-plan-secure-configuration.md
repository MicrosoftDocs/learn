Given that the deployment of Arc-enabled servers encompasses thousands of machines across multiple offices handling business-critical workloads, security is top of mind for Wide World Importers. As you plan a secure deployment, it's important to consider how you can apply access roles, policies, and networking in tandem to ensure compliance and protection of resources.

Azure Arc-enabled servers benefit from built-in security, with encryption and data sharing by design, and offer a range of added security configurations. To ensure a secure deployment, you might need to prepare an effective landing zone for Arc-enabled resources by configuring the appropriate access controls, governance infrastructure, and advanced networking options. In this unit, you learn to:

1. **Configure role-based access control (RBAC)**: Develop an access plan to control who can manage Azure Arc-enabled servers and view their data from other Azure services.

1. **Develop an Azure Policy governance plan**: Determine how you want to implement governance of hybrid servers and machines at the subscription or resource group scope with Azure Policy.

1. **Select advanced networking options**: Evaluate whether a proxy server or Azure Private Link is necessary for your Arc-enabled server deployment.

## Secure identities and access control

Each Azure Arc-enabled server has a managed identity as part of a resource group inside an Azure subscription. That identity represents the server running on-premises or in another cloud environment. Standard Azure role-based access control (RBAC) controls access to this resource. Two roles specific to Arc-enabled servers are Azure Connected Machine Onboarding and Azure Connected Machine Resource Administrator.

Use the **Azure Connected Machine Onboarding** role for identities that register machines. Assign it at the smallest appropriate scope, normally the target resource group. Review its current permissions rather than treating it as a read-and-create-only role: it also includes supporting settings access, data collection rule (DCR) association read/write/delete operations, and limited extension setup through `Microsoft.HybridCompute/machines/addExtensions/action`. It doesn't provide unrestricted ongoing extension administration or permission to delete Arc machine resources.

Use **Azure Connected Machine Resource Administrator** when an operator must read, manage, re-onboard, or delete Arc machines and their extensions. This role also includes permissions for other Arc infrastructure, such as gateways, private-link scopes, and licenses, as well as resource deployments. Scope it according to the resources the operator actually needs to administer.

> [!NOTE]
> A service principal is an application identity, not an automatic least-privilege boundary. Its effective permissions come from its role assignments and their scopes. Explicitly assign the onboarding role and review any additional or inherited permissions before distributing onboarding credentials.

Additionally, the Azure Connected Machine agent uses public-key authentication to communicate with the Azure service. After you onboard a server to Azure Arc, a private key is saved to the disk and used whenever the agent communicates with Azure. If stolen, the private key can be used on another server to communicate with the service and act as if it were the original server. A stolen private key can also get access to the system-assigned identity and any resources to which that identity has access. The agent restricts access to its managed identity certificate directory to local administrators and the `himds` account. This protection doesn't isolate the credential from a local administrator. Control local administrator access, and don't modify the agent-managed certificate files or their access permissions. To prevent offline attacks, we strongly recommend the use of full disk encryption (for example, BitLocker, dm-crypt, etc.) on the operating system volume of your server. Full-disk encryption protects against offline access; it doesn't prevent an authorized administrator on a running server from accessing the credential.

## Azure Policy governance

Azure Policy includes built-in regulatory-compliance initiatives that map policy assessments to selected controls. Use Microsoft cloud security benchmark for Microsoft's cloud-security baseline, and select additional initiatives and versions that match your organization's regulatory obligations.

Consult the current built-in initiative catalog before assigning an initiative. Examples include NIST SP 800-53 Rev. 5 and ISO/IEC 27001:2022; the available catalog also retains some earlier standard versions. Select the appropriate version with your compliance team rather than treating a newer publication date as automatic evidence that an older Azure Policy initiative is unavailable.

An Azure Policy compliance result covers the controls evaluated by its assigned definitions. It doesn't by itself certify that the organization satisfies every requirement of a regulatory standard.

Assign the required Azure Policy definitions or initiatives at the appropriate management-group, subscription, or resource-group scope before onboarding servers. Review each definition's effect and applicability: audit policies report compliance, while supported deployment or modification effects can change resources.

For `deployIfNotExists` and `modify` policies, configure the policy assignment's managed identity and grant the minimum roles needed for the deployment or remediation. The portal can grant the roles listed by the definition; assignments created through other tools require you to ensure those role assignments are made.

New or updated resources are handled according to the selected policy effect. Use remediation tasks for existing noncompliant resources that the supported effects can remediate. Inspect policy compliance and remediation-task results; an assignment alone doesn't prove that deployment or guest configuration succeeded. Guest-configuration assessment and enforcement are distinct from resource-deployment effects: some guest configurations audit only, and no policy assignment automatically fixes every security vulnerability.

## Secure networking with Private Link

Choose a connectivity design that meets your organization's routing and network-isolation requirements. The Connected Machine agent already encrypts its outbound Azure traffic. A proxy can centralize egress routing and help enforce organizational network policy, but it doesn't by itself add encryption to the agent connection or make the Azure endpoints private. Azure Private Link provides private-endpoint connectivity for the Arc endpoints that support it.

If your network requires a proxy, configure its address and port when generating the onboarding script, or use the documented agent-specific proxy settings. Follow the current network requirements. Some extensions need their own proxy configuration and don't inherit the Connected Machine agent's settings.

Azure Private Link provides private connectivity to the Arc endpoints that support it. Create an Azure Arc private link scope and private endpoint, associate the servers with the scope, and configure private DNS so the servers resolve the required private endpoint addresses. Connect the on-premises network to the Azure virtual network through ExpressRoute or a site-to-site VPN.

> [!IMPORTANT]
> An Arc private link scope doesn't make every Azure dependency private. Microsoft Entra ID and required public notification endpoints still need outbound access. Azure Resource Manager traffic doesn't traverse the Arc private link scope; using a separate resource-management private link is optional and requires its own supported configuration.

Azure Monitor and other connected services have separate networking requirements. For private Azure Monitor Agent (AMA) monitoring, configure the appropriate Azure Monitor Private Link Scope (AMPLS) and data collection endpoints (DCEs) as documented. Don't assume that the Arc private endpoint also carries monitoring ingestion or every extension's traffic.

Traffic from the private endpoint to the Azure service uses the Azure backbone. ExpressRoute avoids the public internet for its connection, while site-to-site VPN encrypts traffic over the public internet. Design firewall, routing, and DNS rules from the current endpoint requirements for the selected services.

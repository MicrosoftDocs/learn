The hybrid architecture of the Operator Nexus platform uses the robust and rich set of capabilities and services that Azure provides, such as Azure Monitoring.  Nexus uses Azure centralized cloud management services for simplified management of the on-premises infrastructure and for policy management. The hybrid environment provides end-to-end (E2E) visibility, security, and life cycle management of the on-premises network stack.

Using a hybrid architecture allows organizations to:

- Take advantage of their Azure experience and tools.
- Deploy infrastructure consistently every time using common APIs.
- Manage on-premises resources just like native Azure resources.
- Apply access and security controls in the same way.
- Provide an integrated infrastructure experience across network, compute, and storage.
- Integrate with third-party tools such as ServiceNow using Azure capabilities.

:::image type="content" source="../media/operator-nexus-hybrid-architecture.png" alt-text="Screenshot of Azure's integrated management and security features, including Azure Active Directory, Microsoft Defender, Azure Monitor, and resource management." border="false":::

The hybrid architecture of Operator Nexus provides four major components, each of which brings significant benefits:

- **Common identity platform:** Azure Active Directory (Azure AD) is a common identity platform that provides single-sign on (SSO) across on-premises and the cloud, making it simple for users to safely access the applications and assets they need. Admins can manage security and governance controls and also have the flexibility to adjust permissions without affecting the user experience. It also ensures consistency as users cross network or cloud boundaries.

- **Integrated management and security:** Microsoft Defender provides integrated management and security, offering a cohesive way to monitor, manage, and secure the environment, which enables increased visibility and control.

- **Integrated monitoring, logging, and alerting:** Azure Monitor provides integrated monitoring, logging, and alerting, offering seamless access to on-premises collected logs and metrics for deep observability insights from all Nexus sources.

- **Integrated access to and management of on-premises resources:** Azure Resource Manager enables the creation, update, and deletion of resources. When a user sends a request from Azure, the Resource Manager receives, authenticates, and authorizes the request, and then sends the request to the Azure service. The Azure service performs the requested action. Because all requests are handled through the same API, users see consistent results and capabilities whichever tool they use.

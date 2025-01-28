

As the project manager for a manufacturer, you utilize RISE with SAP on Microsoft Cloud to optimize business procedures, enhance teamwork, and automate tasks. Additionally, you explore the potential of Microsoft Power Platform, familiarize yourself with the features of Microsoft Copilot Studio, and understand how Microsoft Teams and SAP work together under RISE with SAP.

## Explore deployment options

### Deploy SAP and integrate the Microsoft Cloud

There are a range of SAP deployment options for combining with Microsoft Cloud:

- **RISE with SAP**: An SAP fully managed service that handles all underlying infrastructure, enabling businesses to concentrate on their core operations. When RISE with SAP is deployed in Azure, SAP owns and manages the Azure tenant and SAP services.
- **Customer managed VMs on Azure**: Businesses retain greater control over their SAP systems by managing their own virtual machines (VMs) on Azure. SAP on Azure VMs is a solution for businesses with specific customization needs or those desiring more hands-on control.
- **On-premises**: Host SAP applications on the business's own infrastructure for maximum control and customization. Ideal for organizations with strict data security needs or existing on-premises investments, and supports businesses still migrating to cloud VMs or RISE with SAP.

### Deploy Microsoft integration for RISE with SAP

The following Microsoft integration architecture example for SAP apples to RISE with SAP, Azure VMs, or on-premises, offering a wide range of options to suit different business needs and contexts. Regardless of the deployment option chosen, Azure networking and Microsoft Entra ID ensure seamless integration and secure access. Microsoft Entra ID use across products is beneficial for businesses with strict data sovereignty requirements, or businesses who want to use their existing infrastructure.

The following diagram shows the traffic flow from Power Platform and Copilot to SAP through Azure API Management:

:::image type="content" source="../media/traffic-flow.jpg" alt-text="Diagram that shows the traffic flow from Power Platform and Copilot to SAP through Azure API Management." lightbox="../media/traffic-flow.jpg":::

## Describe the key features of RISE with SAP on Microsoft Cloud

RISE with SAP on Microsoft Cloud provides a robust platform for businesses to run their SAP workloads efficiently. Key features include:

- **Scalability and flexibility**: The platform supports both on-premises and cloud-based SAP systems, allowing businesses to scale their operations as needed.
- **Integration with Microsoft services**: Seamless integration with Azure services, Microsoft Power Platform, and Microsoft Teams enhances functionality and collaboration.
- **Enhanced security**: Advanced security features to protect data protection and compliance with regulations.

> [!NOTE]
> For more information on the architecture and connectivity options, see the [SAP and Microsoft Power Platform architecture workflow](/azure/cloud-adoption-framework/scenarios/sap/sap-power-platform-architecture-workflow).

## Explain the integration of Azure with RISE with SAP

Azure services play a crucial role in supporting and enhancing the functionality of RISE with SAP. Key integration points include:

- **Network connectivity**: Azure provides network connectivity options to ensure seamless communication between SAP systems and other applications. Both virtual network peering and VPN connections can be used to connect the customer's Azure tenant to the SAP Azure tenant. These methods exist in practice and are used to ensure secure and efficient communication between the two environments. The chosen solution depends on the customer's requirements, existing infrastructure, and support levels by SAP. SAP owns the Azure tenant when RISE with SAP runs on Azure.
- **Identity management**: Microsoft Entra ID serves as the primary identity provider, managing user authentication and authorization for SAP applications and services. It enables single sign-on (SSO), allowing users to access multiple SAP services with a single set of credentials, simplifying the user experience and enhancing security. SAP Cloud Identity Services acts as a proxy identity provider, with Microsoft Entra ID configured as the leading identity provider. SAP Cloud Identity Services is added as a trusted application in Microsoft Entra ID, and all SAP applications and services are configured in the SAP Cloud Identity Services management console. Microsoft Entra ID also supports automated user provisioning, ensuring that new employees' user accounts are automatically created in SAP applications for seamless access and management.
- **Identity Security**: Microsoft Entra ID offers robust security features like multifactor authentication (MFA) and conditional access policies to protect user identities and ensure compliance. For SAP applications, principal propagation is used for SSO, allowing SAP Cloud Identity Authentication Services to act as a proxy identity provider, forwarding authentication requests to Microsoft Entra ID.
- **Data Services**: Azure Data Factory, Synapse, and Power BI enable advanced data analytics and reporting for SAP integration and SAP RISE environments. These tools facilitate seamless data movement, transformation, and visualization, providing valuable insights and enhancing decision-making processes.
- **Disaster Recovery and Backup**: With Azure Site Recovery and Azure Backup services, robust disaster recovery and backup capabilities are provided for the customer's Azure resources that integrate with RISE with SAP. While SAP controls the platform, these services ensure that the surrounding Azure resources are protected and compliant.
- **AI and machine learning**: Integration of Azure AI and Machine Learning services with SAP drives intelligent decision-making and process automation.
- **DevOps integration**: Azure DevOps Services offers, as a collection of cloud services, a set of development tools and services for efficient and reliable building, testing, and deployment of SAP applications.
- **Threat detection and Security**: Microsoft Sentinel provides comprehensive security analytics and threat intelligence across the enterprise, integrating with SAP systems to detect and respond to potential threats in real-time. Microsoft Defender for Cloud uses advanced machine learning and AI for automated threat detection in SAP environments, helping to identify issues quickly and accurately.
- **Compliance**: Microsoft provides tools like Azure Policy and Azure Blueprints to ensure compliance with regulatory standards for the customer's Azure resources that integrate with RISE with SAP. These tools aid auditing and reporting status to meet compliance requirements.
- **Sustainability**: By running SAP on Azure, businesses can contribute to environmental sustainability due to Microsoft's own commitment to sustainability.
- **Cost management and optimization**: Microsoft Cost Management and Azure Advisor services help businesses understand their cloud spending, find cost-saving opportunities, and optimize resource utilization on their Azure Tenants.

> [!NOTE]
> For detailed information on integrating Azure services with SAP RISE, visit [Integrating Azure with SAP RISE](/azure/sap/workloads/rise-integration).

## Microsoft Power Platform with RISE with SAP

Microsoft Power Platform extends the capabilities of SAP systems by enabling low-code development, automation, and analytics. Key components include:

- **Power Apps**: Create custom business applications that interact with SAP data.
- **Power Automate**: Automate workflows and tasks within SAP systems.
- **Power BI**: Generate real-time analytics and visualizations from SAP data.
- **Copilot Studio**: Integrate AI-driven copilots to enhance user interactions with SAP systems.

> [!NOTE]
> For more information on extending SAP with Microsoft Power Platform, see [Extend SAP by using Microsoft Power Platform](/azure/cloud-adoption-framework/scenarios/sap/sap-power-platform-fundamental).

## Microsoft Copilot Studio with SAP

Microsoft Copilot Studio, part of Microsoft Power Platform, enhances the SAP user experience by integrating AI-driven copilots. Key functionalities include:

- **Automated customer support**: Handle routine inquiries and support tickets.
- **Self-service capabilities**: Help users to perform simple tasks directly within SAP systems.
- **Streamlined processes**: Automate workflows like approvals and data entry.
- **Personalized user interactions**: Provide tailored experiences based on user roles and preferences.

> [!NOTE]
> For more information on integrating Copilot Studio with SAP, see [Enhancing Copilot Studio Extensions for SAP](https://techcommunity.microsoft.com/t5/running-sap-applications-on-the/enhancing-copilot-studio-extensions-for-sap-by-using-adaptive/ba-p/4187096).

## Microsoft Teams with RISE with SAP

Microsoft Teams facilitates communication and collaboration in RISE with SAP projects. Key integration points include:

- **Native SAP apps**: Access SAP applications directly from Teams.
- **Collaboration scenarios**: Boost productivity by interacting with SAP applications within Teams.
- **Real-time communication**: Enhance team collaboration with chat, video calls, and file sharing.

> [!NOTE]
> For more information, from SAP, on integrating Microsoft Teams with SAP, visit [SAP and Microsoft Expand Partnership](https://help.sap.com/docs/SAP_S4HANA_CLOUD/0f69f8fb28ac4bf48d2b57b9637e81fa/257ec7408db6420682462cd1d000e744.html).
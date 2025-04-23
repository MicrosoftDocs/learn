Microsoft Dev Box is a fully managed service that allows developers to quickly spin up pre-configured, cloud-based development environments with appropriate guardrails. These Dev Box virtual machines are secure, scalable, and customizable virtual machines that provide everything a developer needs to start coding within minutes.<br><br>Organizations can use the standard virtual machine images via the Azure Marketplace, or can bring in their existing base images, or pick an existing Azure Compute gallery image as a base image. They can utilize the team customizations and imaging capabilities to further customize images for different projects that have been created in the service. Team customizations and imaging features of the service allow you to include source code, SDKs, tools, and libraries tailored to specific projects in the virtual machines images. These customized images can be made available via the Azure Compute gallery. These images can then be deployed as Dev Box machines by the developer in the developer portal. <br><br>Unlike traditional development machines, Dev Box is accessible from anywhere via a browser or Remote Desktop application like Windows App. It also supports multimonitor setups, copy-paste, and file sharing providing a native desktop-like experience over the cloud.<br><br>Key features include:

- Dev Box machines scoped to different projects of developer teams.
- Secure and role-based access to projects. 
- Self-service provisioning for developers.
- Teams customizations to define tools, frameworks, and settings preconfigured for developers on their Dev Box machines.
- Creation of custom virtual machine images for use in building and provisioning Dev Box machines.
- Customizable VM images hosted in Azure Compute Gallery.
- Seamless integration with Microsoft Entra ID, Microsoft Intune, and conditional access.
- Developer portal for managing and switching between Dev Boxes.
- Dev Box machine snapshots and restores
- DIY connectivity troubleshooting

## Key organizational roles in Microsoft Dev Box implementation

There are several roles in an organization that get involved in deploying and managing Microsoft Dev Box end to end. They include platform engineers or IT administrators who are responsible for configuring the service. Developer team leads or Project Admins who are on point to configure the service for their team of developers for specific projects, assigning and managing permissions along with managing cost controls within the service. Developers are the end users, who typically use the developer portal to set up their Dev Box machines, access, and then manage them as appropriate. 

:::image type="content" source="../media/image-1.png" alt-text="Diagram of key roles required for Microsoft Dev Box.":::

### Platform engineers or IT administrators

- These teams are responsible for infrastructure and policy.
- Create and manage Dev Centers, Projects, and Dev Box pools.
- Configure network access, including DNS, subnets, and private endpoints.
- Set up governance, including conditional access, Multifactor Authentication (MFA) and compliance policies.
- Publish and manage VM images in Azure Compute Gallery.
- This role will require Azure owner or contributor role to configure the service in Azure.

### Developer team leads (Project Admins)

Team leads ensure that Dev Box machines are aligned with development goals:

- Set up Dev Box pools tailored to specific project or team requirements.
- Assign users and permissions via Entra ID groups.
- Configure setup scripts that automatically install required tools and dependencies for different projects.
- Monitor usage and optimize for cost by enabling auto-shutdown policies.

### Developers (Dev Box Users)

Developers benefit the most from Dev Box:

- Access multiple Dev Box machines for different tasks or projects.
- Launch or stop Dev Box machines on-demand via the developer portal.
- Avoid local setup conflicts and gain access to consistent, isolated environments.
- Work from anywhere with secure, performant access.


## Scenarios for utilizing Microsoft Dev Box

**Scenario 1: Onboarding New Developers**

New hire developers often wait days for local machine provisioning. With Dev Box, onboarding is reduced to minutes. Developers sign in, provision a Dev Box machine with all the tools they need and begin contributing on day one.

**Scenario 2: MultiProject Development**

Developers can create one or multiple Dev Box machines for their project to isolate dependencies and avoid software conflicts. This is especially useful when switching between microservices or legacy applications.

**Scenario 3: Security and Compliance**

For industries with high compliance needs, Dev Boxes can be configured to prevent data theft, enforce MFA, and ensure all traffic flows through corporate networks.

**Scenario 4: Global Developer Teams**

Teams spreads across the world can create Dev Box machines in Azure regions close to their location, reducing latency and improving development experience.
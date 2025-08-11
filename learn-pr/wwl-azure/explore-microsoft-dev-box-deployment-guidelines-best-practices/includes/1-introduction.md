
In this unit, you learn about the Microsoft Dev Box deployment guidelines and best practices for the service. Key topics include:
+ Planning and prerequisites
+ Roles and responsibilities
+ Service components
+ Architecture
+ Manual and automated deployments workflow
+ Security & compliance
+ Testing & validation
+ Rollout strategy. 

## Plan and understand the prerequisites

In this section you review the Dev Box service use case scenarios along with the personas in an organization, who get involved in deploying, managing, and maintaining the service.  You understand the roles and responsibilities for deploying and using the service along with reviewing the technical requirements for setting up the service. 

### Use cases & personas

There are a few different options for virtual desktops in Azure that can be used:

- Azure Virtual Machine
- Azure Virtual Desktop
- Windows 365 Cloud PC
- Microsoft Dev Box

Each of these Virtual Desktop Infrastructure (VDI) options has their benefits, and suit specific audiences when deciding on which virtual desktop solution to use.

Microsoft Dev Box is targeted at developers when thinking about the differentiating factors between each virtual desktop solution. IT and platform engineering teams use Azure to set up the required resources for Microsoft Dev Box. The developers use the self-serve developer portal to provision, manage, and maintain their Dev Box machines.   

Microsoft Dev Box also allows for easy customization of images using team customizations. Team customizations feature allows developers and developer leads with the appropriate permissions to customize Dev Box machines and install the software, SDK, libraries, and tools required to do their job, without relying on central platform teams.

### Roles and responsibilities

Dev Box service was designed to handle three different roles within an organization:

- **Platform Engineers or IT admins** - The platform engineers and IT admins are responsible for setting up the initial infrastructure required for Microsoft Dev Box. You'll learn more about the required resources as you progress through this module, but some examples are Dev center, Network connections, and Catalogs. Platform Engineers are also responsible for creating customized images that are required by developers on their Dev Box machines.
- **Development Team leads** - Development leads are responsible for creating projects within the Dev center. The number of projects required depend on the organizational requirements. The development team leads should have the appropriate permissions and knowledge to create a new project. While being able to assign other members of the development team to specific projects, team leads can also be responsible for creating and maintaining team customizations for Dev Box machines with specific required software installations.
- **Developers** - Developers are responsible for creating their own Dev Box machines using the Microsoft Developer portal. Developers can create single or multiple Dev Box machines for a single project or can reuse a Dev Box machine across multiple projects if required. Developers can also contribute to team customizations with the appropriate permissions, allowing for a unified approach to image management and customization.

### Review technical requirements

For both manual and automated deployment methods discussed in this module, you'll need to make sure that they're set up with all the required prerequisites to enable you to get started. Review the below requirements before you get started with either of the deployment methods.

- An Azure Subscription 
- Owner or Contributor permissions on the subscription. This will allow for the creation of the Dev center resource
- Network Contributor permissions - This will be used to enable the use of Microsoft Hosted Network and will be used to determine the region in which Dev Box machines will be created.
- An existing virtual network if you choose the custom network connection option.
- Windows 10/11 license depending on your chosen OS for the Dev Box machines you create
- Microsoft Entra ID Licensing
- Microsoft Intune License
  
  > [!NOTE]
  >
  >  You may benefit from using a Microsoft 365 plan to simplify the licensing requirements. The following Microsoft 365 plans that are compatible since they include Windows 10/11, Microsoft Intune, and Microsoft Entra ID licenses:
  >
  > - Microsoft 365 F3
  > - Microsoft 365 E3, Microsoft 365 E5
  > - Microsoft 365 A3, Microsoft 365 A5
  > - Microsoft 365 Business Premium
  > - Microsoft 365 Education Student Use Benefit
- Work or school account - Personal accounts with outlook.com, live.com, and others can't be used.
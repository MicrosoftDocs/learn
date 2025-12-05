In this unit, you explore some of the components required to set up Microsoft Dev Box, to give you foundational knowledge to proceed with the rest of this module.

Dev Box is made up primarily of the following components:

- Dev center
- Projects
- Dev Box definitions
- Dev Box pool
- Network connections
- Catalogs

:::image type="content" border="true" source="../media/components-microsoft-dev-box.png" alt-text="Diagram of key components of Microsoft Dev Box.":::

## Dev center

A **Dev center** is the parent resource needed to be created in Azure in your journey to deploy your first Dev Box. A Dev center is a container for the other Dev Box resources. Any projects, custom images, network connections, and Dev Box machines sit under the Dev center resource.

Dev center is also used for other services such as Azure Deployment Environments and Managed DevOps Pools, but for the current discussion, you will concentrate on its use with Dev Box.

Typically, only one Dev center is required for most organizations that adopt Microsoft Dev Box, as there's other resources that reside within the Dev center such as **projects**, which allow for the separation that organizations require. The exception to this rule is if you have multiple platform engineering teams that manage operations for different departments or locations of your organization. As an example, you may have one Platform engineering team in the US looking after the developers in the US, while another Platform engineering team in the UK looking after the developers in the UK. For this scenario you may choose to have two Dev centers. However, in most cases, you only need one central Dev center.

## Projects

Dev Box **projects** allow separation for teams that will be working on different development projects within your organization. For example, you may want to create a project for a team that works on the front-end for a new website your business is creating, then a separate project for the back-end team. This way you can separate resources such as toolsets and ultimately the Dev Box machines that live within the project.

Role Based Access Control (RBAC) can also be configured at the project level, ensuring developers only have access to the resources they need in the specific project they're working on.

## Dev Box definitions

**An image definition** allows us to specify an image that your Dev Box machines will use when a developer provisions a machine. The image definition also allows us to specify a specific version of that image. There are many Azure Marketplace images that can be used for Dev Box, or you can use **Team Customizations** that allow you to take a Marketplace image and install software packages on top of the Marketplace image to make the experience more customizable for developers using Dev Box. 

However, if you already have a custom image you'd like to use for Dev Box, you can import this image into the **Azure compute gallery**, connect it to the Dev center, and then use Image definitions to import that to be used in your Dev Box machines.

Definitions are where you can specify the CPU, RAM, and storage you want to assign to your Dev Box machines which get created.

## Dev Box pool

**Dev Box pool** is a collection of Dev Box machines that all share the same settings such as the Dev Box definition, the network connection, and some other settings. When a developer requires a Dev Box machine, they choose to create one in the pool that meets their requirement for their project. Developers can choose to create Dev Box machines in multiple projects, allowing them the flexibility to change machines when they need to work with different software and toolsets.

Dev box pools don't work the same way as other Virtual Desktop Infrastructure (VDI) pools. In the context of a Dev Box pool, machines aren't already built and running, while waiting to be consumed. When a Dev Box is requested, it's built and stored within the Dev Box pool, while adopting the settings that have configured with this pool.

## Network connections

In the context of Dev Box, there are two ways to configure the networking for your Dev Box machine. You can choose either a **Microsoft-hosted network** or you can create a **custom network**. If you choose a Microsoft managed network, Microsoft will create and deploy the network for your Dev Box machines. Microsoft will ensure the appropriate ports and outbound access are allowed for the Dev Box machines to operate properly.

There's one limitation with using a Microsoft-hosted network for your Dev Box machines. If you need to connect to on-premises or internal resources within Azure, you won't be able to do this with a Microsoft-hosted network. In this case, you need to create your own network connection, that is joined to a virtual network in your Azure environment. You need to ensure other factors are considered such as virtual network peering, VPN, Express Route, and firewall rules to allow your Dev Box machines to connect to the required resources on your internal network. 

## Catalogs

**Catalogs** are a way to import GitHub or Azure DevOps repositories into your Dev center. This allows you to make use of Team Customizations Dev Box. There are QuickStart catalogs that can be imported and used, or you can import your repositories from Azure DevOps or GitHub.

## Image considerations

There are two types of images you can use for your Dev Box machines - **Azure Marketplace** or **custom images**. Marketplace images are prebuilt images that you can use as part of your Dev Box build. You may also have the requirement to use custom images or also known as **golden images**. With Dev Box, you can import your custom images to be used by adding them to the **Azure compute gallery**. This allows, with the use of a Managed Identity, the import of your custom images to be used for your Dev box machines.

Choosing between a Marketplace image or a custom image is normally an internal discussion for organizations. There may be specific software or tools that are required on the Dev Box machines, in which case these types of software could be built into the golden image.

Here are some considerations to think about when deciding on images.

- **Azure Marketplace image** - Quick and easy to import and use as part of your Dev Box build. With the use of Intune and **Team Customizations**, software can be installed and changed with minimal operational overhead. Reduces the number of bottlenecks on the central platform team as no changes are needed to a **golden image**.

The downside to installing software on top of a Marketplace image is that the software doesn't get installed until the Dev Box machine deployment has initiated. That means it can take slightly longer for your Dev Box machine to be created. 

- **Custom images** - In some cases, you may already have golden images that can be used for Dev Box. Another benefit to using a golden image is that all software and settings are built into the image already, therefore when a Dev Box machine is created, there's no waiting on software to be installed at that time.

One of the downsides to using custom images is that if new software needs to be removed or added, the relevant teams that manage the custom images will get involved, creating extra work and potentially a bottleneck for developers to continue working on their project.

## Example of an enterprise-scale architecture for Microsoft Dev Box

The following diagram is a best practice enterprise architecture configuration for Microsoft Dev Box. You will see how the different components of Dev Box can be organized to allow for scalability, whilst allowing for a separation of roles and responsibilities within your organization.

:::image type="content" border="true" source="../media/dev-box-enterprise-architecture.png" alt-text="Diagram of Microsoft Dev Box in a typical Enterprise architecture." lightbox="../media/dev-box-enterprise-architecture.png":::

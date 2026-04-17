Conceptually there are several components for an end-to-end Dev Box service setup. Platform engineer or an IT Admin sets up the **Dev center**, **project**, and the **Dev box definition**. Once the project is created Dev team leads can be delegated the administration of projects which allows them to create **Dev Box pools** for their development teams. 

:::image type="content" source="../media/steps-required-create-dev-box-machine.png" alt-text="Diagram of key steps required to create a Dev Box machine.":::

## Dev center

A Dev Center is the first resource which must be set up in Azure when starting the process of deploying the Dev Box service. It is the central management entity for Dev Box infrastructure. It acts as a control plane that organizes and applies configuration settings across multiple projects. Think of it as the headquarters for all Dev Box-related resources.

### Key functions of a Dev center

- Resource Management: Hosts **Projects**, **Dev Box definitions**, **and Azure Compute Gallery** references.
- Network Oversight: Links to predefined Network Connections used by all Dev Box machines in associated **Projects**
- Configuration Standardization: Ensures consistent policy and tooling via shared catalogs.<br>

A single Dev center can support multiple **Projects**, enabling centralized governance with project-level customization.

## Projects

A Project in Microsoft Dev Box defines a development context typically for a team, department, or an application. Projects are tied to a Dev Center, allowing them to inherit standardized resources like network access, images, and setup tasks. Projects can be on different Azure subscriptions within the tenant. If there is a separation within the company based on functions, divisions, or billing, the projects can be created in the appropriate subscriptions while keeping the centralized management of the Dev center. 

Project policy can be used to control which projects get access to which resources and project customizations and imaging capabilities can be used to further customize base images for specific project needs.

### Each Project includes

- Dev Box Pools: Groupings of Dev Box machines based on size, region, or purpose.
- User Access: Developers assigned to the Dev Box User role can provision Dev Box machines in Dev Box pools
- Project Admins: Assigned to configure pools, Image definitions, and access control.


Projects enforce boundaries and permissions, ensuring developers can only use resources relevant to their team or product.

## Dev Box definitions

Dev Box definitions define the technical specifications of a Dev Box. 

They specify:

- The base operating system image to use for the Dev Box machine (e.g., Windows 11 with Visual Studio, or a custom image with internal tools).
- The compute size and disk configuration (e.g., 8-core vCPU, 32 GB RAM, 512 GB storage).

Organizations typically maintain Dev Box machine images in an Azure compute gallery for versioning and easy reuse. This supports scenarios like:

- Custom images per department or project.
- Standardized dev environments for regulated industries.
- Streamlined image management and rollback.

## Network connections

Network Connections are critical to ensure that Dev Box machines have access to the right services and stay secure. There are two main types of networking connection options available in Microsoft Dev Box:

- Microsoft-Hosted Network: Microsoft provisions and maintains a secure infrastructure on which the Dev Box machines are deployed. Great for fast setup and simple needs. You, however, do control the Dev box machines that are installed on this infrastructure. 
- Azure network connection: Your organization manages the network infrastructure on which the Dev Box machines will be deployed. This is an option when you want to control and manage the infrastructure along with connecting it to your other virtual networks within Azure or to your on-premises infrastructure. 

With Azure network connection you can configure:

- Native Entra ID Joins: For cloud-native apps and services
- Hybrid Entra ID Joins: For accessing on-premises resources like shared drives, legacy systems, and internal APIs.

## Catalogs

A **catalog** is a connection to a Git repository (public or private GitHub or Azure DevOps repository) that contains tasks and scripts that you can use to configure your Dev Box machine during the final stage of the Dev Box machine creation process. They typically contain IaC templates, Dev box definition, and configuration files.

You can add a catalog to a Dev center to make these tasks and scripts available to all the projects associated with the Dev center. Alternatively, you can add a catalog at a project level. However, project level catalogs must be enabled at the Dev center level before a catalog can be added to a project. 

Catalogs allow teams to:

- Automatically install SDKs, compilers, and CLI tools.
- Register the Dev Box with internal services.
- Apply compliance settings or diagnostics.

### Benefits of catalogs

| **Feature** | **Benefit** |
|---|---|
| **Reusability** | Teams can reuse the catalog for different projects |
| **Consistency** | Standardized images, VM sizes, tools, networks |
| **Governance** | Platform/IT teams can control what's available to developers |
| **Self-service** | Developers can use these templates to spin up environments on-demand |

## Azure regions for Dev Box

Microsoft Dev Box service is available in multiple Azure regions globally. Ideally, you will deploy the Dev Box machines in the region closest to where the developers are located to reduce any latency. Dev center and projects don't have to be in the same region as your Dev Box machines. 

If you have multiple developers located in different geographic locations, then the platform engineering or the IT admin team can create multiple Dev box pools with different geographic Azure regions close to your developers. The developers will then pick the appropriate Dev Box pool, closest to their location, when deploying Dev Box machines. 

## Dev box pool

A Dev Box pool in Microsoft Dev Box service is a group of Dev Box machines that share the same:

- Project
- Image (Windows + developer tools)
- VM size/SKU (CPU, memory)
- Azure region (for Microsoft Hosted network)
- Network connection (Microsoft Hosted network or a private network connection)
- Cost control features (Auto-stop on schedule + hibernate on disconnect) 

## Dev Box machine

This is a preconfigured virtual machine that a developer creates by using the developer portal or the CLI tool. This cloud virtual machine is associated with a particular project and a Dev Box pool. These machines have all the required tools, libraries, and proper configuration that help the developer become productive immediately. A developer can be allowed to create multiple Dev Box machines which can be dedicated to different projects or tasks. 

## Putting it all together end-to-end

Now that you understand the various components of the service, this diagram shows how various components of the service are connected and work end-to-end.

:::image type="content" source="../media/components-microsoft-dev-box.png" alt-text="Diagram of the various components of Microsoft Dev Box.":::
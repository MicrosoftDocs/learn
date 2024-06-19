An Azure landing zone is an environment that follows key design principles across eight design areas. These design principles accommodate all application portfolios and enable application migration, modernization, and innovation at scale. An Azure landing zone uses subscriptions to isolate and scale application resources and platform resources. Subscriptions for application resources are called application landing zones, and subscriptions for platform resources are called platform landing zones.

An Azure landing zone architecture is scalable and modular to meet various deployment needs. A repeatable infrastructure allows you to apply configurations and controls to every subscription consistently. Modules make it easy to deploy and modify specific Azure landing zone architecture components as your requirements evolve.

## Platform landing zones vs. application landing zones<br>

An Azure landing zone consists of platform landing zones and application landing zones. It's worth explaining the function of both in more detail.

Platform landing zone: A platform landing zone is a subscription that provides shared services (identity, connectivity, management) to applications in application landing zones. Consolidating these shared services often improves operational efficiency. One or more central teams manage the platform landing zones.<br>

Application landing zone: An application landing zone is a subscription for hosting an application. You pre-provision application landing zones through code and use management groups to assign policy controls to them.<br>

There are three main approaches to managing application landing zones. You should use a (1) central team, (2) application team, or (3) shared team management approach, depending on your needs (see table).<br>

| **Application landing zone management approach** | **Description**                                                                                                                                                                                                                                                                                                                                                                                                            |
| ------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Central team management                          | A central IT team fully operates the landing zone. The team applies controls and platform tools to the platform and application landing zones.                                                                                                                                                                                                                                                                             |
| Application team management                      | A platform administration team delegates the entire application landing zone to an application team. The application team manages and supports the environment. The management group policies ensure that the platform team still governs the application landing zone. You can add other policies at the subscription scope and use alternative tooling for deploying, securing, or monitoring application landing zones. |
| Shared management                                | With technology platforms such as AKS or AVS, a central IT team manages the underlying service. The application teams are responsible for the applications running on top of the technology platforms. You need to use different controls or access permissions for this model. These controls and permissions differ from the ones you use to manage application landing zones centrally.                                 |

## Azure landing zone accelerators

Accelerators are infrastructure-as-code implementations that help you deploy an Azure landing zone correctly. We have a platform landing zone accelerator and several application landing zone accelerators you can deploy.

## Platform landing zone accelerator<br>

There's a ready-made deployment experience called the Azure landing zone portal accelerator. The Azure landing zone portal accelerator deploys the conceptual architecture (see figure 1) and applies predetermined configurations to key components such as management groups and policies. It suits organizations whose conceptual architecture aligns with the planned operating model and resource structure.

You should use the Azure landing zone portal accelerator if you plan to manage your environment with the Azure portal.

## Build scalable, modular Azure landing zones

Microsoft offers the Cloud Adoption Framework to provide customers a proven starting point for the cloud journey, including the Secure methodology.

Another critical component of the Cloud Adoption Framework in the Ready methodology is the Azure landing zone, which accelerates cloud adoption by providing automated implementation of complete architectures and operating environments, including security elements. Security best practices are integrated in Azure landing zones. With landing zones, you can quickly and securely migrate your first workloads with baked-in security and governance best practices.<br>

While you design and implement your organization's landing zone, use the reference architecture below as a target end-state. It captures mature and scaled-out environmental design considerations.

We recommend using Azure landing zones when possible in your cloud adoption plans. Landing zones provide an architectural starting point. Azure landing zones help you follow security and other best practices whether you deploy a new workload, migrate existing workloads, or improve already-deployed workloads. Using landing zones helps you follow best practices whether you implement them all at once or incrementally.<br>

> [!NOTE]
> *Your organization can customize the Azure landing zone architecture to meet your unique business requirements.*

Azure landing zones contain code that makes it easier for your organization's IT and security teams. Landing zones offer a repeatable, predictable method to apply a templatized implementation. That implementation includes a deployment approach, design principles, and design areas. Landing zones support security, management, and governance processes, as well as platform automation and DevOps.

:::image type="content" source="../media/azure-landing-zone-architecture-example-ce4b31c9.png" alt-text="Diagram showing an example of an Azure landing zone hierarchy for multiple tenants.":::


## Use Zero Trust principles

Your organization can adapt Azure landing zones based on Azure Security Benchmark (ASB) best practices and Zero Trust (ZT) principles, which are included in the target architecture. Move toward the best practice-aligned target architecture, implementing other security considerations and Zero Trust principles that incrementally build on and improve your organization's security and governance MVP.

Extend Zero Trust architectural approaches that *never trust and always verify*. Integrate an end-to-end strategy across your digital state that encompasses identities, endpoints, network, data, applications, and infrastructure.<br>

## Follow Azure Security Benchmark security recommendations

We recommend that your organization follow the high-impact security recommendations of the Azure Security Benchmark. There's also guidance in Azure landing zones and the Cloud Adoption Framework itself. Include ASB recommendations as part of your architectural strategy by reviewing all pertinent documentation and service-specific baselines.

> [!TIP]
> *Azure landing zones assign the ASB policy by default to the top of its hierarchy. This approach ensures that all subscriptions and workloads in the landing zone are monitored for ASB compliance.*

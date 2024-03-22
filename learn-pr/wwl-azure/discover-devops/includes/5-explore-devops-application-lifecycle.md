While DevOps practices have a vast scope, their primary target is optimizing application lifecycle management. In the fictitious company example, migration from an existing app to a new app with updated features requires revisiting every phase of the application lifecycle. As such, learn how DevOps principles can significantly alter how each phase is implemented, from planning, through development and delivery, to operations. In this unit, step through a high-level overview of these implementations.

## Application Lifecycle phases

Application lifecycle phases include planning, development, delivery, and operations.

:::image type="content" source="../media/5-devops-lifecycle.png" alt-text="Screenshot of the DevOps and Application Lifecycle.":::

### Planning

The planning phase involves reviewing customer needs in order to outline and define features and capabilities of the software to be developed. Such software can range from individual microservices to portfolios consisting of multiple products. The outcome defines software requirements, scope, and milestones for the application's development and deployment. From the DevOps perspective, the primary considerations during this phase include agility, customer-centric focus, alignment, and visibility.

### Development

The development phase covers all aspects of developing application code. These aspects include programming, testing, and code reviews. To comply with DevOps practices, the code should reside in a source control system, which facilitates collaboration and supports versioning. A working version of the code is used to build artifacts suitable for subsequent delivery. Such artifacts can take the form of executable binaries, software libraries, container images, installer packages, configuration files, deployment scripts, or even documentation.

Changes at this phase should be applied in small increments through automated testing and build, referred to as *continuous integration (CI)*, which accelerates the development process and enhances agility.

### Delivery

Delivery is the process of deploying the artifacts built during the development stage into production environments in a consistent and reliable manner. While the ultimate goal at this phase is full automation through *continuous delivery (CD)*, some organizations, especially in early stages of their DevOps adoption, might choose to implement manual approvals or checks. As the confidence in DevOps practices grows, it's typically possible to fully automate these checks. For example, a successful, unattended verification of a deployment to a staging environment might serve as the basis for transitioning to the production environment. Automation helps make delivery processes scalable, repeatable, and, more resilient (by minimizing the possibility of human error). The key to a successful implementation of such an approach is following DevOps practices, including proper testing, the use of observable measurements, and continuous learning.

Delivery should also take into account provisioning and configuring the target environment's infrastructure through IaC. Treating infrastructure as code offers a range of benefits, including consistency, reproducibility, and agility.

### Operations

The operations phase involves maintaining, monitoring, and troubleshooting applications in production environments. From the DevOps perspective, the primary objectives at this stage are stability and reliability, rapid incident response, security and compliance, and customer satisfaction. To some extent, reaching these objectives is dependent on having properly implemented measurable outcomes. DevOps processes also rely on so called *feedback loops* that deliver data reflecting the current state of the deployed application such as performance metrics, responsiveness, and overall user experience, including improved or degraded functionality.

During this phase, it's important to ensure the maximum levels of collaboration between development, operations, and security teams. This phase also serves as the essential source of continuous learning.

## What's the final stage of the application lifecycle?

As the name indicates and the image at the beginning of this unit illustrates, the application lifecycle is, by design, a circular process. There's a deterministic beginning and end of an application lifespan determined by its inception and decommissioning events. However, following the initial deployment (or frequently, even earlier), feedback from users and monitoring data inform subsequent updates and the evolution of the application.

> [!NOTE]
> Keep in mind that even though security was mentioned only a few times throughout this unit, according to DevSecOps principles, its role pervades throughout application lifecycle. Effectively, security-related considerations should be accounted for during each phase, starting at the very beginning of the initial planning.

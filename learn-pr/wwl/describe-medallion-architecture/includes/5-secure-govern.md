There are a couple of considerations to keep in mind when managing your lakehouse, including how to secure your lakehouse and how to handle continuous integration and continuous delivery (CI/CD).

## Secure your lakehouse

Secure your lakehouse by ensuring that only authorized users can access data. In Fabric, you can do this by setting permissions at the *workspace* or *item* level.

[Workspace permissions](/fabric/get-started/roles-workspaces) control access to **all** items within a workspace. [Item level permissions](/fabric/get-started/share-items) control access to **specific** items within a workspace, and could be used when you're collaborating with colleagues who aren't in the same workspace, or they only need access to a single, specific item.

You can strategically store different layers of your lakehouse in separate workspaces for improved security and efficient capacity management. This approach not only enhances security but also optimizes cost-effectiveness.

- Security and Access Considerations: Define who needs access at each layer, ensuring only authorized personnel can interact with sensitive data.
- Gold Layer Access Control: Restrict access to the Gold layer for read-only purposes, emphasizing the importance of minimal permissions.
- Silver Layer Utilization: Decide whether users will be allowed to build upon the Silver layer, balancing flexibility and security.
- Bronze Layer Access Control: Restrict access to the Bronze layer for read-only purposes, emphasizing the importance of minimal permissions.

Sharing of Fabric content should be discussed with your organization's security team to ensure that it aligns with your organization's security policies.

## Considerations for Continuous Integration and Continuous Delivery (CI/CD)

Designing a Continuous Integration/Continuous Deployment (CI/CD) process for a lakehouse architecture involves several considerations to ensure a smooth and efficient deployment process.  Considerations include implementing data quality checks, version control, automated deployments, monitoring, and security measures. Considerations should also include scalability, disaster recovery, collaboration, compliance, and continuous improvement to ensure reliable and efficient data pipeline deployments. While some of these are related to processes and practices, others are related to the tools and technologies used to implement CI/CD. Fabric natively provides several tools and technologies to support CI/CD processes.

*Git integration* in Microsoft Fabric enables you to integrate development processes, tools, and best practices straight into the Fabric platform. Fabric's Git integration enables data teams to back up and version work, revert to previous stages as needed, collaborate with others or work alone using Git branches, and leverage the capabilities of familiar source control tools to manage Fabric items.

> [!NOTE]
> Learn more about Git integration in Fabric in [Introduction to git integration](/fabric/cicd/git-integration/intro-to-git-integration).

CI/CD is crucial at the gold layer of a lakehouse because it ensures that high-quality, validated, and reliable data is available for consumption. Automated processes enable continuous integration of new data, data transformations, and updates, reducing manual errors and providing consistent and up-to-date insights to downstream users and applications. This enhances data accuracy, accelerates decision-making, and supports data-driven initiatives effectively.
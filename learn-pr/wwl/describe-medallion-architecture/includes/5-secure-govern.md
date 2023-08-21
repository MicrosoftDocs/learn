## Secure your lakehouse

Secure your lakehouse by ensuring that only authorized users can access data. In Fabric, you can do this by setting permissions at the *workspace* or *item* level.

[Workspace permissions](/fabric/get-started/roles-workspaces) control access to **all** items within a workspace. [Item level permissions](/fabric/get-started/share-items) control access to **specific** items within a workspace, and could be used when you're collaborating with colleagues who aren't in the same workspace, or they only need access to a single, specific item.

You can strategically store different layers of your lakehouse in separate workspaces for improved security and efficient capacity management. This approach not only enhances security but also optimizes cost-effectiveness.

- Security and Access Considerations: Define who needs access at each layer, ensuring only authorized personnel can interact with sensitive data.
- Gold Layer Access Control: Restrict access to the Gold layer for read-only purposes, emphasizing the importance of minimal permissions.
- Silver Layer Utilization: Decide whether users will be allowed to build upon the Silver layer, balancing flexibility and security.
- Bronze Layer Access Control: Restrict access to the Bronze layer for read-only purposes, emphasizing the importance of minimal permissions.

Sharing of Fabric content should be discussed with your organization's security team to ensure that it aligns with your organization's security policies.

## Continuous Integration and Continuous Delivery (CI/CD)

This needs to be expanded upon after convo with CAT team.

Recognize the significance of Continuous Integration and Continuous Deployment (CI/CD) practices, particularly at the Gold layer. These practices streamline development, testing, and deployment, promoting a reliable and agile data environment.

Deployment Pipeline Implementation: Identify the pivotal role of deployment pipelines in the Gold layer. Implement robust deployment pipelines to ensure seamless and controlled movement of data and transformations.
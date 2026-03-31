Configuring Microsoft Priva ensures its tools align with your organization’s privacy management needs. Settings control how Priva handles data, enforces policies, and supports collaboration across teams.

## Licensing

Priva includes two generally available solutions:

- **Privacy Risk Management**
- **Subject Rights Requests for data within Microsoft 365**

Each solution requires the appropriate license. Licensing tiers for Subject Rights Requests depend on the volume of requests, with additional requests available for purchase. A [free trial](/privacy/priva/priva-trial?azure-portal=true) can help organizations explore these capabilities before committing.

## Roles and permissions

Priva uses role-based access control (RBAC). Access is assigned in the **Settings** > **Roles and scopes** section of the portal. Roles ensure that only authorized users can configure policies or manage subject rights requests. Detailed guidance is available at [Permissions in the Microsoft Purview portal](/purview/purview-permissions?azure-portal=true).

## Configure Priva settings

Several configuration options shape how Priva operates:

- **Anonymization**: Mask usernames in Privacy Risk Management so reviewers see generic labels instead of identities, protecting employee privacy.

   :::image type="content" source="../media/priva-anonymization.png" alt-text="Screenshot showing anonymization options in Microsoft Priva settings." lightbox="../media/priva-anonymization.png":::

- **User notifications**: Send automated emails when a policy match occurs. Notifications can include corrective guidance and links to training.  

- **Teams collaboration**: Create a dedicated Teams channel for each Subject Rights Request, streamlining stakeholder reviews.  

- **Data matching**: Define schemas, sensitive information types, and uploads that help Priva recognize personal data during a Subject Rights Request.

   :::image type="content" source="../media/priva-data-matching.png" alt-text="Screenshot showing the data matching options in Microsoft Priva settings." lightbox="../media/priva-data-matching.png":::  

- **Retention periods**: Specify how long collected data and reports from Subject Rights Requests are stored (for example, 30 or 90 days).  

- **Data review tags**: Apply customizable tags like _Follow-up_ or _Update_ to organize content during request reviews.

## Putting it together

These settings help organizations tailor Priva to their needs. Anonymization protects employee privacy during investigations, notifications and Teams integration support collaboration, and retention rules ensure data is kept only as long as required. By configuring Priva thoughtfully, administrators enable the organization to manage risks and respond to requests in a consistent and efficient way.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)

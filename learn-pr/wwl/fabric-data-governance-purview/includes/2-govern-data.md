Microsoft Fabric includes a set of governance and compliance capabilities. Some governance capabilities are built in to Fabric and others require using Microsoft Purview. 

If you work at a health care company, for example, you would have specific data governance needs because of regulatory requirements. In this unit, we'll explore Fabric's governance features so you can assess if they meet your requirements.  

## What is Microsoft Fabric?

[![A diagram showing the architecture of Microsoft Fabric in a simplified form.](../media/fabric-architecture.png)](../media/fabric-architecture.png)

Fabric is Microsoft's end-to-end analytics and data platform. The platform can store, move, process, ingest, transform, and analyze your data regardless of its size and current format. Once you have data in the location and format you need it, advanced business intelligence features can analyze it and generate insights to support your decision making.

### OneLake

In Fabric, all information is stored in a data lake, which can hold both structured and unstructured data. Microsoft's implementation of the data lake is called OneLake and is built on Azure Data Lake Storage (ADLS) generation 2. With all data residing in OneLake, there's a single copy of data that doesn't need to be moved or duplicated. This single underlying storage mechanism helps ensuring that policies and security are applied universally.

## What is data governance?

The data your organization possesses and processes is often business-critical and highly sensitive. Sensitive data must be: held securely, easily available, and processed in compliance with legislation in all the locations you operate within.

Data governance is the practice of managing data to ensure the quality, consistency, security, and usability of data. It involves setting up a framework that includes roles, responsibilities, processes, policies, and standards that are used to manage data throughout its lifecycle.

A data governance program usually includes:

- **Auditing**: Recording where data originates from and who modifies it
- **Evaluation**: Assessing the usefulness and accuracy of your data
- **Documentation**: Describing the nature of your data to people who might use it
- **Management**: Removing inaccurate data, responding to access requests, ensuring compliance with data legislation
- **Protection**: Securing data against unauthorized access, ransomware, and other attacks

Well governed data is trustworthy and easily available to the right people.

> [!TIP]
> In large organizations, there are often sets of data that are stored and managed independently in different business groups. These sets of data are called data silos and they can make it difficult to implement data governance because of different standards and policies across an organization. Removing silos by integrating data while maintains security is a vital component of data governance.

Implementing data governance can lead to benefits such as:

- A single source of truth that reduces confusion and supports decision making.
- Improved data quality.
- Faster compliance with access requests.
- Reduced data storage and management costs.

## Data governance features in Microsoft Fabric

Many data governance tasks are included with your Microsoft Fabric license, without an additional license from Microsoft Purview. Let's examine some of the capabilities that are available:

### Managing the data estate

Your organization's data estate is its entire collection of data assets. Managing large data estates requires significant administrative effort. Fabric can help this task with these tools:

- **The Fabric Admin portal**: control tenant settings, capacities, domains, and other objects, typically reserved for administrators.
- **Tenants, domains, and workspaces**: logical containers that you can use to control access to data and capabilities. Fabric administrators, for example, should have access to all settings in the tenant whereas team level data controllers might only have control of settings on their domain or workspace.
  - Domains group data that is relevant to a single business area or subject field.
  - Workspaces group Fabric items used by a single team or department.
- **Capacities**: These objects limit compute resource usage for all Fabric workloads.
- **Metadata scanning**: Scanning extracts values such as names, identities, sensitivities, endorsements, and so on, from data lakes. You can use this metadata to analyze and set governance policies.

### Securing and protecting data

Secure data is safeguarded from unauthorized access and malicious attacks. It's also compliant with data storage regulations applicable in your region. Fabric includes the following tools:

- **Data tags**: Use tags to identity the sensitivity of data and apply data retentions and protection policies.
- **Workspace roles**: Use roles to define the users who are authorized to access the data in a workspace.
- **Data-level controls**: Use controls at the level of Fabric items such as tables, rows, and columns to impose granular restrictions.
- **Certifications**: Fabric is compliant with many data management certifications, including HIPAA BAA, ISO/IEC 27017, ISO/IEC 27018, ISO/IEC 27001, and ISO/IEC 27701.

### Encouraging data discovery and use

Data is only helpful if users can locate and analyze it. These features of Fabric can encourage data use:

- **OneLake data hub**: This tool makes it easy for users to find and explore the data in your estate.
- **Endorsement**: Users endorse a Fabric item to identity it as of high quality. Endorsements help other users to trust the data that the item contains.
- **Data lineage**: This feature helps users to understand the flow of data between items in a workspace and the impact that a change would have.

### Monitoring data usage

Fabric enables users to monitor how information is used:

- **Monitoring hub**: This hub lets you monitor Microsoft Fabric activities from a central location. You only see activities for the Fabric items that you have the permission to view.
- **Capacity Metrics**: Use the Capacity Metrics app to monitor Fabric usage and consumption.

## Learn more

- [What is Microsoft Fabric?](/fabric/get-started/microsoft-fabric-overview)
- [What is data governance?](https://azure.microsoft.com/resources/cloud-computing-dictionary/what-is-a-data-governance/)
- [Microsoft Fabric governance documentation](/fabric/governance/)

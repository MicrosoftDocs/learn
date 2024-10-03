Microsoft Fabric includes some basic governance features that might be sufficient for the needs of some organizations. 

In your health care provider, you have precise data governance needs because legislation in some of your territories is very strict but you don't want to incur unnecessary expense. You want to assess the data governance features in Microsoft Fabric to find out if it covers your requirements on its own.

In this unit, let's explore Fabric's governance features.

## What is Microsoft Fabric?

[![A diagram showing the architecture of Microsoft Fabric in a simplified form.](../media/fabric-architecture-1.png)](../media/fabric-architecture-1.png)

Fabric is Microsoft's end-to-end analytics and data platform. The Software-as-a-Service (SaaS) platform can store, move, process, ingest, transform, and analyze your data regardless of its size and current format. Because Fabric seamlessly integrates your data, you no longer need to interface solutions from different vendors using diverse protocols. Once you have data in the location and format you need it, advanced business intelligence features can analyze it and generate insights to support your decision making. All Fabric features and tools are supported with AI integration, which accelerates your productivity.

> [!NOTE]
> Microsoft Fabric includes features previously available separately in Power BI, Azure Synapse Analytics, and Azure Data Factory along with new capabilities.

### Fabric experiences

Fabric includes diverse experiences to address all your data manipulation and analysis needs:

- **Data Factory**: Use this experience to ingest, prepare, and transform data from many different sources through diverse data connectors.
- **Synapse Data Engineering**: This experience is a Spark platform that you can use to collect, store, process, and analyze vast volumes of data through scheduled jobs and notebooks.
- **Synapse Data Warehouse**: Use this experience to separate compute from storage and scale each independently. Data is stored in Data Lake format and demonstrates industry-leading SQL performance.
- **Synapse Data Science**: Use this experience to train, deploy, and use machine learning models.
- **Real-Time Intelligence**: This experience is a complete solution for event-driven data, such as device telemetry, data logs, and streaming data.
- **Power BI**: Use this experience to visualize, investigate, and discover trends hidden in your data. You can share Power BI reports to support the best decision making.
- **Data Activator**: Use this experience to specify actions, such as emails and workflows, that launch when specific conditions are met in your data. You can create these actions without writing code.

### OneLake

In Fabric, all information is stored in a data lake, which can hold both structured and unstructured data. Microsoft's implementation of the data lake is called OneLake and is built on Azure Data Lake Storage (ADLS) generation 2. This single underlying storage mechanism helps to eliminate silos and reduce costs while ensuring that policies and security are applied universally.

## What is data governance?

The data your organization possesses and processes is often business-critical and highly sensitive. It's vital to most companies that data is held securely, easily available, and processed in compliance with legislation in all the territories you operate in.

Data governance is a term that describes the policies and practices you use to ensure the quality, consistency, security, and usability of your data. The discipline encompasses a range of activities and responsibilities that manage data effectively throughout its lifecycle.

A data governance program usually includes:

- **Auditing**: Recording where data originates from and who modifies it
- **Evaluation**: Assessing the usefulness and accuracy of your data
- **Documentation**: Describing the nature of your data to people who might use it
- **Management**: Removing inaccurate data, responding to access requests, ensuring compliance with data legislation
- **Protection**: Securing data against unauthorized access, ransomware, and other attacks

Well governed data is trustworthy and easily available to the right people.

> [!TIP]
> Large organizations also often have data that is divided into silos. Historic systems and databases, possessed by separate units within your business, impose barriers for security purposes that hinder access. In these cases, the integration of data and the removal of data silos, in such a way that security is maintained, is a vital component of data governance.

A solid data governance regimen can realize benefits for your company such as:

- A single source of truth that reduces confusion and supports good decision making.
- Higher quality data that reflects the world it measures more precisely.
- Faster compliance with access requests.
- Reduced costs for data storage and management.

## Data governance features in Microsoft Fabric

You can perform many data governance tasks in Fabric, straight off the shelf and without an additional subscription to Microsoft Purview. Let's examine some of the capabilities that are available:

### Managing the data estate

Your organization's data estate is its entire collection of data assets. Large data estates take administrative time to maintain and manage. Fabric can help this task with these tools:

- **The Fabric Admin portal**: control tenant settings, capacities, domains, and other objects, typically reserved for administrators.
- **Tenants, domains, and workspaces**: logical containers that you can use to control access to data and capabilities. Fabric administrators, for example, should have access to all settings in the tenant whereas team level data controllers might only have control of settings on their domain or workspace.
  - Domains group data that is relevant to a single business area or subject field.
  - Workspaces group Fabric items used by a single team or department.
- **Capacities**: These objects limit compute resource usage for all Fabric workloads.
- **Metadata scanning**: Scanning extracts values such as names, identities, sensitivities, endorsements, and so on, from data lakes. You can use this metadata to analyze and set governance policies.

### Securing and protecting data

Secure data is protected against unauthorized access and destructive attacks. It's also compliant with data storage regulations applicable in your region. Fabric includes the following helpful tools:

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

- **Monitoring hub**: This hub shows what happened to Fabric items. You only see activities for the Fabric items that you have the permission to view.
- **Capacity Metrics**: Use the Capacity Metrics app to monitor usage and consumption.

## Learn more

- [What is Microsoft Fabric?](/fabric/get-started/microsoft-fabric-overview)
- [What is data governance?](https://azure.microsoft.com/resources/cloud-computing-dictionary/what-is-a-data-governance/)
- [Microsoft Fabric governance documentation](/fabric/governance/)

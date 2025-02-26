Security in Microsoft Fabric is optimized for securing data for specific use cases. Different users need the ability to perform various actions in Fabric to fulfill their job responsibilities. Fabric facilitates this by allowing you to grant users access to specific data workloads through workspace and item permissions, compute permissions, and OneLake data access roles (Preview).

## Secure data by use case

A security use case in Fabric refers to a set of users needing data access and accessing data in a specific way. Once a use case is identified, Fabric permissions associated with that use case can be configured. Suppose you work at a healthcare company with multiple systems that store data, such as electronic health records (EHR), insurance claims data, clinical trial data, patient and disease registries, and administrative data. Different users within your company or partner organizations need to view, transform, analyze, aggregate, and use this data to derive business insights. Users need access to different Fabric compute engines, items, and workspaces to perform their jobs effectively:

- **Data engineers** need access to data in a lakehouse to develop downstream data products.
- **Business or data analysts** need to query data to answer business questions.
- **Data scientists** need to access data in a lakehouse and consume it through Apache Spark to create models and experiments.
- **Report creators** need to build reports to share with report consumers.
- **Report consumers** need to view data in Power BI reports to make decisions.

In this module, you'll learn how to use the Fabric access control features available to secure your data and provide your team with the necessary access within Fabric to perform their job duties. You'll explore Fabric’s multi-layer security model and how to use it to manage data access.

By the end of this module, you'll know how to configure security for an entire workspace, for individual Fabric data items, and how to apply granular permissions within Fabric data items.

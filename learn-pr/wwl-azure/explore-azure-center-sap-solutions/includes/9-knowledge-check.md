## Multiple Choice
What is a Virtual Instance for SAP solutions in Azure Center for SAP solutions?
( ) A tool to manage the Azure infrastructure for SAP systems. {{Incorrect. While Azure Center for SAP solutions provides management capabilities, a Virtual Instance for SAP solutions is a logical representation of an SAP system on Azure.}}
( ) An Azure virtual server that runs SAP workloads. {{Incorrect. A Virtual Instance for SAP solutions is a logical representation of an SAP system on Azure.}}
(x) A logical representation of an SAP system on Azure that contains metadata for the entire SAP system. {{Correct. A Virtual Instance for SAP solutions is a logical representation of an SAP system on Azure that contains metadata for the entire SAP system, including the SAP system itself, an ABAP Central Services (ASCS) instance, a database instance, and one or more SAP Application Server instances.}}

## Multiple Choice
What is the purpose of Azure Center for SAP solutions (ACSS) *system registration*?
(x) To create required resources and represent the SAP system on Azure for visualization, management, and monitoring capabilities {{Correct. ACSS system registration creates required resources to represent the SAP system on Azure for visualization, management, and monitoring capabilities.}}
( ) To create billing and cost for resources created {{Incorrect. ACSS system registration does not create any billing or cost associated with the resources created.}}
( ) To deploy an SAP workload in non-Azure infrastructure {{Incorrect. ACSS system registration requires an SAP workload in Azure infrastructure to fully deploy.}}

## Multiple Choice
What is the purpose of Azure Center for SAP solutions (ACSS)?
( ) Provides a platform for building, deploying, and managing applications and services through a global network of Microsoft-managed data centers. {{Incorrect. This is the purpose of Azure App Service.}}
( ) Enables the automation and validation of the creation and teardown of environments to help deliver secure and stable application hosting platforms. {{Incorrect. This is the purpose of Azure DevOps.}}
(x) Provides visualization, monitoring, and management across Azure and SAP systems. {{Correct. ACSS provides visualization, monitoring, and management across Azure and SAP systems.}}

## Multiple Choice
What is the recommended infrastructure deployment option for production environments when deploying S/4HANA infrastructure with Azure Center for SAP solutions (ACSS)?
(x) Distributed with High Availability (HA) {{Correct. This option creates distributed HA architecture and is recommended for production environments. The appropriate High Availability SLA needs to be selected.}}
( ) Distributed non-HA architecture {{Incorrect. This option creates distributed non-HA architecture, which is not recommended for production environments.}}
( ) Architecture with a single server {{Incorrect. This option creates architecture with a single server, which is only available for non-production environments.}}

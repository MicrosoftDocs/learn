Azure Center for SAP solutions (ACSS) is an Azure offering that makes SAP a top-level workload on Azure. ACSS is an end-to-end solution that enables you to create and run SAP systems as a unified workload on Azure and provides a more seamless foundation for innovation. You can take advantage of the management capabilities for both new and existing Azure-based SAP systems.

The guided deployment experience takes care of creating the necessary compute, storage and networking components needed to run your SAP system. Azure Center for SAP solutions then helps automate the installation of the SAP software according to Microsoft best practices.

In Azure Center for SAP solutions, you either create a new SAP system or register an existing one, which then creates a *Virtual Instance for SAP solutions (VIS)*. The VIS brings SAP awareness to Azure by providing management capabilities, such as being able to see the status and health of your SAP systems. Another example is quality checks and insights, which allow you to know when your system isn't following documented best practices and standards.

You can use Azure Center for SAP solutions to deploy the following types of SAP systems:

- Single server
- Distributed
- Distributed with High Availability (HA)

For existing SAP systems that run on Azure, there's a simple registration experience. You can register the following types of existing SAP systems that run on Azure:

- An SAP system that runs on SAP NetWeaver or ABAP stack.
- SAP systems that run on Windows, SUSE, and RHEL Linux operating systems.
- SAP systems that run on HANA, DB2, SQL Server, Oracle, Max DB, or SAP ASE databases.

Azure Center for SAP solutions brings services, tools and frameworks together to provide an end-to-end unified experience. ACSS provides features for deployment and management of SAP workloads on Azure, creating the foundation for you to build innovative solutions for your unique requirements.

## What is a Virtual Instance for SAP solutions?

When you use Azure Center for SAP solutions, you create a *Virtual Instance for SAP solutions (VIS)* resource. The VIS is a logical representation of an SAP system on Azure. Every time that you create a new SAP system through Azure Center for SAP solutions, or register an existing SAP system to ACSS, Azure creates a VIS. A VIS contains the metadata for the entire SAP system.

Each VIS consists of:

- The SAP system itself, referred to by the SAP System Identifier (SID).
- An ABAP Central Services (ASCS) instance.
- A database instance.
- One or more SAP Application Server instances.

:::image border="false" type="content" source="../media/virtual-instance-sap.png" alt-text="Diagram showing a Virtual Instance for S A P solutions containing an S A P system identifier with A S C S, Application Server and Database instances.":::

Inside the VIS, the SID is the parent resource. Your VIS resource is named after the SID of your SAP system. Any ASCS, Application Server, or database instances are child resources of the SID. The child resources are associated with one or more virtual machine resources outside of the VIS. A standalone system has all three instances mapped to a single virtual machine. A distributed system has one ASCS and one Database instance, with each mapped to a virtual machine. High Availability (HA) deployments have the ASCS and Database instances mapped to multiple virtual machines to enable HA. A distributed or HA type SAP system can have multiple Application Server instances linked to their respective virtual machines.

## What can you do with Azure Center for SAP solutions?

After you create a VIS, you can:

- See an overview of the entire SAP system, including the different parts of the VIS.
- View the SAP system metadata. For example, properties of ASCS, database, and Application Server instances; properties of SAP environment details; and properties of associated virtual machine resources.
- Get the latest status and health check for your SAP system.
- Start and stop the SAP application tier.
- Get quality checks and insights about your SAP system.
- Monitor your Azure infrastructure metrics for your SAP system resources. For example, the CPU percentage used for ASCS and Application Server virtual machines, or disk input/output operations per second (IOPS).
- Analyze the cost of running your SAP System on Azure.

Azure Center for SAP solutions (ACSS) simplifies the deployment and management of SAP workloads on Azure, providing a unified experience for creating and running SAP systems as a top-level workload on Azure.

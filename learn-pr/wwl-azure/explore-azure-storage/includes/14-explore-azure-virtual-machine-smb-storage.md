Highly available SMB shares for SAP workloads in Azure VMs can be implemented by using Storage Spaces Direct (S2D)-based clusters with the Scale-Out File Servers (SOFS) role. Alternatively, these shares can be created by using third-party solutions, such as SIOS DataKeeper, that emulate shared disks by synchronously replicating the content of local disks of clustered Azure VMs.

Azure also offers Azure Files that deliver managed SMB file sharing. However, at the time of authoring of this content, Azure Files support file-system-level permissions only in scenarios that involve Azure Active Directory Domain Services.

For more information regarding the use of Scale out File Server (SOFS) on Storage Spaces Direct (S2D) for SAP deployments in Azure, see [Deploy SAP NetWeaver (Windows) for AnyDB on Azure virtual machines](/azure/architecture/reference-architectures/sap/sap-netweaver).

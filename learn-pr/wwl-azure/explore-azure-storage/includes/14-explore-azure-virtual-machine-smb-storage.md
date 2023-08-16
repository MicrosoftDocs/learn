Highly available SMB shares for SAP workloads in Azure VMs can be implemented by using Storage Spaces Direct (S2D)-based clusters with the Scale-Out File Servers (SOFS) role. Alternatively, these shares can be created by using third-party solutions, such as SIOS DataKeeper, that emulate shared disks by synchronously replicating the content of local disks of clustered Azure VMs.

Azure Files supports identity-based authentication for Windows file shares over Server Message Block (SMB) using the Kerberos authentication protocol through the following three methods:
- On-premises Active Directory Domain Services (AD DS)
- Azure Active Directory Domain Services (Azure AD DS)
- Azure Active Directory (Azure AD) Kerberos for hybrid user identities

For more information regarding the use of Scale out File Server (SOFS) on Storage Spaces Direct (S2D) for SAP deployments in Azure, see [Run SAP NetWeaver in Windows on Azure](/azure/architecture/reference-architectures/sap/sap-netweaver).

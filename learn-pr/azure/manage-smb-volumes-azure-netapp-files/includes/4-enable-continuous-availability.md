You can enable the SMB Continuous Availability (CA) feature when you create a new SMB volume. You can also enable SMB CA on an existing SMB volume; here you'll learn how to do it.

You should enable Continuous Availability for the following workloads and use cases only:

- Citrix App Layering
- FSLogix user profile containers, including FSLogix ODFC containers
- MSIX app attach with Azure Virtual Desktop
    -  When using MSIX applications with the CIM FS file format:
        - The number of AVD session hosts per volume shouldn't exceed 500.
        - The number of MSIX applications per volume shouldn't exceed 40.
    - When using MSIX applications with the VHDX file format:
        - The number of AVD session hosts per volume shouldn't exceed 500.
        - The number of MSIX applications per volume shouldn't exceed 60.
    - When using a combination of MSIX applications with both the VHDX and CIM FS file formats:
        - The number of AVD session hosts per volume shouldn't exceed 500.
        - The number of MSIX applications per volume using the CIM FS file format shouldn't exceed 24.
        - The number of MSIX applications per volume using the VHDX file format shouldn't exceed 24.
- SQL Server
    - Continuous Availability is currently supported on Windows SQL Server.
    - Linux SQL Server isn't currently supported.

> [!NOTE]
> Using SMB Continuous Availability shares is only supported for Citrix App Layering, SQL Server, FSLogix user profile containers including FSLogix ODFC containers, or MSIX app attach containers. This feature is currently supported on SQL Server on Windows. No other workload is supported.

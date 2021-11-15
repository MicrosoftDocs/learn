In recent months, Contoso has dramatically changed its attitude towards telecommuting, allowing most of its employees to work remotely. This has placed a significant stress on its aging VDI deployment, resulting in performance and stability issues. To address this challenge, you decide to evaluate Azure Stack HCI as a platform suitable for hosting VDI-based workloads.

## What are the benefits of VDI in Azure Stack HCI scenarios?

Azure Stack HCI VDI relies on its virtualization capabilities to implement VMs that run desktop operating systems and software programs. VDI offers a range of benefits, especially in remote access and branch office scenarios, including:

- Securing corporate assets by retaining them within on-premises datacenters.
- Mitigating the risk of data exfiltration by virtualizing the presentation layer, which minimizes the need for local data copies and direct network connectivity to target desktops.
- Allowing the use of personal devices for remote access while limiting the possibility of mixing personal and business data.
- Providing consistent user interface for a wide range of client devices.

VDI is one of the workloads that Azure Stack HCI is optimized for, with Microsoft Remote Desktop Services (RDS) or equivalent third-party offerings serving the role of a virtual desktop broker. Azure Stack HCI provides centralized storage and enhanced security, which simplify protecting user data and reduce the risk of accidental or intentional data leaks. In addition, users accessing VDI workloads can use services that run within the same cluster with minimal latency and without the dependency on additional infrastructure.

## Implement VDI workloads on Azure Stack HCI VMs

To evaluate VDI on Azure Stack HCI, you decide to use RDS. You conclude that this will help eliminate common support challenges associated with multi-vendor solutions and simplify most administrative tasks. To further enhance the core VDI-related features provided by Azure Stack HCI, you plan to leverage its integration with cloud-based solutions such as Azure Update Management and Microsoft Defender for Cloud.

At a high level, deployment of an RDS-based VDI environment on Azure Stack HCI involves the following steps:

1. Identify and purchase Azure Stack HCI hardware optimized for VDI workloads. Azure Stack HCI Catalog includes **Virtual desktop infrastructure** as one of the search filtering criteria for integrated systems and validated nodes.

    :::image type="content" source="../media/azs-hci-catalog-vdi.png" alt-text="The screenshot depicts the Azure Stack HCI Catalog, with **Virtual desktop infrastructure** selected as one of the search filtering criteria for integrated systems and validated nodes." border="false":::

1. Determine the preferred licensing model and purchase a sufficient number of RDS client access licenses (CALs). RDS supports Per Device and Per User CALs.
1. Obtain certificates for the Remote Desktop (RD) Gateway and RD Connection Broker servers. Client devices should trust the certification authority that issued the certificates.
1. Deploy RDS infrastructure components into Azure Stack HCI. To ensure resiliency of the RDS infrastructure beyond what is provided by the underlying Azure Stack HCI platform, you should configure multiple VMs to serve the roles of RD Connection Broker, RD Web Access, and RD Gateway servers. In this case, cluster nodes serve as the RD Virtualization Hosts.
1. Configure high availability of the RD Connection Broker and RD Gateway.
1. Create desktop collections that will contain the VMs you intend to make available to VDI users. In general, RDS supports four types of collections:

    - **Managed pooled**. Consists of VMs created by using a generalized image. Individual VMs are assigned automatically to individual users as they connect to the RDS deployment. After users terminate their desktop sessions, VMs are automatically reset to their original state and returned to the pool.
    - **Unmanaged pooled**. Consists of existing VMs running on the RDS Virtualization Hosts. Individual VMs are assigned automatically to individual users as they connect to the RDS deployment. After users terminate their desktop sessions, VMs are automatically returned to the pool.
    - **Managed personal**. Consists of VMs created by using a generalized image. You manually assign individual VMs to individual users before they connect to the RDS deployment. VMs retain their changes and the user assignments persist after users terminate their desktop sessions.
    - **Unmanaged personal**. Consists of existing VMs running on the RDS Virtualization Hosts. You manually assign individual VMs to individual users before they connect to the RDS deployment. VMs retain their changes and the user assignments persist after users terminate their desktop sessions.

    > [!NOTE]
    > Pooled desktop collections might lower the number of desktop VMs necessary to support your users. Managed pooled desktop collections tend to simplify maintenance because they do not require ongoing operating system or application patching, except for periodic updates to the generalized image. Managed personal desktop collections typically involve extra administrative effort, which includes operating system and application patching. With personal desktop collections, each desktop VM is assigned to only one user. Therefore, the number of desktop VMs in personal desktop collections is typically higher than pooled desktop collections.

1. Implement user profile disks and store them on Storage Spaces Direct (S2D) volumes.
1. Optionally, integrate the VDI deployment with Azure Update Management and Microsoft Defender for Cloud by using Windows Admin Center.
1. If necessary, deploy the Remote Desktop client to client devices.

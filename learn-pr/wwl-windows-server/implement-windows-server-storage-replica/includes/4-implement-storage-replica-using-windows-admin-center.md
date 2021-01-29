The simplest method you can use to implement Storage Replica is the intuitive graphical interface of Windows Admin Center.

## Validate prerequisites

Before you proceed with the implementation, you should first validate that all Storage Replica prerequisites are in place:

1. Identify the data volume you intend to use for replication and create a corresponding destination volume. For each destination volume, create a corresponding log volume on its respective servers.

    > [!tip]
    > Log volumes should reside on the faster storage, preferably solid-state drive (SSD)-based.

    > [!IMPORTANT]
    > You should allocate at least 8 GB for the log volumes. For a more accurate assessment, run  the Windows PowerShell `Test-SRTopology` cmdlet and refer to the results.

1. Install the **Storage Replica** feature and the **File Server** role service on the source and destination server.

    > [!NOTE]
    > The **File Server** role is required  to run `Test-SRTopology`.

1. Use the `Test-SRTopology` cmdlet to determine whether the source and destination volumes meet Storage Replica's requirements. You can use the cmdlet in requirements-only mode by specifying the `IgnorePerfTests` parameter first. If that's successful, rerun the cmdlet in the performance evaluation mode without the `IgnorePerfTests` parameter, as in the following example:

    ```powershell
    New-Item -ItemType Directory -Path 'c:\Temp' -Force
    Test-SRTopology -SourceComputerName S2D001 -SourceVolumeName C:\ClusterStorage\Volume1 -SourceLogVolumeName C:\ClusterStorage\Volume2 -DestinationComputerName S2D101 -DestinationVolumeName C:\ClusterStorage\Volume1 -DestinationLogVolumeName C:\ClusterStorage\Volume2 -DurationInMinutes 30 -ResultPath 'c:\Temp'
    ```

1. Review the **TestSrTopologyReport.html** report to ensure that your configuration meets Storage Replica's requirements.

## Implement Storage Replica by Using Windows Admin Center

1. In the Windows Admin Center, navigate to the source or destination server.
1. From the **Storage Replica** panel, use the **Replica with another server** interface to define a new partnership and replication group, and complete or select the following settings:

    - Source server
    - Replication group name
    - Destination server
    - Destination group name
    - Enable synchronous replication
    - Log size
    - Use blocks already seeded on the target to speed up initial synchronization
    - Encrypt replication traffic
    - Enable consistency groups

## Demonstration

The following video demonstrates how to implement Storage Replica by using Windows Admin Center.

The main steps in the process are:

1. Create an AD DS environment:
    1. Create a single-domain AD DS forest that includes two domain member servers with four data disks each.
    1. Create a management workstation running Windows 10.
1. On each domain member server, initialize the source and destination disks:
    1. Create an ReFS-formatted volume on each disk and assign drive letters to each disk.
    1. On the domain member servers, use **Server Manager** to initialize the source and destination disks.
    1. Create an ReFS-formatted volume on each disk and assign drive letters to each disk.
1. Use **Windows PowerShell** to enable **CredSSP** on the two domain member servers.
1. Use **Windows Admin Center** to configure **Storage Replica** between the two domain member servers.
1. Use **Windows Admin Center** to validate the **Storage Replica** configuration.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4Myb3]
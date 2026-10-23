Contoso needs a repeatable way to prepare and deploy Windows Server 2025 across its sites. You select tools that support the target operating system and distinguish readiness checks from installation automation.

> [!IMPORTANT]
> Microsoft Deployment Toolkit (MDT) is retired and unsupported. Don't use it as the basis for a new Windows Server 2025 deployment. See [MDT support lifecycle](/troubleshoot/windows-server/setup-upgrade-and-drivers/deployment-toolkit-support).

## Assess the target environment

Start with an inventory of the target computers, installed applications, server roles, and workload dependencies. Compare the hardware against the Windows Server 2025 requirements, and check application and driver support with the respective vendors. An inventory shows what exists, but doesn't by itself certify that a workload supports the new operating system.

Separate installation minimums from workload capacity. A computer that meets the Server Core memory minimum might still lack enough memory for its planned roles. Record current CPU, memory, storage, and network demand, then use representative workload tests to size the replacement server.

For an in-place upgrade, also verify the supported upgrade path and each application's upgrade requirements. For a migration, identify how you transfer data, preserve permissions, and validate the service on the destination. Microsoft's [server application compatibility guidance](/windows-server/get-started/application-compatibility) is a starting point, not a replacement for product-specific support information.

## Choose supported deployment tools

The Windows Assessment and Deployment Kit (Windows ADK) includes tools for preparing Windows installations. Select an ADK release that explicitly supports Windows Server 2025, apply its required servicing updates, and install the separate Windows Preinstallation Environment (Windows PE) add-on when you need bootable deployment media. Check the [ADK download and support information](/windows-hardware/get-started/adk-install) rather than assuming an older deployment workstation supports a newer server release.

These tools serve different purposes:

| Tool | Purpose |
| --- | --- |
| Windows System Image Manager (Windows SIM) | Create and validate XML answer files for unattended Windows Setup. |
| Deployment Image Servicing and Management (DISM) | Inspect, mount, service, capture, and apply Windows images. |
| Windows PE | Boot a target computer into a small deployment and recovery environment before the full operating system runs. |

For example, use DISM to inspect the available image indexes before selecting an edition for deployment. Use Windows SIM to define installation settings for that image. Windows PE provides an environment in which you run deployment tools, but it isn't the installed server operating system. These components don't require MDT.

## Automate Windows Setup with an answer file

An answer file supplies settings that otherwise require interaction during installation. In Windows SIM, use the target Windows image and its catalog to select applicable settings. Add the settings to the appropriate configuration passes, then validate the answer file against that image. This helps detect invalid settings before you start a deployment.

Typical settings include the installation language, image selection, and target disk and partition. Review disk settings carefully: an automated partitioning configuration can erase existing data. Test on an isolated computer or VM with a representative disk layout before using the file on a production server.

Windows Setup can discover an `Autounattend.xml` file at the root of removable media, or you can explicitly select an answer file when you start Setup from Windows PE. Incorrect or missing required settings can still cause Setup to display prompts. An answer file automates installation choices, not application compatibility assessment or workload sizing.

Restrict access to answer files and deployment media because they can contain sensitive information. Don't store credentials in a shared template without appropriate protection. See [Automate Windows Setup](/windows-hardware/manufacture/desktop/automate-windows-setup) and [answer-file best practices](/windows-hardware/customize/desktop/wsim/best-practices-for-authoring-answer-files).

## Validate a repeatable deployment workflow

For Contoso's new servers, use the following high-level workflow:

1. Verify hardware, workload capacity, application compatibility, and the selected installation option.
1. Prepare the supported Windows Server installation media and compatible ADK tools.
1. Inspect the target image with DISM and create its answer file with Windows SIM.
1. Validate the answer file and test Setup on a representative target.
1. Check the installed edition, drivers, network connectivity, and required server roles.
1. Run workload and recovery tests, then approve the tested configuration for wider deployment.

If your process requires a customized image, DISM provides image-management capabilities separately from answer-file authoring. Consult the [DISM image-management reference](/windows-hardware/manufacture/desktop/dism-image-management-command-line-options-s14) for the operation you need, and the [Windows PE overview](/windows-hardware/manufacture/desktop/winpe-intro) for deployment-environment capabilities.

Keep the image version, answer file, tool versions, and test results together as the deployment baseline. Repeat validation when you change the image or installation settings. This gives Contoso a documented process without relying on unsupported solution-accelerator claims.

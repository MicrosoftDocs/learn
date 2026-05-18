Before you prototype and develop Azure Sphere applications, set up Azure Sphere Integrated tooling on your development computer. Azure Sphere Integrated uses the Azure CLI extension (`az sphere`) from a standard PowerShell, Windows Command Prompt, or Bash shell. The legacy `azsphere` CLI, tenant-based workflow, and other Azure Sphere Legacy service interfaces retire on 27 September 2027.

You'll need:

- An Azure account with an active subscription and a resource group for Azure Sphere resources.
- An Azure Sphere development kit and host USB access. If you use a virtual machine, configure USB pass-through.
- Windows 11, Windows 10 Anniversary Update or later, Ubuntu 24.04 LTS x64, or Ubuntu 22.04 LTS x64.
- Azure CLI 2.45.0 or later with the Azure Sphere extension.
- The Azure Sphere SDK for your operating system. On Linux, you'll need `sudo` permission, `net-tools`, and `curl`; answer `Y` to the installer's `udev` rule and `azsphere` group prompt, then log out and back in (or restart).
- Visual Studio Code with the Azure Sphere and CMake Tools extensions, plus CMake and Ninja.
- The GNU Arm Embedded Toolchain for the real-time capable application (RTApp) exercises.

The components you'll use are:

- **Azure Sphere SDK:** Provides the device libraries, build and debug support, and local tools required to develop Azure Sphere applications. Device and cloud management commands are provided through the Azure Sphere extension for Azure CLI.

- **Azure Sphere catalog:** An Azure resource that securely isolates and organizes your organization's Azure Sphere devices. Each device is claimed once into a catalog; after it's claimed, it can't be moved to another catalog.

- **Azure RBAC:** Access to Azure Sphere resources is managed with Azure role-based access control on the resource group, catalog, product, or device group. Use Azure Sphere-specific roles—Azure Sphere Owner, Azure Sphere Contributor, Azure Sphere Publisher, and Azure Sphere Reader—at the least scope that grants the needed access. Generic Azure Reader doesn't work as expected for Azure Sphere resources; use Azure Sphere Reader for read-only access.

- **Azure Sphere OS:** A Linux-based microcontroller operating system created to run on an Azure Sphere-certified chip and connect securely to the Azure Sphere Security Service.

- **Azure Sphere Security Service:** Authenticates devices and delivers Azure Sphere OS updates. In normal cloud-managed device groups, deployments can also deliver application updates. This module uses sideloaded applications in the Development device group, which receives OS updates but not cloud application updates.

- **Azure Sphere applications:** High-level applications run on Azure Sphere OS and can communicate with the internet and cloud services when configured. RTApps run on the real-time cores; the RTApp in this module can't use the internet or Azure IoT Hub directly. To send RTApp data to IoT Hub, you would need a high-level partner application and separate IoT Hub/DPS setup.

The steps you follow are:

1. Install the Azure Sphere SDK and development tools.
2. Sign in with Azure CLI, verify that Azure CLI is version 2.45.0 or later, install the Azure Sphere extension, and select your subscription.
3. Create or select an Azure resource group and Azure Sphere catalog, then set Azure CLI defaults for them.
4. List the attached Azure Sphere device and claim it into the catalog.
5. Configure Wi-Fi and update the Azure Sphere OS.
6. Enable application sideloading, development, and RT-core debugging.

After you complete this unit, your device and development environment will be ready for the RTApp exercises in this module.

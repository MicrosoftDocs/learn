**DSC for Linux** enables you to manage **Linux** systems using the same **Desired State Configuration** approach used for **Windows** systems. This ensures consistent configuration management across hybrid environments.

For more specific and up-to-date details, visit [Get started with Desired State Configuration (DSC) for Linux](/powershell/scripting/dsc/getting-started/lnxgettingstarted).

## Supported Linux operating systems

The following **Linux** operating system versions are currently supported by both **PowerShell DSC** and **Azure Automation State Configuration:**

- **CentOS:** 6, 7, and 8 (x64)
- **Debian GNU/Linux:** 8, 9, and 10 (x64)
- **Oracle Linux:** 6 and 7 (x64)
- **Red Hat Enterprise Linux Server:** 6, 7, and 8 (x64)
- **SUSE Linux Enterprise Server:** 12 and 15 (x64)
- **Ubuntu Server:** 14.04 LTS, 16.04 LTS, 18.04 LTS, and 20.04 LTS (x64)

## DSC for Linux resources

**DSC for Linux** includes built-in resources for managing **Linux** systems:

- **nxFile:** Manage files and directories.
- **nxScript:** Run scripts to configure resources.
- **nxUser:** Manage user accounts.
- **nxGroup:** Manage user groups.
- **nxService:** Manage services using systemd, upstart, or System V.
- **nxPackage:** Manage packages using apt, yum, or zypper.

## Implementing DSC for Linux on Azure

To implement **DSC for Linux** on **Azure**, you can use **Azure Automation State Configuration** to:

1.  **Create DSC configurations** for **Linux** systems using **PowerShell**.
2.  **Upload and compile** configurations in **Azure Automation**.
3.  **Onboard Linux VMs** to **Azure Automation State Configuration**.
4.  **Apply configurations** to **Linux** nodes through the built-in pull server.

This approach provides centralized management and monitoring of both **Windows** and **Linux** systems from a single platform.

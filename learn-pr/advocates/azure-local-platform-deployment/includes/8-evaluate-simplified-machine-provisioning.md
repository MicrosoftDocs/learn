Simplified machine provisioning is an alternative provisioning method for preparing physical machines to become Azure Local nodes. Simplified machine provisioning helps with operating system installation and Arc registration, but it doesn't replace cluster deployment or commissioning.

The workflow begins with a maintenance environment and an ownership voucher for each target machine. The *maintenance environment* is a temporary preparation environment, not the finished Azure Local host installation. The *ownership voucher* is part of the FIDO Device Onboard (FDO) mechanism used to establish and transfer device ownership information for onboarding.

In the documented workflow:

1. Prepare the required tooling and maintenance media on a supported preparation computer.
1. Boot the target machine into the maintenance environment and obtain its ownership voucher.
1. Have the authorized Azure administrator claim the target machine and apply site configuration.
1. Provision the operating system and complete Arc registration.
1. Continue from **Ready to cluster** into the normal supported cluster deployment workflow.

Site configuration supplies the shared configuration needed for the provisioning location. It reduces repeated node-preparation work, but the resulting Azure Local nodes still need the same appropriate deployment contract, environment validation, and acceptance evidence.

Protect ownership vouchers and onboarding materials as controlled artifacts.

Evaluate simplified provisioning against its own supported boundary, not just the hardware and permissions accepted by normal cluster deployment:

| Prerequisite | Preview requirement in this baseline |
| --- | --- |
| Validated hardware | One of these validated models: Lenovo ThinkAgile MX650 V3, Lenovo ThinkAgile MX650 V4, HPE ProLiant DL360 Gen11, Dell AX-750, or Dell AX-650 |
| Preparation computer and media | Windows 11 computer with reliable internet access and a USB port, a USB flash drive with at least 8 GB, and a USB port on each target machine |
| Machine security | Secure Boot and Trusted Platform Module (TPM) enabled |
| Azure region | Provisioning resources must be in East US. The resource group's metadata location can be another region |
| Resource-group permissions | Contributor and Role Based Access Control Administrator, or an existing Owner assignment, for the identity provisioning the machines |
| Host identity preparation | Prepared AD DS environment and the normal downstream deployment prerequisites |

Register the `AzureLocalZTP` feature under `Microsoft.DeviceOnboarding` in the subscription. The provisioning workflow also requires these resource providers to be registered: `Microsoft.HybridCompute`, `Microsoft.AzureStackHCI`, `Microsoft.DeviceOnboarding`, `Microsoft.Edge`, `Microsoft.GuestConfiguration`, `Microsoft.HybridConnectivity`, `Microsoft.KeyVault`, `Microsoft.ManagedIdentity`, `Microsoft.PolicyInsights`, `Microsoft.Storage`, and `Microsoft.Insights`.

Download the maintenance environment ISO, USB preparation tool, and Configurator app through **Azure Arc > Azure Local > Get started > Try provisioning > View Downloads**. Creating the installation USB erases its existing contents, so use an empty drive or preserve its data first. Keep the target machines powered on and connected while provisioning downloads the operating system, configures it, registers with Arc, and installs the required extensions.

> [!WARNING]
> Preparation workflow requires AD DS. Don't treat Local Identity or the internal-DNS as supported alternatives for this provisioning path merely because they're available in other deployment workflows.

Compare provisioning settings with downstream deployment requirements. The provisioning form accepts passwords with a 12-character minimum, while cluster deployment requires at least 14 characters. Use at least 14 characters, including lowercase and uppercase letters, a number, and a special character, from the start so that a credential accepted during preparation doesn't fail the later deployment requirements.

Use a separate approval and recovery plan. Record the support route, authorized cleanup or reprovisioning procedure, and acceptance scope before claiming machines. Track each machine under **Azure Arc > Operations > Provisioning > Provisioned machines** and wait for **Ready to cluster** before moving into the normal cluster deployment workflow.

> [!NOTE]
> **Provisioning decision:** Treat **Ready to cluster** as the end of Azure Local node preparation, not as evidence that the platform is commissioned.

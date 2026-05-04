A [device identity](/entra/identity/devices/overview) is an object in Microsoft Entra ID, similar to users, groups, or applications. Device identities provide administrators with metadata that can be used to inform access control and configuration decisions.

Device identities are required for scenarios such as device-based Conditional Access policies and mobile device management using Microsoft Intune and related services.

## Acquiring device identities

There are three primary methods for acquiring a device identity. These methods can coexist within a single organization.

### Entra registration

[Entra registration](/entra/identity/devices/concept-device-registration) enables employees to securely connect personal devices to organizational resources. This method is intended for bring-your-own-device (BYOD) scenarios. Devices can be registered with Entra ID without requiring users to sign in to the device with an organizational account. The device is still associated with the organization and can be managed through Entra ID and Conditional Access policies.

Instead, users may sign in using a local account, such as a Microsoft account, on Windows 10 or later. Once registered, the device is associated with an Entra account, which governs access to organizational resources. Access can be restricted based on Conditional Access policies applied to the device identity.

Entra registration can occur automatically when a user accesses a work application for the first time or manually via the Settings menu on Windows 10 or Windows 11.

> [!NOTE]
> Entra registration is distinct from device enrollment. If administrators allow device enrollment, Entra registered devices can be further managed through Microsoft Intune.
>
> Intune enables enforcement of organizational policies such as encryption requirements, password complexity, and security software compliance.

### Entra join

[Entra Join](/entra/identity/devices/concept-directory-join) allows organizations to register devices with Microsoft Entra ID, so the devices are recognized as part of the organization. This method is suitable for organizations of any size or industry and is compatible with hybrid environments.

Entra joined devices authenticate through Entra ID rather than a traditional domain controller. Access to resources is governed by the Entra account and Conditional Access policies applied to the device.

For implementation guidance, refer to [implementing Entra join](/entra/identity/devices/device-join-plan) on Microsoft Learn.

> [!NOTE]
> Entra Join itself does not manage device settings or policies. Management of the device’s configuration and security is handled by tools such as Microsoft Intune or Configuration Manager.

### Autopilot device registration

When a device is registered through Windows Autopilot, it's recognized as a corporate-owned device. This ensures that Autopilot profiles that mandate settings, like device naming conventions and whether the user is a local administrator, are applied automatically during provisioning.

> [!NOTE]
> Autopilot registration does not by itself control access to apps or services—it simply identifies the device as corporate‑owned and applies the assigned Autopilot provisioning settings.

Without a valid Entra device identity—whether through Entra Join, Entra Hybrid Join, or Entra registration—features such as multifactor authentication (MFA) and single sign-on (SSO) won’t function properly. As a result, users may be unable to authenticate or access organizational resources.

### Entra hybrid join

[Entra hybrid joined devices](/entra/identity/devices/concept-hybrid-join) are connected to an on-premises Active Directory (AD) and registered with Microsoft Entra ID. This transitional approach enables organizations to maintain existing on-premises processes while gaining access to selected cloud capabilities. These devices require periodic network connectivity to on-premises domain controllers. Organizations should consider accelerating their journey to cloud-native Windows and adopting Entra join sooner rather than later, even if maintaining connectivity to on-premises Active Directory is not a concern.

For implementation guidance, refer to [implementing Entra hybrid join](/entra/identity/devices/hybrid-join-plan).

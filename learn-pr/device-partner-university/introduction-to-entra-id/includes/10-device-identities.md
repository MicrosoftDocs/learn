A [device identity](/entra/identity/devices/overview) is an object in Microsoft Entra ID, similar to users, groups, or applications. Device identities provide administrators with metadata that can be used to inform access control and configuration decisions.

Device identities are required for scenarios such as device-based Conditional Access policies and mobile device management using Microsoft Intune and related services.

## Acquiring device identities

There are three primary methods for acquiring a device identity. These methods can coexist within a single organization.

### Entra registration

[Entra registration](/entra/identity/devices/concept-device-registration) enables employees to securely connect personal devices to organizational resources. This method is intended for bring-your-own-device (BYOD) scenarios. Devices can be registered with Entra ID without requiring an organizational account for device sign-in.

Instead, users may sign in using a local account, such as a Microsoft account, on Windows 10 or later. Once registered, the device is associated with an Entra account, which governs access to organizational resources. Access can be restricted based on Conditional Access policies applied to the device identity.

Entra registration can occur automatically when a user accesses a work application for the first time or manually via the Settings menu on Windows 10 or Windows 11.

> [!NOTE]
> Entra registration is distinct from device enrollment. If administrators allow device enrollment, Entra registered devices can be further managed through Microsoft Intune.
>
> Intune enables enforcement of organizational policies such as encryption requirements, password complexity, and security software compliance.

### Entra join

[Entra Join](/entra/identity/devices/concept-directory-join) allows organizations to deployed devices that are recognized and managed by Entra ID. This method is suitable for organizations of any size or industry and is compatible with hybrid environments.

Entra joined devices authenticate through Entra ID rather than a traditional domain controller. Access to resources is governed by the Entra account and Conditional Access policies applied to the device.

For implementation guidance, refer to [implementing Entra join](/entra/identity/devices/device-join-plan) on Microsoft Docs.

### Entra hybrid join

[Entra hybrid join](/entra/identity/devices/concept-hybrid-join) is a transitional approach for organizations with existing Active Directory (AD) infrastructures are connected to an on-premises AD and registered with Entra ID, enabling access to selected cloud capabilities. These devices require periodic network connectivity to on-premises domain controllers. If maintaining this connection is a concern, organizations should consider transitioning to Entra join.

For implementation guidance, refer to [implementing Entra hybrid join](/entra/identity/devices/hybrid-join-plan).

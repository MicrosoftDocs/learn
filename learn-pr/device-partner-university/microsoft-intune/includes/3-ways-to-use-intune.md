## Enable secure access to email on devices

Many organizations need a reliable way to secure email access for employees using internet-connected devices. With Intune’s Conditional Access solution, email stays protected by ensuring only devices enrolled in Intune can access it—and there’s no need to set up a gateway machine at the edge of the network to make this happen.

Intune also supports secure access to services and apps through Intune-managed certificates, a standard VPN gateway or proxy, and [Microsoft Entra Private Access](/entra/global-secure-access/concept-private-access). There are also non-Microsoft options available, often referred to as Zero Trust Network Access (ZTNA) or Secure Access Service Edge (SASE) solutions—all helping to maintain robust security while providing flexible and secure access to resources.

## Offer a BYOD policy to employees

Device enrollment isn’t practical when employees want to retain control over their personal devices, which is often the case with Bring Your Own Device (BYOD) policies.

Fortunately, you can still manage apps that handle corporate data without fully controlling the employee’s device, even if those apps access both corporate and personal information. *On Windows, this capability is available exclusively through Microsoft Edge.*

[App protection policies](/mem/intune/apps/app-protection-policy) help prevent data loss from unmanaged apps and storage locations. For example, Intune can block users from copying text from a corporate email profile to a personal email profile, even when both profiles are configured in Outlook Mobile.

![A photograph of an employee smiling while working on a laptop at a desk in an office building.](../media/intune-worker.png)

## Issue corporate-owned devices to employees

Windows Autopilot provides bulk provisioning and integrates with Intune for ongoing device management—streamlining deployment and management processes for large numbers of devices. For instance, when an employee powers on their new company-owned device, they go through a corporate-branded setup process where they must authenticate themselves. Once authenticated, the device is seamlessly configured with the necessary security policies. After this, the employee can launch the Intune Company Portal app to access the optional corporate apps available to them.

## Issue limited-use shared devices to employees

Employees sometimes use shared devices for tasks like processing sales or checking inventory. These devices typically run in limited-use mode, which restricts what the user can interact with to just a single line-of-business app. By using Intune, you can easily secure and centrally manage these devices, ensuring they’re configured to operate in limited-use mode. This provides greater control over how devices are used—giving you confidence that your systems are protected.

## Access Microsoft 365 from unmanaged public kiosks

Sometimes employees need to use devices, apps, or browsers that you can’t manage, such as public computers at trade shows and hotel lobbies. With Intune, access to corporate email is restricted on unmanaged devices. This means that authenticated employees can't inadvertently leave corporate data on untrusted computers, helping ensure that sensitive information remains secure.
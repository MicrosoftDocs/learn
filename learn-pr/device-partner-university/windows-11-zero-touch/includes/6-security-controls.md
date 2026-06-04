Security works best when it's applied consistently and automatically. In this deployment, security settings are not something IT configures manually on each device. Instead, they're enforced through management from the moment the device enrolls.

Secure sign-in is a foundational element. By enforcing strong authentication requirements across all devices, IT reduces the risk of unauthorized access without relying on users to make good security decisions on their own.

Device-level protections add another layer. Encryption helps protect data if a device is lost or stolen, while built-in threat protection reduces exposure to malware and other attacks. Application control policies help ensure that only trusted software runs on managed devices.

Because these settings are applied through policy, they remain enforced over time. If a device is reset, replaced, or newly deployed, the same protections apply automatically.

A policy-driven approach also simplifies long-term device management. When a device is replaced, reset, or reissued, security controls don't need to be reapplied manually. Instead, the same baseline policies take effect automatically as part of enrollment.

This consistency reduces the risk of configuration drift and allows IT to focus on maintaining up-to-date standards, improving overall security posture without increasing management complexity.

### Baseline security controls applied through policy

These baseline protections are enforced through built-in Windows security capabilities and Intune-managed policies. Consult this table to see several common areas of security policy, what those policies enforce, and how they apply to this scenario.

| **Security area** | **What the policy enforces** | **Why it matters in this deployment** |
| :---: | :---: | :---: |
| Sign-in protection | Strong authentication requirements applied at first sign-in | Ensures only authorized users can access devices shipped directly to employees |
| Device encryption | Automatic encryption of local storage | Protects organizational data if a device is lost, stolen, or replaced |
| Threat protection | Built-in protections applied consistently across all devices | Reduces exposure to malware without relying on manual configuration |
| Application control | Restrictions on which apps can run on managed devices | Helps prevent untrusted software from running in the environment |
| Policy inheritance | Security settings reapply automatically on reset or replacement | Maintains a consistent security baseline over the device lifecycle |

## Exercise: Validate baseline security

In this scenario, a device was replaced due to hardware failure.

### Your task

Explain how you would confirm that:

- Secure sig-nin requirements are enforced
- Device encryption is enabled
- Threat protection policies are active

### What success looks like

You can explain how security enforcement based on automated reporting, rather than user verification, enables a stronger and more consistent security posture.

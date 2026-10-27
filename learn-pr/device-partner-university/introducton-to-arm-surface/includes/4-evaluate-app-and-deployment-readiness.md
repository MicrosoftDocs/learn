Before deploying ARM-based Surface devices, organizations should evaluate the applications, drivers, peripherals, and deployment processes required by their users. Microsoft provides resources that can help IT teams understand application compatibility, prepare traditional deployment workflows, and address compatibility issues.

## Check application compatibility

The [Works on Windows Arm](https://worksonwoa.com/) resource helps organizations evaluate application readiness before deployment. It identifies applications that run natively on Arm, run through emulation, or aren't currently supported. The resource includes consumer and business applications across categories such as productivity, development, security, networking, and VPN tools.

IT teams can use this information to identify business-critical applications that are ready for Windows on Arm and applications that might require extra testing or remediation.

## Prepare the deployment approach

Organizations can use modern management tools such as Microsoft Intune to manage ARM-based Surface devices. For organizations that use traditional operating system deployment, Microsoft Configuration Manager also supports deployment scenarios for Arm64 devices.

These deployments have specific prerequisites. Administrators should confirm the supported Configuration Manager and Windows versions, add the required x64 emulator component, and ensure that boot-critical Arm64 drivers are available in Windows Preinstallation Environment when required.

## Address application compatibility issues

If an organization encounters an application compatibility issue, App Assure can help investigate and remediate eligible business-critical application issues. Support can cover internally developed line-of-business applications, independent software vendor applications, and Microsoft applications.

The engagement generally begins when the customer identifies and submits a compatibility issue. An App Assure representative and support engineer then work with the application owner to investigate the issue, engage the software vendor when appropriate, and escalate to Windows engineering when needed.

**Why this matters:** Application readiness isn't determined by emulation alone. Organizations should also account for native driver availability, business-critical application support, peripheral requirements, and deployment processes. Reviewing these areas before rollout helps IT teams identify potential blockers and choose appropriate users and workloads for Arm-based Surface devices.

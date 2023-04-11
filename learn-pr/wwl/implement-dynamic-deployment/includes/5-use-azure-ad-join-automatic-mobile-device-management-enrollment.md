
Joining a device to Azure AD is also considered a method of dynamic deployment. This process can be used for either organization-owned devices (sometimes referred to as CYOD) or user-owned devices (BYOD).

### Organizational-owned devices

Instead of joining a domain using a domain controller, the device is enrolling using Azure AD Join. This helps streamline deployment and offer new deployment options. Organizations can support scenarios such as a store-bought PC, which the user self-enrolls with their credentials. During the enrollment process, organizational policies and configurations can be applied to ensure the device meets compliance, and deny enrollment if conditions aren't met. This process is faster and easier than requiring a user to reimage the device, and can be a standard process for IT device provisioning, not just exception use cases.

### User-owned scenarios

MDM enrollment also provides an easy way for users and vendors to use their personal devices to access organizational apps and resources. Users can add their Microsoft work account to Windows and enjoy simpler and safer access to the apps and resources of the organization. IT can enforce certain policies – and users have the option to accept or reject them, but must accept them to get access to resources.

Like organizational-owned devices, the MDM enforces compliance with your corporate policies, adds or removes apps, and much more. In addition, the MDM can report a device’s compliance with Azure AD. This check enables Azure AD to allow access to corporate resources or applications secured by Azure AD only to devices that comply with policies.

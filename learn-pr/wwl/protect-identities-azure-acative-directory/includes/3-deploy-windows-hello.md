
There are many options from which you can choose when deploying Windows Hello for Business. Providing multiple options ensures nearly every organization can deploy Windows Hello for Business. Providing many options makes the deployment appear complex, however, most organization will realize they've already implemented most of the infrastructure on which the Windows Hello for Business deployment depends. It’s important to understand that Windows Hello for Business is a distributed system and does take proper planning across multiple teams within an organization.

> [!NOTE]
> Windows Hello for Business is an exclusive Windows 10 or later feature – it is not supported on earlier versions of Windows.

### Deployment models

There are three deployment models from which you can choose:

 -  **Cloud only**. The cloud only deployment model is for organizations who only have cloud identities and don't access on-premises resources. These organizations typically join their devices to the Azure AD and exclusively use resources in the cloud such as SharePoint, OneDrive, and others. For this scenario, you should configure Windows Hello for Business by using Intune. Currently, Intune is the only cloud-based management system that can be used to configure Windows Hello for Business on Windows devices joined to Azure AD. This approach will be examined in later units.
 -  **On-premises**. The on-premises deployment model is for organizations that don’t have cloud identities or use applications hosted in Azure Active Directory. Windows Hello for Business supports this scenario, and you can use it on Windows machines, without cloud service. For this scenario, you should use Group Policy to deploy and configure Windows Hello for Business.
 -  **Hybrid**. You can also use Windows Hello for Business in a hybrid scenario. This usually occurs when an organization uses both on-premises AD DS and Azure AD, and other cloud resources. In the hybrid model, you should choose which mechanisms (Group Policy or Intune) you'll use. You should make sure that you don’t overlap settings between Group Policy and Intune. Also, when using Intune management of Windows Hello for Business, devices must either be enrolled with Intune client or joined to Azure AD.

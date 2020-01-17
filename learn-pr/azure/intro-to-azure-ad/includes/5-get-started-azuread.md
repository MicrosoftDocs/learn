Your organization has decided it wants to use Azure Active Directory (Azure AD) to manage secure access for doctors, external healthcare partners, and all internal staff members. You've been asked to look into how it should be implemented for your organization.

Here, you'll learn how to take a phased approach to deploying Azure AD for your organization. You'll learn how to lay a foundation, deploy Azure AD by creating a tenant, and associate a subscription with it.

## Phased deployment

A good way to deploy Azure AD is to take a phased approach. Your deployment is split into several stages. Each stage addresses a key aspect of Azure AD. Each phase includes tasks that you'll need to complete before going to the next stage. This approach lays a foundation for your Azure AD, helps secure it, and then ensures it's fit for purpose from the beginning.

### Stage 1: Build a secure foundation

At this first stage, you need to build a foundation of security for your Azure AD. The doctors, internal staff members, and external healthcare partners all need the most secure access you can provide. Configure baseline security features before you add or create user accounts. The work you do here helps ensure your Azure AD is in a secure state from the start. The tasks you must undertake in this phase include:

| Task                                                         | Description                                                       | License needed   |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :------------------ |
| **Assign more than one global administrator**| Give at least two Azure AD accounts the global administrator role. Make sure you don't use these accounts daily, and ensure they have long and complicated passwords.| Free       |
| **Use regular administrative roles where possible**|Your non-global administrators should never have more permissions than they need to do their work. Use these regular administrator roles by default and avoid using the global administrator roles unless required. | Free       |
| **Configure Privileged Identity Management (PIM) to track administrators**| Use PIM to monitor how your administrator roles are being used. This action helps you improve your governance and compliance.| Azure AD Premium P2 |
| **Configure self-service password reset**| Reduce the number of help desk tickets for password resets, and let internal users reset their passwords through policies you've configured. |Free |
| **Create a list of banned passwords** | Use this list to prevent users from having passwords that are phrases or words common to your organization, like your company name or headquarters location. |Free |
| **Inform your users to not reuse credentials** | When someone reuses the same credentials across multiple platforms, they can be used by an attacker to access all those platforms if a single platform is compromised.  | Free       |
| **Set passwords to never expire for cloud-based user accounts** | Routine password resetting tempts users to increment their existing passwords by, for example, changing their password from `R4ndom1Strong` to `R4ndom2Strong` password, and so on.| Free       |                    |
| **Enforce multi-factor authentication through Conditional Access policies** | Configure Conditional Access policies to ensure that users must go through multiple authentication challenges before accessing an application. | Azure AD Premium P1 |
| **Configure Azure Active Directory Identity Protection (AADIP)** | Flag and block suspicious sign-ins and compromised user credentials for your organization's users. You can also use it to automatically trigger multi-factor authentication or a password reset, depending on the severity of the risk detected. | Azure AD Premium P2 |
| | |

### Stage 2: Add users, manage devices, and configure synchronization

Now you can add users, and plan how to handle external guest user access. The tasks you do in this stage include:

| Task                                                         | Description                                                       | License needed                                             |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
|**Configure Azure AD Connect**| Install and set up Azure AD Connect, so you can synchronize users from your on-premises Active Directory to Azure. | Free                                                |
|**Use password hash synchronization**| You can synchronize password changes, and detect and fix bad passwords. You'll also get reports on leaked user credentials. | Free                                                |
|**Use password writeback**| Configure password writeback so any changes to passwords in Azure are written to your on-premises Active Directory. | Azure AD Premium P1                                          |
|**Use Azure AD Connect Health**|  You can use Azure AD Connect Health to monitor the health statistics for your Azure AD Connect environment. | Azure AD Premium P1                                          |
|**Give users the licenses they need at group level**| You can assign licenses at a group level. This way, you control licensing for many users at once, saving your organization time, and reducing complexity.|Free|
|**Use Azure AD B2B Collaboration for guest user access**| This way, you ensure external healthcare partner users access your applications and services using their own work or social identities. You won't have to manage their credentials for them. | Licenses needed depend on which features you want the guest users to use|
|**Have a device management strategy** | Put together a plan based on which devices your company allows. For example, will you permit Bring Your Own Device (BYOD), or will the company only accept devices it has given users? |Free|
|**Use passwordless authentication for your users**| Make authentication more convenient. For example, if users have Microsoft Authenticator installed on their phones, they can receive a notification with a code they enter at sign-in, along with a PIN, or a biometric attribute like their fingerprint. | Azure AD Premium P1

### Stage 3: Manage your applications

You can now integrate your applications with Azure AD. The specific tasks you need to undertake include:

| Task                                                         | Description                                                       | License needed    |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :------------------ |
| **Identify applications**                                   |  Investigate the applications in your organization. Your organization could, for example, have applications on-premises or software as a service (SaaS) applications in the cloud. Choose applications that you want to manage with Azure AD. | N/A |
|**Use SaaS applications in the Azure AD gallery**|  Your organization probably uses SaaS applications that are already in the gallery and you'll find in the Azure portal. Use these applications from the gallery whenever possible. You'll easily integrate your applications and Azure AD, saving yourself some time.  | Free       |
| **Integrate your on-premises applications by using Application Proxy**| You can let Azure AD users sign in to your on-premises applications with their Azure AD account. |Free

### Stage 4: Monitor your administrators, do access reviews, and automate user lifecycles

Now you can address how much privilege your administrators should have, and complete access reviews. You can also configure how you want to automate common user lifecycle tasks. Here are the tasks you'll undertake in this stage:

| Task                                                         | Description                                                       | License needed    |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :------------------ |
|**Use Privileged Identity Management (PIM) to control administrator access** | Ensure that administrators can only use their account after successfully completing a multi-factor authentication challenge, or by requesting approval from an accepted approver. | Azure AD Premium P2 |
|**Complete access reviews for Azure AD directory roles in PIM**| Regularly review administrative access based on your organization's requirements for privileged roles, by configuring access review policies in PIM.  | Azure AD Premium P2 |
|**Configure dynamic group membership policies**| Automatically add users to specific groups based on known profile information, like department, or region,  to save time and effort. For example, you can automatically add all users who are part of the Human Resources department to a user group called Human Resources. |Free |
| **Use group-based application assignment**| Use group-based access management to give all users in a group access to an application. With dynamic groups, when the user is removed from a user<!--CE: Is this correct? Or could we simply say: 'When the user is removed....'-->, they automatically lose access to the application. This action helps keep your applications secure. |Free |
| **Configure automated user account provisioning and deactivation** | You create application-specific accounts automatically for users to use SaaS applications, based on existing Azure AD users and groups. You can also ensure that user accounts are automatically deprovisioned when a user leaves the organization, keeping your organization protected from unauthorized access. | Free|

## Create a tenant

When you've laid the groundwork for your Azure AD, you can begin to configure and start using it. You'll need to create a tenant, which is considered a resource in Azure.

Use the Azure portal to create a tenant and a new Azure AD resource.

![Create resource](../media/5-create-resource.png)

You'll use a form in the Azure portal to create your Azure AD.

![Azure AD](../media/5-create-azuread.png)

## Associate a subscription

When your tenant has been created, you'll associate it with a subscription. In the Azure portal, go to your subscription and change it to your new directory.

![Change subscription](../media/5-change-subscription-directory.png)
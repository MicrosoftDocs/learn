Applications in the Azure AD gallery support one of two provisioning modes:

* **Manual** provisioning means there's no automatic Azure AD provisioning connector for the app yet. User accounts must be created manually. Examples are adding users directly into the app's administrative portal or uploading a spreadsheet with user account detail. Consult the documentation provided by the app, or contact the app developer to determine what mechanisms are available.
* **Automatic** means that an Azure AD provisioning connector has been developed for this application. Follow the setup tutorial specific to setting up provisioning for the application.

The provisioning mode supported by an application is also visible on the **Provisioning** tab after you've added the application to your enterprise apps.

## Benefits of automatic provisioning

As the number of applications used in modern organizations continues to grow, IT admins are tasked with access management at scale. Standards such as SAML or OIDC allow admins to quickly set up single sign-on (SSO), but access also requires users to be provisioned into the app. To many admins, provisioning means manually creating every user account or uploading CSV files each week. These processes are time-consuming, expensive, and error prone. Solutions such as SAML just-in-time (JIT) have been adopted to automate provisioning. Enterprises also need a solution to deprovision users when they leave the organization or no longer require access to certain apps based on role change.

Some common motivations for using automatic provisioning include:

- Maximizing the efficiency and accuracy of provisioning processes.
- Saving on costs associated with hosting and maintaining custom-developed provisioning solutions and scripts.
- Securing your organization by instantly removing users' identities from key SaaS apps when they leave the organization.
- Easily importing a large number of users into a particular SaaS application or system.
- Having a single set of policies to determine who is provisioned and who can sign in to an app.

Azure AD user provisioning can help address these challenges.

## What applications and systems can I use with Azure AD automatic user provisioning?

Azure AD features pre-integrated support for many popular SaaS apps and human resources systems, and generic support for apps that implement specific parts of the SCIM 2.0 standard.

* **Pre-integrated applications (gallery SaaS apps)**: You can find all applications for which Azure AD supports a pre-integrated provisioning connector in Tutorials for integrating SaaS applications with Azure Active Directory. The pre-integrated applications listed in the gallery generally use SCIM 2.0-based user management APIs for provisioning.

* **Applications that support SCIM 2.0.**: You can use automatic user provisioning with applications that support SCIM 2.0.


## How do I set up automatic provisioning to an application?

For pre-integrated applications listed in the gallery, step-by-step guidance is available for setting up automatic provisioning. 

For other applications that support SCIM 2.0, you can follow guidance to configure user provisioning.

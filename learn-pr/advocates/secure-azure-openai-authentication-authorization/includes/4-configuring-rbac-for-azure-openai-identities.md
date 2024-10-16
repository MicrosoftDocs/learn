Assigning an RBAC (Role Based Access Control) role allows you to assign a set of preconfigured permissions to an identity. You can assign traditional identities such as Microsoft Entra users and groups to an RBAC role as well as special identities such managed identity. Best practice is to create a Microsoft Entra security group, assign the role to the group, and then add any identities that you want to assign these rights to as members of the group. This simplifies role management as you can quickly determine what permissions an identity has been assigned by reviewing group membership. It also helps in subscriptions with large numbers of identities and resources as there are limitations as to the number of role assignments you can configure.

There are four Azure OpenAI roles to which you can assign to identities: These roles are: Cognitive Services OpenAI User, Cognitive Services OpenAI Contributor, Cognitive Services Contributor, and Cognitive Services Usages Reader.

| Permissions | Cognitive Services OpenAI User | Cognitive Services OpenAI Contributor |Cognitive Services Contributor |  Cognitive Services Usages Reader |
|-------------|--------------------|------------------------|------------------|-------------------------|
|View the resource in Azure portal |✅|✅|✅| ➖ |
|View the resource endpoint under "Keys and Endpoint" |✅|✅|✅| ➖ |
|View the resource and associated model deployments in Azure OpenAI Studio |✅|✅|✅| ➖ |
|View what models are available for deployment in Azure OpenAI Studio|✅|✅|✅| ➖ |
|Use the Chat, Completions, and DALL-E (preview) playground experiences with any models that have already been deployed to this Azure OpenAI resource.|✅|✅|✅| ➖ |
|Create or edit model deployments|❌|✅|✅| ➖ |
|Create or deploy custom fine-tuned models|❌|✅|✅| ➖ |
|Upload datasets for fine-tuning|❌|✅|✅| ➖ |
|Create new Azure OpenAI resources|❌|❌|✅| ➖ |
|View/Copy/Regenerate keys under “Keys and Endpoint”|❌|❌|✅| ➖ |
|Create customized content filters|❌|❌|✅| ➖ |
|Add a data source for the “on your data” feature|❌|❌|✅| ➖ |
|Access quota|❌|❌|❌|✅|
|Make inference API calls with Microsoft Entra ID| ✅ | ✅ | ❌ |  ➖ |

## Cognitive Services OpenAI User

Identities assigned the Cognitive Services OpenAI User role are able to perform the following tasks:

- View the Azure OpenAI resource in the Azure portal
- View the Azure OpenAI resource endpoint under Keys and Endpoint
- View the Azure OpenAI resource and associated model deployments in Azure OpenAI Studio
- View what models are available for deployment in Azure OpenAI Studio
- Use the Chat, Completions, and Dali playground experiences to generate text and images with any models that have already been deployed to this Azure OpenAI resource
- Users that hold this role are also able to make inference API calls with Microsoft Entra ID

## Cognitive Services OpenAI Contributor

Identities assigned the Cognitive Services OpenAI Contributor role can perform all the tasks available to a user that holds the Cognitive Services OpenAI User role. They're also able to perform tasks including:

- Create custom fine-tuned models
- Upload datasets for fine-tuning 
- Create new model deployments
- Edit existing model deployments.

## Cognitive Services Contributor

The Cognitive Services Contributor role is typically granted access at the resource group level for a user in conjunction with additional roles. By itself this role would allow an identity to perform the following tasks:

- Create new Azure OpenAI resources within the assigned resource group
- View resources in the assigned resource group in the Azure portal
- View the resource endpoint under Keys and Endpoint
- View, Copy, and Regenerate keys under Keys and Endpoint
- Use the Chat, Completions, and Dali playground experiences to generate text and images with any models that have already been deployed to this Azure OpenAI resource
- Create customized content filters
- Add a data source for the use your data feature
- Create new model deployments or edit existing model deployments via API
- Create custom fine-tuned models, Upload datasets for fine-tuning
- Create new model deployments or edit existing model deployments via Azure OpenAI Studio

## Cognitive Services Usages Reader

The Cognitive Services Usages Reader role has the minimal access necessary to view quota usage across an Azure subscription. If you don't wish to use this role, the subscription Reader role provides equivalent access, but it also grants read access beyond the scope of what is needed for viewing quota.

When assigning roles to identities always remember the principle of least privilege rather than the principle of user convenience. If a person, application or service only requires the ability to perform the tasks of a minimally provisioned role, that is the role that you should assign to that identity. Also remember the best practice of assigning Microsoft Entra groups with meaningful names to a role and then controlling role membership by adding and removing users from those groups.

## Configuring role assignments in the Azure portal

To enable keyless authentication, follow these steps to configure the necessary role assignments:

- Select Azure OpenAI: Navigate to your specific Azure OpenAI resource within the Azure portal.
- Access Control: Select the Access Control (IAM) option from the left navigation pane.
- Add Role Assignment: Select Add role assignment, and on the subsequent screen, choose the Role tab.
- Select Role: Choose the desired role you wish to assign, such as Reader or Contributor.
- Members Tab: On the Members tab, select a user, group, service principal, or managed identity to assign the role.
- Review and Assign: On the Review + assign tab, confirm your selections and select Review + assign to finalize the role assignment.

Within a few minutes, the selected user or identity will be granted the assigned role at the chosen scope, enabling them to access Azure OpenAI services without needing an API key.
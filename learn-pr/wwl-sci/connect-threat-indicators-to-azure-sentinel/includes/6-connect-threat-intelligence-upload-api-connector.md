Your organization is using threat intelligence platform (TIP) solutions to aggregate threat intelligence feeds from various sources. The industry standard for describing cyberthreat information is called, "Structured Threat Information Expression" or STIX. By using the "Threat Intelligence Upload API" which supports STIX objects, your organization can ingest custom threat intelligence data into Microsoft Sentinel. The Threat Intelligence Upload API is installed as part of the Microsoft Sentinel Threat Intelligence solution, and managed like a data connector, but the upload API ingests threat intelligence into Microsoft Sentinel without the need for a data connector.

:::image type="content" source="../media/threat-intel-upload-api.png" alt-text="Screenshot that shows the threat intelligence import path.":::

> [!IMPORTANT]
> The Microsoft Sentinel threat intelligence upload API is in preview. See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for more legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

### Prerequisites

- You must have read and write permissions to the Microsoft Sentinel workspace to store your threat intelligence STIX objects.
- You must be able to register a Microsoft Entra application.
- Your Microsoft Entra application must be granted the Microsoft Sentinel Contributor role at the workspace level.

### Configuring the Threat Intelligence Upload API

## Instructions

Follow these steps to import threat intelligence STIX objects to Microsoft Sentinel from your integrated TIP or custom threat intelligence solution:

1. Register a Microsoft Entra application, and then record its application ID.
1. Generate and record a client secret for your Microsoft Entra application.
1. Assign your Microsoft Entra application the Microsoft Sentinel Contributor role or the equivalent.
1. Configure your TIP solution or custom application.

## Register a Microsoft Entra application

The [default user role permissions](../active-directory/fundamentals/users-default-permissions.md#restrict-member-users-default-permissions) allow users to create application registrations. If this setting was switched to **No**, you need permission to manage applications in Microsoft Entra. Any of the following Microsoft Entra roles include the required permissions:

- Application administrator
- Application developer
- Cloud application administrator

After you register your application, record its application (client) ID from the application's **Overview** tab.

## Assign a role to the application

The upload API ingests threat intelligence objects at the workspace level and requires the role of Microsoft Sentinel Contributor.

1. From the Azure portal, go to **Log Analytics workspaces**.
1. Select **Access control (IAM)**.
1. Select **Add** > **Add role assignment**.
1. On the **Role** tab, select the **Microsoft Sentinel Contributor** role, and then select **Next**.
1. On the **Members** tab, select **Assign access to** > **User, group, or service principal**.
1. Select members. By default, Microsoft Entra applications aren't displayed in the available options. To find your application, search for it by name.

    :::image type="content" source="..//media/assign-role.png" alt-text="Screenshot that shows the Microsoft Sentinel Contributor role assigned to the application at the workspace level.":::

1. Select **Review + assign**.

## Configure your threat intelligence platform solution or custom application

The following configuration information is required by the upload API:

- Application (client) ID
- Microsoft Entra access token with [OAuth 2.0 authentication](/active-directory/fundamentals/auth-oauth2)
- Microsoft Sentinel workspace ID

Enter these values in the configuration of your integrated TIP or custom solution where required.

1. Submit the threat intelligence to the upload API. For more information, see [Microsoft Sentinel upload API](/azure/sentinel/stix-objects-api).
1. Within a few minutes, threat intelligence objects should begin flowing into your Microsoft Sentinel workspace. Find the new STIX objects on the **Threat intelligence** page, which is accessible from the Microsoft Sentinel menu.

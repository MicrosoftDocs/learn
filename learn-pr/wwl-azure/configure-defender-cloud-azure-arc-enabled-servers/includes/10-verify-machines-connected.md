Verify the Azure Arc connection, Defender for Servers deployment, and Microsoft Defender portal access after you onboard a server.

## Verify the Azure Arc connection

Open **Azure Arc** > **Machines** in the Azure portal. Find the server and confirm that its status is **Connected**. Alternatively, run `azcmagent show` locally and confirm that **Agent Status** is **Connected**.

## Verify Defender for Servers coverage

Confirm that Defender for Cloud recognizes the server:

1. Sign in to the [Azure portal](https://portal.azure.com/).
2. Search for and select **Microsoft Defender for Cloud**.
3. On the Defender for Cloud menu, select **Inventory** to show the [asset inventory](/azure/defender-for-cloud/asset-inventory).
4. Filter the inventory by resource type to show Azure Arc-enabled servers, and confirm that the server appears.

After you enable Defender for Servers, Defender for Cloud automatically provisions the Microsoft Defender for Endpoint extension on supported machines. Provisioning can take up to 12 hours. To review the deployment, open the Azure Arc-enabled server resource, select **Extensions**, and verify that the Defender for Endpoint extension has a successful status.

If the server doesn't appear or the extension deployment fails, confirm that you enabled the **Servers** plan on the subscription that contains the Arc resource. Check the support matrix for the operating system, and confirm that the server can reach the required Azure Arc and Defender for Endpoint service URLs.

## Verify access in the Microsoft Defender portal

After you enable the required Defender plans, Defender for Cloud automatically integrates its alerts and incidents with the Microsoft Defender portal. Users need an appropriate Microsoft Defender XDR Unified RBAC role for Defender for Cloud. Without Unified RBAC, users need the Global Administrator or Security Administrator role in Microsoft Entra ID.

Customers with a paid Defender for Cloud plan can also prepare the full **Cloud security** experience:

1. Sign in to the [Microsoft Defender portal](https://security.microsoft.com/).
2. Select **Cloud security** > **Overview**.
3. Select **Prepare my tenant**.
4. Allow up to 24 hours for Defender for Cloud data to appear.

Continue to use the Azure portal to configure Defender plans and manage Azure Arc resources.

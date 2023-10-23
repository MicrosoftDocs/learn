In this unit, you see how to create a RemoteApp application group to share an application to a different user in the organization.

To complete the exercise, you'll need the credentials for a different non-administrative user account that's in Active Directory.

## Step 1: Basics

1.  Sign in to the Azure portal.
2.  Use the search box to find **Azure Virtual Desktop**.
3.  Select **Application groups &gt; Add**.
4.  Select the subscription, resource group, host pool, and application type.

:::image type="content" source="../media/create-an-application-group-d77b79df.png" alt-text="Screenshot showing the application groups basics tab filled out using values from table.":::


| **Field**              | **Description**                                                    |
| ---------------------- | ------------------------------------------------------------------ |
| Subscription           | Subscription where you want the app group to run.                  |
| Resource group         | Resource group you've created for Azure Virtual Desktop resources. |
| Host pool              | avd-host-pool-1                                                    |
| Application group type | RemoteApp                                                          |
| Application group name | RemoteApp1                                                         |

5.  Select **Next: Assignments**.

## Step 2: Assignments

1.  Select **Add Microsoft Entra users or user groups**.

:::image type="content" source="../media/create-application-group-users-groups-2c910498.png" alt-text="Screenshot showing the assignments tab with Add Microsoft Entra users or user groups highlighted.":::


2.  Select single or multiple users or you can select user groups.
3.  Select **Next: Applications**.

## Step 3: Applications

1.  Select **Add applications**.

:::image type="content" source="../media/create-application-group-add-applications-478c0c11.png" alt-text="Screenshot showing the applications tab with add applications highlighted.":::


2.  Use the information in the following table to help you add an application. Accept the rest of the default values where not listed in the table.

:::image type="content" source="../media/demo-configure-apps-users-image-4-053167b0.png" alt-text="Screenshot showng that WordPad is selected.":::


| **Field**          | **Value**  |
| ------------------ | ---------- |
| Application source | Start menu |
| Application        | WordPad    |
| Display name       | WordPad    |

3.  Select **Next: Workspace**.

## Step 4: Workspace

1.  For **Register application group**, select **Yes**.

:::image type="content" source="../media/demo-configure-apps-users-image-5-2438b37f.png" alt-text="Screenshot showing the workspace tab with yes selected.":::


2.  Select **Review + create**.
3.  Review what you've entered and select **Create**.

## Verify access to application

1.  Go to the [Azure Virtual Desktop web client](https://rdweb.wvd.microsoft.com/arm/webclient/index.html).
2.  Sign in by using the user credentials for the user you assigned to the RemoteApp application group.
3.  You should see the application in the workspace.

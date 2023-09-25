

In this module, you'll learn about the seven steps to initiate the use of Microsoft Defender for Cloud Apps.

Before proceeding with any other actions, it's essential to understand how to access the Microsoft Defender for Cloud Apps portal. Access to the portal is necessary for us to take advantage of the various features and functionalities offered by the tool. Therefore, it's imperative to follow the appropriate steps to access the portal before we can utilize Microsoft Defender for Cloud Apps to its fullest potential.

### To access the portal

To access the Defender for Cloud Apps portal, go to [https://portal.cloudappsecurity.com](https://portal.cloudappsecurity.com/). You can also access the portal through the [Microsoft 365 Defender portal](https://security.microsoft.com/), as follows:
- In the [Microsoft 365 Defender Portal](https://security.microsoft.com/), select **More resources**, and then select **Defender for Cloud Apps**.

:::image type="content" source="../media/access-from-o365-s2.png" alt-text="Screenshot of the Microsoft Defender for Cloud Apps page with access settings.":::

## Step 1. Set instant visibility, protection, and governance actions for your apps

How to page: [Set instant visibility, protection, and governance actions for your apps](/defender-cloud-apps/enable-instant-visibility-protection-and-governance-actions-for-your-apps)

Required task: Connect apps

1. From the settings cog, select App connectors.
1. Select the plus sign (+) to add an app and select an app.
1. Follow the configuration steps to connect the app.

Why connect an app? After you connect an app, you can gain deeper visibility so you can investigate activities, files, and accounts for the apps in your cloud environment.

## Step 2. Protect sensitive information with DLP policies
How to page: [Protect sensitive information with DLP policies](/defender-cloud-apps/policies-information-protection)
Recommended task: Enable file monitoring and create file policies

1. Go to **Settings**, and then under **Information Protection**, select **Files**.
1. Select **Enable file monitoring** and then select **Save**.
1. If you use sensitivity labels from Microsoft Purview Information Protection, under **Information Protection**, select **Microsoft Information Protection**.
1. Select the required settings and then select **Save**.
1. In **Step 3**, create [File policies](/defender-cloud-apps/data-protection-policies) to meet your organizational requirements.

> [!TIP]
> You can view files from your connected apps by browsing to **Investigate** > **Files**.
### Migration recommendation
We recommend using Defender for Cloud Apps sensitive information protection in parallel with your current Cloud Access Security Broker (CASB) solution. Start by connecting the apps you want to protect to Microsoft Defender for Cloud Apps. Since API connectors use out-of-band connectivity, no conflict will occur. Then progressively migrate your policies from your current CASB solution to Defender for Cloud Apps.

> [!NOTE]
> For third-party apps, verify that the current load does not exceed the app's maximum number of allowed API calls.

## Step 3. Control cloud apps with policies
How to page: [Control cloud apps with policies](/defender-cloud-apps/control-cloud-apps-with-policies)

Required task: Create policies  

## To create policies
1. Go to **Control** > **Templates**.
1. Select a policy template from the list, and then choose (+) **Create policy**.
1. Customize the policy (select filters, actions, and other settings), and then choose **Create**.
1. On the **Policies** tab, choose the policy to see the relevant matches (activities, files, alerts).

> [!TIP]
> To cover all your cloud environment security scenarios, create a policy for each **risk category**.

## How can policies help your organization?
Policies enable you to track trends, identify security threats, and generate tailored reports and alerts. By implementing policies, you can establish governance actions and configure data loss prevention measures and file-sharing controls.

## Step 4. Set up Cloud Discovery
How to page: [Set up Cloud Discovery](/defender-cloud-apps/set-up-cloud-discovery)

Required task: Enable Defender for Cloud Apps to view your cloud app use.

1. [Integrate with Microsoft Defender for Endpoint](/defender-cloud-apps/mde-integration) to automatically enable Defender for Cloud Apps to monitor your Windows 10 and Windows 11 devices inside and outside your corporation.
1. If you use [Zscaler, integrate](/defender-cloud-apps/zscaler-integration) it with Defender for Cloud Apps.
1. To achieve full coverage, create a continuous Cloud Discovery report.
    1. From the settings cog, select Settings.
    1. Under Cloud Discovery, choose Automatic log upload.
    1. On the Data sources tab, add your sources.
    1. On the Log collectors tab, configure the log collector.

### Migration recommendation
We recommend using Defender for Cloud Apps discovery in parallel with your current CASB solution. Start by configuring automatic firewall log upload to Defender for Cloud Apps [log collectors](/defender-cloud-apps/discovery-docker). If you use Defender for Endpoint, in Microsoft 365 Defender, make sure you [turn on the option](/defender-cloud-apps/mde-integration#how-to-integrate-microsoft-defender-for-endpoint-with-defender-for-cloud-apps) to forward signals to Defender for Cloud Apps. Configuring Cloud Discovery won't conflict with the log collection of your current CASB solution.
### To create a snapshot Cloud Discovery report

Go to **Discover** > **Create snapshot report** and follow the steps shown.
### Why should you configure Cloud Discovery reports?

Having visibility into shadow IT in your organization is critical. After your logs are analyzed, you can easily find which cloud apps are being used, by which people, and on which devices.

## Step 5. Deploy Conditional Access App Control for catalog apps
How to page: [Deploy Conditional Access App Control for catalog apps](/defender-cloud-apps/proxy-deployment-aad)

Recommended task: Deploy Conditional Access App Control for catalog apps.

1. Configure your IdP to work with Defender for Cloud Apps. If you have Azure AD, you can use inline controls such as Monitor only and Block downloads, which will work for any catalog app out of the box.
1. Onboard apps onto access and session controls.
    1. Onboard apps onto access and session controls.
    1. Sign in to each app using a user scoped to the policy.
    1. Refresh the Conditional Access App Control page and to view the app.
1. Verify the apps are configured to use access and session controls.

To configure session controls for custom line-of-business apps, non-featured SaaS apps, and on-premises apps, see [Deploy Conditional Access App Control for custom apps using Azure Active Directory](/defender-cloud-apps/proxy-deployment-any-app).

### Migration recommendation
Using Conditional Access App Control in parallel with another CASB solution can potentially lead to an app being proxied twice, causing latency or other errors. Therefore, we recommended progressively migrating apps and policies to Conditional Access App Control, creating the relevant session or access policies in Defender for Cloud Apps as you go.

## Step 6. Personalize your experience
How to page: [Personalize your experience](/defender-cloud-apps/mail-settings)

Recommended task: Add your organization details

## To enter email settings
1. From the settings cog, select Mail settings.
1. Under **Email sender identity**, enter your organization's email address and display name.
1. Under **Email design**, upload your organization's email template.

## To set admin notifications
1. in the navigation bar, choose your user name and then go to **User settings**.
1. Under **Notifications**, configure the method of notification you want to receive.
1. Choose **Save**.

## To customize the score metrics
1. From the settings cog, select **Settings**.
1. Under **Cloud Discovery**, select **Score metrics**.
1. Configure the importance of various risk values.
1. Choose **Save**.

Now the risk scores given to discovered apps are configured precisely according to your organization needs and priorities.

## Why should you personalize your environment?
Some features work best when they're customized to your needs. Provide a better experience for your users with your own email templates. Decide what notifications you receive and customize your risk score metric to fit your organization's preferences.

## Step 7. Organize the data according to your needs
How to page: [Working with ip ranges and tags](/defender-cloud-apps/ip-tags)

Recommended task: Configure important settings

## To create ip address tags
1. From the settings cog, select **Settings**.
1. Under **Cloud Discovery**, choose **Continuous reports**.
1. Choose **Create report**.
1. Follow the configuration steps.
1. Choose **Create**.

Now you can view discovered data based on your own preferences, such as business units or IP ranges.

## To add domains
1. From the settings cog, select **Settings**.
1. Under **System**, choose **Organizations details**.
1. Add your organization's domains.
1. Choose **Save**.

## Why should you configure these settings?
These settings help give you better control of features in the console. With IP tags, it's easier to create policies that fit your needs, to accurately filter data, and more. Use Data views to group your data into logical categories.

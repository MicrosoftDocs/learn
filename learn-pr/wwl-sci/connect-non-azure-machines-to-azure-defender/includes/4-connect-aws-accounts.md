Onboarding your Amazon Web Services (AWS) account into Microsoft Defender for Cloud, integrates AWS Security Hub and Defender for Cloud. Defender for Cloud thus provides visibility and protection across both of these cloud environments to provide:

- Automatic agent provisioning (Defender for Cloud uses Azure Arc to deploy the Connected Machine agent to your AWS instances)

- Policy management

- Vulnerability management

- Embedded Endpoint Detection and Response (EDR)

- Detection of security misconfigurations

- A single view showing Defender for Cloud recommendations and AWS Security Hub findings

- Incorporation of your AWS resources into Defender for Cloud's secure score calculations

- Regulatory compliance assessments of your AWS resources

In the screenshot below, you can see AWS accounts displayed in Defender for Cloud's overview dashboard.

:::image type="content" source="../media/aws-account-in-overview.png" alt-text="Screenshot of the A W S account overview settings.":::

You can learn more by watching the [New AWS connector in Defender for Cloud](/azure/defender-for-cloud/episode-one) video from the *Defender for Cloud in the Field* video series.

## Prerequisites

- A Microsoft Azure subscription. If you don't have an Azure subscription, you can [sign up for a free one](https://azure.microsoft.com/pricing/free-trial/).

- Microsoft Defender for Cloud set up on your Azure subscription.

- Access to an AWS account.

- Contributor level permission for the relevant Azure subscription.

## Native connector plans

Each plan has its own requirements for the native connector.

- Microsoft Defender for Containers
- Microsoft Defender for SQL
- Defender for open-source relational database
- Microsoft Defender for Servers
- Microsoft Defender CSPM

## Follow the steps below to create your AWS cloud connector

> [!IMPORTANT]
> If your AWS account is already connected to Microsoft Sentinel, you can't connect it to Defender for Cloud. To ensure the connector works correctly, follow the instructions on [Connect a Microsoft Sentinel connected AWS account to Defender for Cloud](/azure/defender-for-cloud/sentinel-connected-aws).

To connect your AWS to Defender for Cloud by using a native connector:

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Go to **Defender for Cloud** > **Environment settings**.

1. Select **Add environment** > **Amazon Web Services**.

    :::image type="content" source="../media/add-aws-account-environment-settings.png" alt-text="Screenshot that shows connecting an AWS account to an Azure subscription." lightbox="media/quickstart-onboard-aws/add-aws-account-environment-settings.png":::

1. Enter the details of the AWS account, including the location where you store the connector resource.

    :::image type="content" source="../media/add-aws-account-details.png" alt-text="Screenshot that shows the tab for entering account details for an AWS account." lightbox="media/quickstart-onboard-aws/add-aws-account-details.png":::

    The **AWS regions** dropdown allows you to select the regions to which Defender for Cloud makes API calls. Every region that is deselected from the dropdown, implies that Defender for Cloud won’t make API calls to those regions.

1. Select an interval to scan the AWS environment every 4, 6, 12, or 24 hours.

    > [!NOTE]
    > (Optional) Select **Management account** to create a connector to a management account. Connectors are then created for each member account discovered under the provided management account. Autoprovisioning is also enabled for all of the newly onboarded accounts.
    >
    > (Optional) Use the AWS regions dropdown menu to select specific AWS regions to be scanned. All regions are selected by default.

## Select Defender plans

In this section of the wizard, you select the Defender for Cloud plans that you want to enable.

1. Select **Next: Select plans**.

    The **Select plans** tab is where you choose which Defender for Cloud capabilities to enable for this AWS account. Each plan has its own requirements for permissions and might incur [charges](https://azure.microsoft.com/pricing/details/defender-for-cloud/?v=17.23h).

    :::image type="content" source="../media/add-aws-account-plans-selection.png" alt-text="Screenshot that shows the tab for selecting plans for an AWS account." lightbox="../media/add-aws-account-plans-selection.png":::

    > [!IMPORTANT]
    > To present the current status of your recommendations, the Microsoft Defender Cloud Security Posture Management plan queries the AWS resource APIs several times a day. These read-only API calls incur no charges, but they're registered in CloudTrail if you enable a trail for read events. The AWS documentation explains that there are no extra charges for keeping one trail. If you're exporting the data out of AWS (for example, to an external SIEM system), this increased volume of calls might also increase ingestion costs. In such cases, we recommend filtering out the read-only calls from the Defender for Cloud user or ARN role: `arn:aws:iam::[accountId]:role/CspmMonitorAws`. (This is the default role name. Confirm the role name configured on your account.)

1. By default, the **Servers** plan is set to **On**. This setting is necessary to extend the coverage of Defender for Servers to AWS EC2. Ensure that you fulfilled the [network requirements for Azure Arc](/azure/azure-arc/servers/network-requirements?tabs=azure-cloud).

    Optionally, select **Configure** to edit the configuration as required.

    > [!NOTE]
    > The respective Azure Arc servers for EC2 instances or GCP virtual machines that no longer exist (and the respective Azure Arc servers with a status of [Disconnected or Expired](/azure/azure-arc/servers/overview)) are removed after seven days. This process removes irrelevant Azure Arc entities to ensure that only Azure Arc servers related to existing instances are displayed.

1. By default, the **Containers** plan is set to **On**. This setting is necessary to have Defender for Containers protect your AWS EKS clusters. Ensure that you fulfilled the network requirements for the Defender for Containers plan.

    > [!NOTE]
    > Azure Arc-enabled Kubernetes, the Azure Arc extensions for Defender sensor, and Azure Policy for Kubernetes should be installed. Use the dedicated Defender for Cloud recommendations to deploy the extensions (and Azure Arc, if necessary), as explained in Protect Amazon Elastic Kubernetes Service clusters.

    Optionally, select **Configure** to edit the configuration as required. If you choose to turn off this configuration, the **Threat detection (control plane)** feature is also disabled.

1. By default, the **Databases** plan is set to **On**. This setting is necessary to extend coverage of Defender for SQL to AWS EC2 and RDS Custom for SQL Server and open-source relational databases on RDS.

    (Optional) Select **Configure** to edit the configuration as required. We recommend that you leave it set to the default configuration.

1. Select **Configure access** and select the following:

    a. Select a deployment type:

    - **Default access**: Allows Defender for Cloud to scan your resources and automatically include future capabilities.
    - **Least privilege access**: Grants Defender for Cloud access only to the current permissions needed for the selected plans. If you select the least privileged permissions, you receive notifications on any new roles and permissions that are required to get full functionality for connector health.

    b. Select a deployment method: **AWS CloudFormation** or **Terraform**.

    :::image type="content" source="../media/add-aws-account-configure-access.png" alt-text="Screenshot that shows deployment options and instructions for configuring access." lightbox="../media/add-aws-account-configure-access.png":::

    > [!NOTE]
    > If you select **Management account** to create a connector to a management account, then the tab to onboard with Terraform isn't visible in the UI, but you can still onboard using Terraform, similar to what's covered at [Onboarding your AWS/GCP environment to Microsoft Defender for Cloud with Terraform - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/microsoft-defender-for-cloud/onboarding-your-aws-gcp-environment-to-microsoft-defender-for/ba-p/3798664).

1. Follow the on-screen instructions for the selected deployment method to complete the required dependencies on AWS. If you're onboarding a management account, you need to run the CloudFormation template both as Stack and as StackSet. Connectors are created for the member accounts up to 24 hours after the onboarding.

1. Select **Next: Review and generate**.

1. Select **Create**.

Defender for Cloud immediately starts scanning your AWS resources. Security recommendations appear within a few hours.

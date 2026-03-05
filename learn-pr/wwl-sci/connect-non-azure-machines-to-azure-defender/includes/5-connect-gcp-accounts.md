Onboarding your workloads in Google Cloud Platform (GCP) account into Microsoft Defender for Cloud, integrates GCP Security Command and Defender for Cloud. Defender for Cloud thus provides visibility and protection across both of these cloud environments to provide:

- Detection of security misconfigurations

- A single view showing Defender for Cloud recommendations and GCP Security Command Center findings

- Incorporation of your GCP resources into Defender for Cloud's secure score calculations

- Integration of GCP Security Command Center recommendations based on the CIS standard into the Defender for Cloud's regulatory compliance dashboard

In the screenshot below, you can see GCP projects displayed in Defender for Cloud's overview dashboard.

:::image type="content" source="../media/gcp-account-in-overview.png" alt-text="Screenshot of the G C P project overview settings." lightbox="../media/gcp-account-in-overview.png":::

## Prerequisites

- A Microsoft Azure subscription. If you don't have an Azure subscription, you can [sign up for a free one](https://azure.microsoft.com/pricing/free-trial/).

- Microsoft Defender for Cloud  set up on your Azure subscription.

- Access to a GCP project.

- Contributor level permission for the relevant Azure subscription.

- If CIEM is enabled as part of Defender for CSPM the user enabling the connector will also need Security Admin role and Application.ReadWrite.All permission for your tenant.

You can learn more about Defender for Cloud pricing on [the pricing page](https://azure.microsoft.com/pricing/details/defender-for-cloud/).

When you're connecting GCP projects to specific Azure subscriptions, consider the [Google Cloud resource hierarchy](https://cloud.google.com/resource-manager/docs/cloud-platform-resource-hierarchy#resource-hierarchy-detail) and these guidelines:

- You can connect your GCP projects to Microsoft Defender for Cloud at the *project* level.
- You can connect multiple projects to one Azure subscription.
- You can connect multiple projects to multiple Azure subscriptions.

## Follow the steps below to connect your GCP project

There are four parts to the onboarding process that take place when you create the security connection between your GCP project and Microsoft Defender for Cloud.

### Project details

In the first section, you need to add the basic properties of the connection between your GCP project and Defender for Cloud.

:::image type="content" source="../media/single-project-details.png" alt-text="Screenshot of the organization details page of the GCP project onboarding process." lightbox="../media/single-project-details.png":::

Here you name your connector, select a subscription and resource group, which is used to create an ARM template resource that is called security connector. The security connector represents a configuration resource that holds the projects settings.

You also select a location and add the organization ID for your project.

You can also set an interval to scan the GCP environment every 4, 6, 12, or 24 hours.

When you onboard an organization, you can also choose to exclude project numbers and folder IDs.

### Select plans for your project

After entering your organization's details, you'll then be able to select which plans to enable.

:::image type="content" source="../media/select-plans-gcp-project.png" alt-text="Screenshot of the available plans you can enable for your GCP project." lightbox="../media/select-plans-gcp-project.png":::

From here, you can decide which resources you want to protect based on the security value you want to receive.

### Configure access for your project

Once you selected the plans, you want to enable and the resources you want to protect you have to configure access between Defender for Cloud and your GCP project.

:::image type="content" source="../media/add-gcp-project-configure-access.png" alt-text="Screenshot that shows deployment options and instructions for configuring access.":::

In this step, you can find the GCloud script that needs to be run on the GCP project that is going to onboarded. The GCloud script is generated based on the plans you selected to onboard.

The GCloud script creates all of the required resources on your GCP environment so that Defender for Cloud can operate and provide the following security values:

- Workload identity pool
- Workload identity provider (per plan)
- Service accounts
- Project level policy bindings (service account has access only to the specific project)

### Review and generate the connector for your project

The final step for onboarding is to review all of your selections and to create the connector.

:::image type="content" source="../media/review-and-generate.png" alt-text="Screenshot of the review and generate screen with all of your selections listed." lightbox="../media/review-and-generate.png":::

> [!NOTE]
> The following APIs must be enabled in order to discover your GCP resources and allow the authentication process to occur:
>
> - `iam.googleapis.com`
> - `sts.googleapis.com`
> - `cloudresourcemanager.googleapis.com`
> - `iamcredentials.googleapis.com`
> - `compute.googleapis.com`
> If you don't enable these APIs at this time, you can enable them during the onboarding process by running the GCloud script.

After you create the connector, a scan starts on your GCP environment. New recommendations appear in Defender for Cloud after up to 6 hours. If you enabled autoprovisioning, Azure Arc and any enabled extensions are installed automatically for each newly detected resource.

## Connect your GCP organization

Similar to onboarding a single project, When onboarding a GCP organization, Defender for Cloud creates a security connector for each project under the organization (unless specific projects were excluded). For more information about connecting your GCP organization, see the [GCP organization onboarding documentation](/azure/defender-for-cloud/quickstart-onboard-gcp#connect-your-gcp-organization).

## Optional: Configure selected plans

By default, all plans are **On**. You can turn off plans that you don't need.

:::image type="content" source="../media/toggle-plans-to-on.png" alt-text="Screenshot that shows toggles turned on for all plans." lightbox="../media/toggle-plans-to-on.png":::

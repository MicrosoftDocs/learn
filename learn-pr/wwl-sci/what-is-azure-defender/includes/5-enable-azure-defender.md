Enable Microsoft Defender for Cloud in the Azure portal and onboard subscriptions and workspaces.

## Prerequisites

To get started with Defender for Cloud, you must have a subscription to Microsoft Azure. If you do not have a subscription, you can sign up for a free account.   To enable Microsoft Defender for Cloud on a subscription, you must be assigned the role of Subscription Owner, Subscription Contributor, or Security Admin.

## Enable Microsoft Defender for Cloud

To start Microsoft Defender for Cloud:

1. Sign in to the Azure portal.

1. From the portal's menu, select **Defender for Cloud**.

The Defender for Cloud's overview page opens.

:::image type="content" source="../media/overview.png" alt-text="Defender for Cloud Overview." lightbox="../media/overview.png":::

Defender for Cloud – Overview provides a unified view into the security posture of your hybrid cloud workloads, enabling you to discover and assess the security of your workloads and identify and mitigate risk. Defender for Cloud automatically, at no cost, enables any of your Azure subscriptions not previously onboarded by you or another subscription user.

You can view and filter the list of subscriptions by selecting the Subscriptions menu item. Defender for Cloud will adjust the display to reflect the security posture of the selected subscriptions.

**Within minutes of launching Defender for Cloud the first time, you might see:**

- Recommendations for ways to improve the security of your connected resources.

- An inventory of your resources that are now being assessed by Defender for Cloud, along with the security posture of each.

To take full advantage of Defender for Cloud, you need to complete the steps below to enable Microsoft Defender for Cloud and install the Log Analytics agent.

## Onboard subscriptions or workspaces to Defender for Cloud

From Defender for Cloud's sidebar, select Getting started:

:::image type="content" source="../media/get-started-upgrade-tab.png" alt-text="Defender for Cloud Getting Started page.":::

The Upgrade tab lists subscriptions and workspaces eligible for onboarding. To upgrade a workspace do the following:

1. From the Select workspaces to enable Microsoft Defender for Cloud on list, select the workspaces to upgrade.

    - If you select subscriptions and workspaces that aren't eligible for trial, the next step will upgrade them, and charges will begin.

    - If you select a workspace that's eligible for a free trial, the next step will begin a trial.

1. Select **Upgrade** to enable Microsoft Defender for Cloud.

You can protect an entire Azure subscription with Microsoft Defender for Cloud, and all resources will inherit the protections within the subscription.

Below is the pricing page for an example subscription. You'll notice that each plan in Microsoft Defender for Cloud is priced separately and can be individually set to on or off.

:::image type="content" source="../media/defender-plans.png" alt-text="Microsoft Defender plans." lightbox="../media/defender-plans.png":::

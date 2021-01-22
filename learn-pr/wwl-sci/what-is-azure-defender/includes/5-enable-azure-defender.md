To enable Azure Defender, you first enable Azure Security Center, then Azure Defender, and finally configure your coverage type.

## Prerequisites

To get started with Security Center, you must have a subscription to Microsoft Azure. If you do not have a subscription, you can sign up for a free account.   To enable Azure Defender on a subscription, you must be assigned the role of Subscription Owner, Subscription Contributor, or Security Admin.

## Azure Security Center

To start Azure Security Center:

1. Sign in to the Azure portal.

1. From the portal's menu, select **Security Center**.

The Security Center's overview page opens.

:::image type="content" source="../media/overview.png" alt-text="Security Center Overview.":::

Security Center – Overview provides a unified view into the security posture of your hybrid cloud workloads, enabling you to discover and assess the security of your workloads and identify and mitigate risk. Security Center automatically, at no cost, enables any of your Azure subscriptions not previously onboarded by you or another subscription user.

You can view and filter the list of subscriptions by selecting the Subscriptions menu item. Security Center will adjust the display to reflect the security posture of the selected subscriptions.

**Within minutes of launching Security Center the first time, you might see:**

- Recommendations for ways to improve the security of your connected resources.

- An inventory of your resources that are now being assessed by Security Center, along with the security posture of each.

To take full advantage of Security Center, you need to complete the steps below to enable Azure Defender and install the Log Analytics agent.

## Azure Defender

From Security Center's sidebar, select Getting started:

:::image type="content" source="../media/get-started-upgrade-tab.png" alt-text="Security Center Getting Started page.":::

The Upgrade tab lists subscriptions and workspaces eligible for onboarding. To upgrade a workspace do the following:

1. From the Select workspaces to enable Azure Defender on list, select the workspaces to upgrade.

    - If you select subscriptions and workspaces that aren't eligible for trial, the next step will upgrade them, and charges will begin.

    - If you select a workspace that's eligible for a free trial, the next step will begin a trial.

1. Select **Upgrade** to enable Azure Defender.

You can protect an entire Azure subscription with Azure Defender, and all resources will inherit the protections within the subscription.

Below is the pricing page for an example subscription. You'll notice that each plan in Azure Defender is priced separately and can be individually set to on or off.

:::image type="content" source="../media/defender-plans.png" alt-text="Azure Defender Plans.":::


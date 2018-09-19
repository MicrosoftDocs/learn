In the previous exercise, we enabled trial licenses, created a directory, created a user, and created a group to test our solution. In this unit, we will create our conditional access rule to require Azure Multi-Factor Authentication for the Azure portal.

## Enable conditional access-based Multi-Factor Authentication

Conditional access allows administrators to configure when they do or do not want something to happen. They can use multiple rules in parallel to grant or deny access to resources. Here's the rule that we need to create:

**When accessing the Azure portal - Require multi-factor authentication**

The steps that follow will walk you through the process to create a conditional access rule to require users to perform multi-factor authentication when they access the Azure portal.

1. Browse to **Azure Active Directory** > **Conditional access**.

1. Click **New policy**.

1. Name the policy **Require MFA for Azure portal**.

1. Under **Assignments** > **Users and groups**, select **Users and groups**. Select the group that we created **CA-MFA-AzurePortal**. and click **Done**.

1. Under **Cloud apps** > **Select apps**, select **Microsoft Azure Management**.

1. Under **Access controls** > **Grant**, select **Require multi-factor authentication**.

1. Set **Enable policy** to **On**.

1. Click **Create**.

In this unit, you learned how to create a conditional access rule. The rule requires Multi-Factor Authentication when accessing the Azure portal.
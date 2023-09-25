
This guided project consists of the four exercises:

- Exercise 1: Deploy Log Analytics
- Exercise 2: Monitor web apps
- Exercise 3: Configure monitoring for compute services
- **Exercise 4: Configure alerts**

In Exercise 4, you configure two specific alerts: an action group to send an email, and an alert for virtual machine CPU utilization.

- Task 1: Create an action group to send an email
- Task 2: Create an alert for virtual machine CPU utilization

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::
](https://microsoftlearning.github.io/APL-1004-deploy-configure-azure-monitor/Instructions/Labs/LAB_05_exercise_configure_alerts.html)


## Exercise instructions

**Task 1: Create an action group to send an email**

1. In the Azure Portal Search Bar, enter **Monitor** and select **Monitor** from the list of results.
1. Select **Alerts** in the navigation menu.
1. Choose **Action Groups**.
1. On the **Action Groups** page, choose **Create**.
1. On the **Basics** page of the Create Action Group wizard, configure the following settings and choose **Next**.

    | Property | Value    |
    |:---------|:---------|
    | Subscription  | Your subscription   |
    | Resource Group  | rg-alpha   |
    | Region	| Global  |
    | Action group name	| NotifyCPU  |
    | Display Name	| NotifyCPU  |

6. On the **Notifications** page, set the notification type to **Email/SMS message/Push/Voice** and the Name to **NotificationEmail**. Choose the **Edit** (pencil) icon.
1. On the Email/SMS message/Push/Voice enable the **email** checkbox and enter the address **prime@fabrikam.com**. Choose **OK**. 
1. Choose **Review and Create**. Choose **Create**.


**Task 2: Create an alert for virtual machine CPU utilization**

1. In the Azure Portal Search Bar, enter **rg-alpha** and select **rg-alpha** from the list of results.
1. From the list of items in the resource group, choose **Linux-VM2**.
1. On the **Linux-VM2 properties** page, choose **Alerts** under **Monitoring**.
1. On the **Alerts** page, choose **Create** and then choose **Alert rule**.
1. On the **Condition** page of the Create an Alert Rule wizard, set the Signal name to **Percentage CPU**. Use the default settings and choose **Next**.
1. On the **Actions** page, choose **Select Action Group**.
1. On the **Select Action Groups** page, choose **NotifyCPU** and choose **Select**.
1. On the **Details** page enter the Alert rule name **HighCPU**. Choose **Review and Create** and then choose **Create**.

## Clean up subscription

To clean up the subscription, delete resource group **rg-alpha** and delete the **App Log Examiners** security group.
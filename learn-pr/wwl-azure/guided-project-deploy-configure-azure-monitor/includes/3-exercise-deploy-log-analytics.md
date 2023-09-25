
This guided project consists of the four exercises:

- **Exercise 1: Deploy Log Analytics**
- Exercise 2: Monitor web apps
- Exercise 3: Configure monitoring for compute services
- Exercise 4: Configure alerts

In Exercise 1, you deploy and configure a Log Analytics workspace

- Task 1: Create a Log Analytics workspace
- Task 2: Configure Log Analytics data retention and archive policies
- Task 3: Enable access to a Log Analytics workspace

Launch the exercise and follow the instructions. When you're done, be sure to return to this page so you can continue learning.

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::
](https://microsoftlearning.github.io/APL-1004-deploy-configure-azure-monitor/Instructions/Labs/LAB_02_exercise_deploy_log_analytics.html)

## Skilling tasks

- Create a Log Analytics workspace
- Configure Log Analytics data retention and archive policies
- Enable access to a Log Analytics workspace

## Exercise instructions

### Create a Log Analytics workspace

- In the Azure Portal Search Bar, enter **Log Analytics** and select **Log Analytics workspaces** from the list of results.
- On the **Log Analytics workspaces** page, choose **Create**.
- On the **Basics** page of the Create Log Analytics workspace wizard, provide the following information and choose **Review + Create**.

    | Property | Value    |
    |:---------|:---------|
    | Subscription  | Your subscription   |
    | Resource Group	| rg-alpha  |
    | Name	| LogAnalytics1  |
    | Region	| East US  |

4. Review the information and choose **Create**.

### Configure Log Analytics data retention and archive policies

1. In the Azure Portal Search Bar, enter **Log Analytics** and select **Log Analytics workspaces** from the list of results.
1. On the **Log Analytics workspaces** page, choose **LogAnalytics1**.
1. On the **Log Analytics workspace** page for LogAnalytics1, choose **Usage and estimated costs**.
1. Select **Data Retention** and set the slider to 60 days. Choose **OK**.
1. On the **Log Analytics workspace** page for LogAnalytics1, choose **Usage and estimated costs**.
1. Select **Daily cap**. Choose **On**. Set the daily cap to 10 GB and choose **OK**.

### Enable access to a Log Analytics workspace

1. In the Azure Portal Search Bar, enter **Log Analytics** and select **Log Analytics workspaces** from the list of results.
1. On the **Log Analytics workspaces** page, choose **LogAnalytics1**.
1. Select **Access control (IAM)**.
1. Choose **Add** and then choose **Add role assignment**.
1. On the list of roles, select **Log Analytics Reader** and choose **Next**.
1. On the **Members** page, choose **Select Members** and choose the App Log Examiners security group. **Choose Select**.
1. On the **Members** space, choose **Review + Assign**.

This guided project consists of the four exercises:

- Exercise 1: Deploy Log Analytics
- **Exercise 2: Monitor web apps**
- Exercise 3: Configure monitoring for compute services
- Exercise 4: Configure alerts

In Exercise 2, you configure monitoring for web applications.

- Task 1: Enable Application Insights
- Task 2: Disable logging for .NET core snapshot debugger
- Task 3: Configure web app HTTP logs to be written to a Log Analytics workspace
- Task 4: Configure SQL Insights data to be written to a Log Analytics workspace
- Task 5: Enable file and configuration change tracking for web apps

Launch the exercise and follow the instructions. When you're done, be sure to return to this page so you can continue learning.

> [!NOTE]
> To complete this lab you will need an [Azure subscription](https://azure.microsoft.com/free/).

[:::image type="content" source="../media/launch-exercise-button.png" alt-text="Button to launch exercise.":::
](https://microsoftlearning.github.io/APL-1004-deploy-configure-azure-monitor/Instructions/Labs/LAB_03_exercise_monitor_web_apps.html)

## Skilling tasks

- Enable Application Insights
- Disable logging for .NET core snapshot debugger
- Configure web app HTTP logs to be written to a Log Analytics workspace
- Configure SQL Insights data to be written to a Log Analytics workspace
- Enable file and configuration change tracking for web apps

## Exercise instructions

### Enable Application Insights

1. In the Azure Portal Search Bar, enter **rg-alpha** and select **rg-alpha** from the list of results.
1. From the list of items in the resource group, choose **App Services for the Web App with an SQL Database**.
1. Under **Settings** choose **Application Insights**.
1. On the **Application Insights** page, choose **Turn On Application Insights**.
1. On the **Application Insights** page, ensure that **Create a new resource** is selected and that the Log Analytics Workspace is set to **LogAnalytics1** and choose **Apply**.
1. On the **Apply monitoring settings** dialog, choose **Yes**.

### Disable logging for .NET core snapshot debugger

1. In the Azure Portal Search Bar, enter **rg-alpha** and select **rg-alpha** from the list of results.
1. From the list of items in the resource group, choose **App Services for the Web App with an SQL Database**.
1. Under **Settings** choose **Application Insights**.
1. Under **Instrument your application**, choose **.NET Core** and then set the Snapshot Debugger setting to **Off**. Choose **Apply**.
1. On the **Apply Monitoring Settings** dialog box, choose **Yes**.

    | Property | Value    |
    |:---------|:---------|
    | Diagnostic setting name  | httplogs   |
    | Categories	| HTTP logs  |
    | Destination details	| Send to Log Analytics workspace  |
    | Subscription	| Your subscription  |
    | Log Analytics workspace 	| LogAnalytics1   |

### Configure SQL Insights data to be written to a Log Analytics workspace

1. In the Azure Portal Search Bar, enter **rg-alpha** and select **rg-alpha** from the list of results.
1. From the list of items in the resource group, choose the sample SQL database.
1. Under **Monitoring**, choose **Diagnostic settings**.
1. On the **Diagnostic settings** page, choose **Add diagnostic setting**.
1. On the **Diagnostic setting page**, provide the following information and choose **Save**.

    | Property | Value    |
    |:---------|:---------|
    | Diagnostic setting name  | InsightLogAnalytics   |
    | Categories	| SQL Insights  |
    | Destination details	| Send to Log Analytics workspace  |
    | Subscription	| Your subscription  |
    | Log Analytics workspace 	| LogAnalytics1   |

### Enable file and configuration change tracking for web apps

1. In the Azure Portal Search Bar, enter **rg-alpha** and select **rg-alpha** from the list of results.
1. From the list of items in the resource group, choose the AzureLinuxAppWXYZ-webapp.
1. Choose **Diagnose and Solve Problems**.
1. In the search dialog box, type **Application Changes**.
1. On the **Change Analysis** page, choose **Configure**.
1. On the **Enable file and configuration change tracking** page, change the Status slider to **On** and then choose **Save**.
In this exercise, you'll confirm Advanced data security (ADS) is enabled, and you'll explore some of the features within each of the capabilities mentioned in the previous unit.  

## Configure Advanced data security

1. In the Azure portal, navigate to your Azure SQL Database logical server.

    > [!div class="nextstepaction"]
    > [Azure Portal](https://portal.azure.com/learn.docs.microsoft.com/?azure-portal=true)

1. In the left-hand menu, under Security, select **Advanced data security**. ADS should already be enabled, however if it is not, select **ON** and select **Save**.

1. In this step, you'll review the selections you've made for your Azure SQL Database logical server. In the same pane as the previous step (**Azure SQL Database logical server > Security > Advanced data security**), you will also see information regarding Vulnerability Assessments and Advanced Threat Protection.  

    This storage account was deployed as part of the deployment script for your Azure SQL Database. Review the options and add your email address if you want to receive the results of the recurring scan (weekly).  

1. You can also configure your Advanced Threat Protection (ATP) settings. To check the ATP alert types available, select **All** under Advanced Threat Protection types.  

    :::image type="content" source="../media/8-advanced-threat-protection-types.png" alt-text="Screenshot of the types of protection in ATP.":::  

1. Just like you can configure who receives the VA scans, you can configure who receives the ATP alerts. Review the options and **add your personal email address** so you can view the alerts in a future step of this exercise.  

    :::image type="content" source="../media/8-advanced-threat-protection-settings.png" alt-text="Screenshot of ATP Settings information.":::  

1. Once you've updated all your settings, don't forget to select **Save**.  

    Setting up these settings will enable you to complete some of the other steps in this activity, so you'll see more of VA and ATP soon.  

## Data Discovery & Classification

1. Navigate back to your Azure SQL Database (not the logical server!). In the left-hand menu, under Security, Select **Advanced data security**.  

1. First, you'll review Data Discovery & Classification (DD&C) which provides advanced capabilities for discovering, classifying, labeling, and reporting the sensitive data in your database.

    For this step, select the **Data Discovery & Classification** box. This wizard type of view is similar (but not exactly matching) to the Data Discovery & Classification tool that exists in SQL Server today through SSMS. Using the SSMS wizard is **supported** for Azure SQL Managed Instance but **not supported** for Azure SQL Database, but you can achieve similar functionality using the Azure portal (supported for both Azure SQL Database and Managed Instance).  

    T-SQL can be used across all deployment options to add/drop column classifications and to retrieve classifications.

1. Select the information bar that says, **We have found XX columns with classification recommendations**.  

1. DD&C tries to identify potential sensitive data based on the column names in your tables. Review some of the suggested labels and then select **Select all** and **Accept selected recommendations**.  

1. Select **Save** near the top-left corner.

1. Finally, select **Overview** to view the overview dashboard and review the classifications you've added.  

    :::image type="content" source="../media/8-data-classification-overview.png" alt-text="Screenshot of the data classification overview.":::  

## Vulnerability Assessment

1. Select the **X** in the top-right corner of DD&C to bring you back to the ADS dashboard. Next, you'll review the Vulnerability Assessment (VA) capabilities. Start by selecting the **Vulnerability Assessment** box.  

    :::image type="content" source="../media/8-azure-data-studio-dashboard-2.png" alt-text="Screenshot of how to return to the main ADS dashboard.":::  

1. Next, select **Scan** to get the most current VA results. This will take a few moments, while VA scans all the databases in your Azure SQL Database logical server.

    :::image type="content" source="../media/8-vulnerability-scan.png" alt-text="Screenshot of how to kick off a VA scan.":::  

    Your resulting view should be similar to below.  

    :::image type="content" source="../media/8-vulnerability-scan-results.png" alt-text="New VA dashboard after scan" lightbox="../media/8-vulnerability-scan-results.png":::  

1. Every security risk has a risk level (high, medium, or low) and additional information. The rules in place are based on benchmarks provided by the Center for Internet Security (you can read more about the CIS benchmark [here](https://www.cisecurity.org/benchmark/microsoft_sql_server/?azure-portal=true)). Select the security check **VA2065** to get a detailed view, similar to below. Review the status and other available information.  

    > [!NOTE]
    > If **VA2065** does not fail, you can perform a similar exercise below, depending on what failed security checks do occur.  

    :::image type="content" source="../media/8-va20652-details.png" alt-text="Screenshot of the VA2065 security risk.":::  

    In this case, VA is suggesting that you configure a baseline of what firewall rules have been set. Once you have a baseline, you can then monitor and assess any changes.  

1. Depending on the security check, there will be alternate views and recommendations. Review the information that's provided. For this security check, you can select the **Approve as Baseline** button > **Yes** at the top of the details page. Now that a baseline is in place, this security check will fail in any future scans where the results are different from the baseline. Select **X** to exit the specific rule.  

1. You can then complete another scan by selecting **Scan** and confirming that VA2065 is now showing up as a *Passed* security check.  

    :::image type="content" source="../media/8-va2065-passed.png" alt-text="Screenshot of the VA2109 security risk being passed." lightbox="../media/8-va2065-passed.png":::  

    If you click into the passed security check above, you should be able to see the baseline you configured. If anything changes in the future, VA scans will pick it up and the security check will fail.  

## Advanced Threat Protection

1. Select the **X** in the top-right corner of VA to get back to the ADS dashboard. Select the **Advanced Threat Protection** (ATP) box to drill in and review the results. ATP detects anomalous activities indicating unusual and potentially harmful attempts to access or exploit databases.  

    :::image type="content" source="../media/8-azure-data-studio-dashboard-3.png" alt-text="Screenshot of how to return to the ADS dashboard.":::  

    Likely, you won't see any security alerts at this stage. In the next step, you will run a test that will trigger an alert, so you can review the results in ATP.  

1. ATP can be used to identify and alert when the following things are suspected of occurring:  

    * SQL injection
    * SQL injection vulnerability
    * Data exfiltration
    * Unsafe action
    * Brute force
    * Anomalous client login

    In this section, you will see how a SQL Injection alert can be triggered through SSMS. SQL Injection alerts are intended for custom-written application not for standard tools like SSMS. Therefore, to trigger an alert through SSMS as a test for a SQL Injection we need to "set" the **Application Name** (which is a connection property for clients connecting to SQL Server or Azure SQL).

    To get the full experience of this section, you'll need access to the email address you provided for ATP alerts in the first part of this exercise. If you need to update it, do so before proceeding.  

1. Using SSMS, select **File** > **New** > **Database Engine Query** to create a query using a new connection.  

1. In the main login window, fill in your AdventureWorks login information as you usually would, with SQL authentication. Before connecting, however, select **Options** > **Connection Properties**. Once in here, specify your AdventureWorks database using the "Connect to database" drop-down.  

    :::image type="content" source="../media/8-connect-db.png" alt-text="Screenshot of how to connect to a specific database.":::  

1. Select the **Additional Connection Parameters** tab and insert the following into the empty text box:  

    ```sql
    Application Name=webappname
    ```

    To connect, finally, select **Connect**.  

    :::image type="content" source="../media/8-app-name.png" alt-text="Screenshot of how to connect with an app name.":::  

1. In the new query window, run the following query:  

    ```sql
    SELECT * FROM sys.databases WHERE database_id like '' or 1 = 1 --' and family = 'test1';
    ```

1. Within a few minutes, you should receive an email similar to the following.  

    :::image type="content" source="../media/8-advanced-threat-protection-email.png" alt-text="Screenshot of an ATP threat detected email.":::  

    Additionally, navigate to the Azure portal to your AdventureWorks database. In the left-hand menu, under Security, select **Advanced data security**. You should now see an alert.  

    :::image type="content" source="../media/8-advanced-threat-protection-alert.png" alt-text="Screenshot of an ATP alert.":::  

1. Select the **Advanced Threat Protection** pane to see the overall security alerts.  

    :::image type="content" source="../media/8-security-alerts.png" alt-text="Screenshot of the security alerts." lightbox="../media/8-security-alerts.png":::  

1. Select **Potential SQL injection** to drill in specific alerts and receive investigation steps.  

1. As a clean up step, you might consider closing all your query editors in SSMS and removing all connections so you don't accidentally trigger additional alerts in the next exercise.

In this exercise, you learned how to configure and leverage some of the features in Advanced data security. In the following exercise, you'll expand on what you've learned throughout the security module by using various security features together.

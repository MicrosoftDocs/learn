With Microsoft Entra ID reports, you can get the information needed to determine how your environment is doing. With the usage and insights report, you can get an application-centric view of your sign-in data and find answers to the following questions:

 -  What are the top used applications in the organization?
 -  What applications have the most failed sign-ins?
 -  What are the top sign-in errors for each application?

## Access the usage and insights report

1.  Navigate to the [Microsoft Entra admin center](https://entra.microsoft.com/).
2.  Select the Identity menu, then select **Applications** and choose **Enterprise applications**.
3.  From the **Activity** section, select **Usage & insights** to open the report.

:::image type="content" source="../media/main-menu-13c3dfec.png" alt-text="Screenshot of the Usage and insights selected from the Activity section. Use the report to gain insights.":::


## Use the report

The usage and insights report shows the list of applications with one or more sign-in attempts and allows you to sort by the number of successful sign-ins, failed sign-ins, and the success rate.

Selecting **load more** at the bottom of the list allows you to view more applications on the page. You can select the date range to view all applications that have been used within the range.

You can also set the focus on a specific application. Select **view sign-in activity** to see the sign-in activity over time for the application and the top errors.

When you select a day in the application usage graph, you get a detailed list of the sign-in activities for the application.

:::image type="content" source="../media/usage-and-insights-report-af407792.png" alt-text="Screenshot of the Usage and insights for Application activity where you can select a range and view sign-in activity for different apps.":::


## Audit logs

The Microsoft Entra audit logs provide records of system activities for compliance. Users in the Security Administrator, Security Reader, Report Reader, Global Reader or Global Administrator roles can access their data. To access the audit report, select **Audit logs** in the **Monitoring** section of **Microsoft Entra ID**.

An audit log has a default list view that shows:

 -  the date and time of the occurrence
 -  the service that logged the occurrence
 -  the category and name of the activity (what)
 -  the status of the activity (success or failure)
 -  the target
 -  the initiator/actor (who) of an activity

:::image type="content" source="../media/list-view-b780f0a6.png" alt-text="Screenshot of a sample Audit logs. You can work with the common values noted above, like date and status.":::


You can customize the list view by clicking **Columns** in the toolbar.

:::image type="content" source="../media/columns-92e98324.png" alt-text="Screenshot of the list of available Audit columns. Configure the report based on your needs.":::


This enables you to display other fields or remove fields that are already displayed.

:::image type="content" source="../media/column-select-92a6a962.png" alt-text="Screenshot of the audit log columns. Some of the fields have been selected to Remove.":::


Select an item in the list view to get more detailed information.

:::image type="content" source="../media/details-4b1cca95.png" alt-text="Screenshot of the audit logs, after customizing. A sample item of data is the selected item.":::


## Enterprise applications audit logs

With application-based audit reports, you can get answers to questions such as:

 -  What applications have been added or updated?
 -  What applications have been removed?
 -  Has a service principal for an application changed?
 -  Have the names of applications been changed?
 -  Who gave consent to an application?

If you want to review audit data related to your applications, you can find a filtered view under **Audit logs** in the **Activity** section of the **Enterprise applications** screen. This entry point has **Enterprise applications** preselected as the **Application Type**.

:::image type="content" source="../media/enterprise-applications-67e87834.png" alt-text="Screenshot of the Enterprise applications. The application type for reporting has been selected.":::

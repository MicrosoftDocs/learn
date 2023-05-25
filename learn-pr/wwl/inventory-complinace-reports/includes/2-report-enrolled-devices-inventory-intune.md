

While the Microsoft Intune admin center doesn't include any reports specifically for inventory in the Reports node, you can still report on all your devices and applications using the Devices and Apps tab.

### Device reporting

To create and download a report for devices, in the Microsoft Intune admin center, do the following:

1.  Select **Devices** and then select **All devices**.
2.  In the **All devices** view, select the **Columns** option. Select (or deselect) any fields you wish to include in the report. Select **Apply**.
3.  Select the **Filter** option. Select any other criteria you wish to set as a filter (such as OS, ownership, etc.) in the report. Select **Apply**.
4.  In the **All devices** view, select **Export**.
5.  Select **Yes**. A report containing all your devices with hardware inventory will be generated and downloaded to your computer, as a zipped, comma-separated value (.csv) file.
6.  You can now view or modify the report in Excel.

Alternatively, instead of selecting All devices, you can also select a specific platform and perform the same actions as described above.

### Application reporting

To create and download a report for apps, in the Microsoft Intune admin center, do the following:

1.  Select **Apps** and then select **All apps**.
2.  In the **All apps** view, select the **Columns** option. Select (or deselect) any fields you wish to include in the report. Select **Apply**.
3.  Select the **Filter** option. Select any other criteria you wish to set as a filter (such as platform, assignment, app type) in the report. Select **Apply**.
4.  In the **All apps** view, select **Export**.
5.  Select **Yes**. A report will be generated and downloaded to your computer, as a zipped, comma-separated value (.csv) file.
6.  You can now view or modify the report in Excel.

You can also download Audit logs from Intune, which provides you with a record of activities that generate a change in Microsoft Intune. Create, Update (edit), Delete, and Assign actions, or remote tasks, generate audit events that you can review. You can review audit logs for most Intune workloads. Auditing is enabled by default for all customers and can't be disabled.

To view and download Audit logs, the steps are identical to how you would create reports for hardware and apps described above. To access Audit logs, in the Microsoft Intune admin center, navigate to **Tenant administration** > **Audit logs**.

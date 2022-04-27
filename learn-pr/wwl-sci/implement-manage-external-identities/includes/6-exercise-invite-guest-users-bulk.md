## Invite guest users in bulk

1.  Sign in to the [Azure portal](https://portal.azure.com/) with an account that is a User administrator in the organization.
2.  In the navigation pane, select **Azure Active Directory**.
3.  Under **Manage**, select **Users**.
4.  On the Users blade, on the menu, select **Bulk operations - Bulk invite**.<br>:::image type="content" source="../media/bulk-invite-option-47b122a8.png" alt-text="Screen image displaying the All user page with the Bulk operations and Bulk invite menu options highlighted.":::
    
5.  In the Bulk invite users pane, select **Download** to a sample CSV template with invitation properties.
6.  Using an editor to view the CSV file, review the template.

    > [!NOTE]
    > **<br>**\- **Email address to invite** \- the user who will receive an invitation<br>\- **Redirection url** \- the URL to which the invited user is forwarded after accepting the invitation.

7.  Open the .csv template and add a line for each guest user. Required values are::::image type="content" source="../media/template-csv-d304cf62.png" alt-text="Screen image displaying the example bulk invite guests template CSV.":::
    
8.  Save the file.
9.  On the Bulk invite users page, under **Upload your csv file**, browse to the file. When you select the file, validation of the .csv file starts.
10. After the file contents are validated, you will see **File uploaded successfully**. If there are errors, you must fix them before you can submit the job.<br>:::image type="content" source="../media/bulk-invite-users-upload-csv-6685bcfd.png" alt-text="Screen image displaying Bulk invite users with File uploaded successfully message highlighted.":::
    
11. When your file passes validation, select **Submit** to start the Azure bulk operation that adds the invitations.
12. To view the job status, select **Click here to view the status of each operation**. Or, you can select **Bulk operation results** in the Activity section. For details about each line item within the bulk operation, select the values under the **\# Success**, **\# Failure**, or **Total Requests** columns. If failures occurred, the reasons for failure will be listed.:::image type="content" source="../media/bulk-operations-results-9a0e524d.png" alt-text="Screen image displaying the results of a bulk operation.":::
    
13. When the job completes, you will see a notification that the bulk operation succeeded.

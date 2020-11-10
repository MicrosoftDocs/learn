Azure Sentinel provides several templates that are ready for use. You can use these templates to create your own workbook that can then be modified as needed. Most of the data connectors that are used to ingest data come with their own workbooks. You can get better insight into the data that is being ingested using tables and visualizations, including bar and pie charts. You can also make your own workbooks from scratch, if required.

## Workbook page

You can access the **Workbook** page from the Azure Sentinel from the navigation pane on the left.

The **Workbook** page consist of the:

- Workbook header. You can add a new workbook and see the saved workbooks and templates that are available in the Workbook page.
- The Templates section. You can access existing workbook templates in **Templates** tab. You can save some of the workbooks for quick access and they will appear in the **My workbooks** tab.

From the **Template** page you can select existing workbook and that will bring a detailed view on the right side that contains additional information for the templates. In the detailed view, you can find more information about the workbook. The detailed view also contains information about required data types and required data connectors that must be connected to Azure Sentinel. You can also view how the report will look.

## View existing workbook template

As you may see from our scenario Contoso was concerned regarding compromised identities. They can examine the existing workbook **Audit AD Sign-in logs** by selecting the template in the template section and then selecting **View template** in the detailed view.

![Screenshot that present existing workbooks](../media/04-View-Existing-workbook.PNG)

Azure AD Sign-in logs workbook contains predefined charts, graphs and tables that can give you important insight about sign-in activity in Azure Active Directory. You can find information about user sign-ins and locations, email addresses, and IP addresses of your users, as well as failed activities and the errors that triggered the failures.

In the **Azure AD Sign-in logs** page you can expand the time range or filter the Apps and Users that has sign-in in the Azure. For example, Contoso wants to identify user that has sign-in in Azure Portal, so they can filter the data as is shown in the following screenshot:

![Screenshot that present filtering users](../media/04-Filter-Users.PNG)

Contoso is interesting in identifying the failed sign-in, so they can show these accounts, by clicking on the Informational tiles, and selecting a tile or a raw which will bring more information such as:

- **Sign-in Location**. This section presents from which location the user sign-in.
- **Location Sign-in details**. This section on the right, shows the users, sing-in status, and the time of the occurrence.
- **Sign-ins by Device**. This section will list devices used by the users to sign-in in Azure AD.
- **Device Sign-in details**. This section shows the users that sing-in on that device and the time of the occurrence.

This information tile in the background is configured to run the query and filter the data collected from the Azure AD connector. The date is then visualized and presented with tables that are more meaningful and provide insight of user signs-in.

![](RackMultipart20201108-4-18itt0u_html_b30c57411d10cf7a.png)

The workbook contains additional tiles, that shows the user that sign-in using conditional access. From the **Conditional access status** table, you can vie users that were required multifactor authentication MFA to validate their identity.

![](RackMultipart20201108-4-18itt0u_html_5b27267d2e2835c9.png)

The rest of the page also contains tables and charts that are interactive and by selecting some of the rows or tiles, you are filtering the data that is presented. Some tables are created with links to corresponding logs as shown in the following screenshot:

![](RackMultipart20201108-4-18itt0u_html_c2a97eb978cde1cc.png)

Note:

You can also pin the query step in the private of shared dashboard for quick retrieval.

In our example, Contoso wants to search the log for more information that present the failed user sign in and they are redirected in the Azure Data Explorer, where the log query is executed to filter the information.

![](RackMultipart20201108-4-18itt0u_html_cecbf3deffdd97a3.png)

## Exploring saved workbooks

From the **Templates** page, you can save a workbook from existing templates, by selecting the templates and selecting **Save.** You must provide a location where you are saving the workbook, and that create an Azure resource based on the template with template&#39;s JSON file.

Saved workbooks, are available in the **My Workbooks** tab, and they can be further customized. You can open saved workbook by selecting **View saved workbook.**

That will bring the same page, as the template workbook page, but this one can be further customized.

![](RackMultipart20201108-4-18itt0u_html_c3041686547df73b.png)

You can select **Edit** and that will open the workbook in the edit mode, where you can add or remove items and provide additional customization. Editing mode shows all content in the workbook, including steps and parameters that would be hidden in the reading mode.

The header bar in the editing mode contains the following options:

![](RackMultipart20201108-4-18itt0u_html_4a8067b67cac2f60.png)

Once you have switched to editing mode you will notice a number of **Edit** boxes appear to the right corresponding with each individual aspect of your workbook.

If you select one of those edit buttons, you can examine the query that is used to filter the data from the corresponding log. In the screenshot bellow, you can see the query that is filtering all the users sign-ins from the sign-in logs:

![](RackMultipart20201108-4-18itt0u_html_7f2df2048d4ab7b3.png)

If you click on the gear icon, you can open **Settings** page, where you can provide additional resources that can be used in the workbook. You can also change the style of the workbook, provide tagging, or pin the item in the workbook.

![](RackMultipart20201108-4-18itt0u_html_8dc97fd1929d4cdc.png)

You can rearrange the place of different table in the workbook, by selecting **Show Pin Options.**

For advanced customization, you can open **Advanced Editor** , which will open JSON representation of the current workbook, that can be further customized in the text editor as shown in the screenshot:

![](RackMultipart20201108-4-18itt0u_html_a349a7a2e53def25.png)

You can save changes in the existing workbook or save as another workbook.

When you are done with all the customization, you can exit edit mode, by selecting **Done Editing.**

## Explore the Azure Sentinel repository on GitHub

The Azure Sentinel repository contains out of the box detections, exploration queries, hunting queries, workbooks, playbooks and much more to help you secure your environment and hunt for threats. The repo is contributed to by Microsoft and the Azure Sentinel community.

The repo contains folders with contributed content for several areas of Azure Sentinel functionality, including hunting queries. You can use the code from these queries to create custom queries in your Azure Sentinel workspace.

Tags are name and value pairs that enable you to categorize resources and view consolidated billing. You can apply the same tag to multiple resources and resource groups. Using tags helps you manage Azure NetApp Files billing and expenses.

> [!NOTE]
> Billing tags are assigned at the capacity pool level, not volume level.

To add or edit a tag on a capacity pool, go to the **capacity pool** and select **Tags.**

- You need to fill in the **Name** and **Value** pair for the tag on a capacity pool.

[![Screenshot of the Azure portal Tags blade for a capacity pool resource, showing an existing tag and a new billing tag being added.](../media/edit-tag.png)](../media/edit-tag.png#lightbox)

You can display and download information about tagged resources by using the Microsoft Cost Management portal:

- Click **Cost Analysis** under **Reporting + analytics** and select the **Resources** view.

[![Screenshot of the Microsoft Cost Management Cost Analysis page, showing a list of resources with their associated tags.](../media/cost-analysis.png)](../media/cost-analysis.png#lightbox)

- To download an invoice, select **Invoices** and then the **Download** button.

[![Screenshot of the Microsoft Cost Management Invoices page, with the Download column highlighted.](../media/invoices.png)](../media/invoices.png#lightbox)

- In the Download window that appears, download usage details. The downloaded csv file includes capacity pool billing tags for the corresponding resources.

[![Screenshot of the Download dialog for a billing period, with the Usage Details Download button highlighted.](../media/usage-download-dialog.png)](../media/usage-download-dialog.png#lightbox)

[![Screenshot of an usage details billing export spreadsheet showing resource tags in JSON format, including billing tags for HR/Legal and Sales.](../media/usage-details-export.png)](../media/usage-details-export.png#lightbox)

Tags are name and value pairs that enable you to categorize resources and view consolidated billing. You can apply the same tag to multiple resources and resource groups. Using tags helps you manage Azure NetApp Files billing and expenses.

> [!NOTE]
> Billing tags are assigned at the capacity pool level, not volume level.

To add or edit a tag on a capacity pool, go to the **capacity pool** and select **Tags.**

- You need to fill in the **Name** and **Value** pair for the tag on a capacity pool.

:::image type="content" source="../media/edit-tag.png" alt-text="Screenshot of the Azure portal Tags blade for a capacity pool resource, showing an existing tag and a new billing tag being added." border="true" lightbox="../media/edit-tag.png":::

You can display and download information about tagged resources by using the Microsoft Cost Management portal:

- Click **Cost Analysis** under **Reporting + analytics** and select the **Resources** view.

:::image type="content" source="../media/cost-analysis.png" alt-text="Screenshot of the Microsoft Cost Management Cost Analysis page, showing a list of resources with their associated tags." border="true" lightbox="../media/cost-analysis.png":::

- To download an invoice, select **Invoices** and then the **Download** button.

:::image type="content" source="../media/invoices.png" alt-text="Screenshot of the Microsoft Cost Management Invoices page, with the Download column highlighted." border="true" lightbox="../media/invoices.png":::

- In the Download window that appears, download usage details. The downloaded csv file includes capacity pool billing tags for the corresponding resources.

:::image type="content" source="../media/usage-download-dialog.png" alt-text="Screenshot of the Download dialog for a billing period, with the Usage Details Download button highlighted." border="true" lightbox="../media/usage-download-dialog.png":::

:::image type="content" source="../media/usage-details-export.png" alt-text="Screenshot of a usage details billing export spreadsheet showing resource tags in JSON format, including billing tags for HR/Legal and Sales." border="true" lightbox="../media/usage-details-export.png":::

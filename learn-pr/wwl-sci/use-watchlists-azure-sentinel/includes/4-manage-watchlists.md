We recommend you edit an existing watchlist instead of deleting and recreating a watchlist. Log analytics has a five-minute SLA (Service Level Agreement) for data ingestion. If you delete and recreate a watchlist, you might see both the deleted and recreated entries in Log Analytics during this five-minute window. If you see these duplicate entries in Log Analytics for a longer period of time, submit a support ticket.

## Edit a watchlist item

Edit a watchlist to edit or add an item to the watchlist.

1. In the Azure portal, go to Microsoft Sentinel and select the appropriate workspace.

1. Under Configuration, select **Watchlist**.

1. Select the watchlist you want to edit.

1. On the details pane, select **Update watchlist > Edit watchlist items**.

1. To edit an existing watchlist item,

    1. Select the checkbox of that watchlist item.

    2. Edit the item.

    3. Select Save.

    4. Select Yes at the confirmation prompt.

1. To add a new item to your watchlist,

    1. Select Add new.

    2. Fill in the fields in the Add watchlist item panel.

    3. At the bottom of that panel, select Add.

## Bulk update a watchlist

When you have many items to add to a watchlist, use bulk update. A bulk update of a watchlist appends items to the existing watchlist. Then, it deduplicates the items in the watchlist where all the value in each column match.

If you deleted an item from your watchlist file and upload it, bulk update won't delete the item in the existing watchlist. Delete the watchlist item individually. Or, when you have many deletions, delete and recreate the watchlist.

The updated watchlist file you upload must contain the search key field used by the watchlist with no blank values.

To bulk update a watchlist,

1. In the Azure portal, go to Microsoft Sentinel and select the appropriate workspace.

1. Under Configuration, select **Watchlist**.

1. Select the watchlist you want to edit.

1. On the details pane, select **Update watchlist > Bulk update**.

1. Under Upload file, drag and drop or browse to the file to upload.

1. If you get an error, fix the issue in the file. Then select Reset and try the file upload again.

1. Select **Next: Review and update > Update**.
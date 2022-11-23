To create a watchlist from the Azure portal perform these steps:

1. Go to **Microsoft Sentinel > Configuration > Watchlist** and select **Add new**.

    :::image type="content" source="../media/watchlist-create.png" alt-text="Screen shot of creating a Sentinel Watchlist List.":::

1. On the General page, provide the name, description, and alias for the watchlist, then select **Next**.

1. On the Source page, select the dataset type, upload a file, then select **Next**.

    > [!NOTE]
    > File uploads are currently limited to files of up to 3.8 MB in size.

1. Next, review the information, verify that it's correct, then select **Create**. A notification appears once the watchlist is ready.

To use the watchlist data in KQL, use the KQL function _GetWatchlist('watchlist name').

```kusto
_GetWatchlist('HighValueMachines')

```

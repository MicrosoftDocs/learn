To create a watchlist from the Azure portal do the following:

1. Go to **Azure Sentinel > Configuration > Watchlist** and select **Add new**.

![Watchlist List](../media/watchlistcreate.png)

1. On the General page, provide the name, description, and alias for the watchlist, then select **Next**.

1. On the Source page, select the dataset type, upload a file, then select **Next**.

> [!NOTE]
> File uploads are currently limited to files of up to 3.8 MB in size.

1. Next, review the information, verify that it is correct, then select **Create**. A notification appears once the watchlist is ready.

To use the watchlist data in KQL, use the KQL function _GetWatchlist('watchlist name').

```kusto
_GetWatchlist('HighValueMachines')

```


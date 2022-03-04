Azure Storage offers several kinds of storage accounts. Each kind supports different features and has its own pricing model. Consider these differences before you create a storage account to determine the kind of account that is best for your applications. The kinds of storage accounts are:

:::row:::
  :::column:::
    **Storage account**
  :::column-end:::
  :::column:::
    **Recommended usage**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Standard general-purpose v2
  :::column-end:::
  :::column:::
    Most scenarios including Blob, File, Queue, Table, and Data Lake Storage.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Premium block blobs
  :::column-end:::
  :::column:::
    Block blob scenarios with high transactions rates, or scenarios that use smaller objects or require consistently low storage latency.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Premium file shares
  :::column-end:::
  :::column:::
    Enterprise or high-performance file share applications.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Premium page blobs
  :::column-end:::
  :::column:::
    Premium high-performance page blob scenarios.
  :::column-end:::
:::row-end:::


> [!NOTE]
> All storage accounts are encrypted using Storage Service Encryption (SSE) for data at rest.

To conclude your review of Azure Blob Storage cost optimization options, you decide to closely review Azure Blob Storage reservations. Your company has chosen Microsoft Azure as its strategic cloud platform and is committed to expanding its investments in Azure Storage services. Encouraged by your management team, you’re searching for additional cost savings that reservations could provide. In this unit, you'll learn about the requirements and benefits of Azure Blob Storage reservations.

### Implement Azure Blob Storage reservations

Azure Storage reserved capacity offers significant savings in return for purchasing a designated capacity of Azure Block Blob Storage or Azure Data Lake Storage for the period of one or three years. Reservations are available in 100 TB and 1 PB blocks to accommodate varying customer needs. The purchase applies to the cost of storage (per GB) and doesn’t cover early deletion charges or the charges associated with storage operations and data transfers.

As part of the arrangement, you can choose the required number of units for hot, cool, cold, or archive access tiers in combination with on any of the available storage redundancy options within a specific Azure region. The amount of savings depends on several factors, including:

- The duration of the reservation.

- The total reserved capacity.

- The access tier.

- The type of redundancy designated at the time of purchasing the reservation.

You can scope the reserved capacity to a single subscription, multiple subscriptions (referred to as a *shared scope*), and management groups. This means that a reservation is aggregated at that scope and cannot be limited to a specific storage account, container, or object within the subscription.

From the commercial standpoint, you can choose between a single, upfront payment and monthly payments. For Enterprise Agreement (EA) customers, the charges are deducted from the enrollment's Azure Prepayment balance or charged as overage.

> [!NOTE]
> Azure Storage reserved capacity isn’t available for premium Azure Block Blob storage accounts.

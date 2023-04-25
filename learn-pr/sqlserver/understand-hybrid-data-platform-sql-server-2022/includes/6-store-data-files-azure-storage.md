---
title: Store SQL Server data files on Azure Storage
durationInMinutes: 4
---

A cloud connected approach enables organizations to seamlessly integrate on-premises and cloud services, and it can serve as a long-term strategy that enables organizations to strike a balance between their business needs and leverage the benefits of both on-premises and cloud solutions.

Hosting on-premises SQL Server data files on Azure provides several benefits for organizations looking to migrate their data to the cloud. It simplifies the migration process by allowing for an incremental migration without requiring any application changes or new hardware.

In the upcoming modules, we'll explore more thoroughly. However, at present, it's essential to understand the hybrid nature of this feature.  

### Use case scenario

Woodgrove Bank is a large bank company that relies heavily on a database to manage its highly sensitive data. The bank cannot fully transition to Azure due to regulatory  reasons. However, they aim to utilize Azure services to minimize their hardware cost and simplify backup policies for a few operations.

Azure Blob Storage provides an alternative for the company in this scenario to store their database files, minimize hardware costs, and enhance their backup and restore strategies. For instance, they can take advantage of snapshot backup. This solution would simplify their backup policies and enhance their disaster recovery solution. In case of a disaster, for example, they could quickly restore the database to a previous snapshot, reducing downtime and the risk of data loss.

:::image type="content" source="../media/module-2-sql-data-files-on-azure-storage.png" alt-text="SQL Server data files on Azure Storage":::

This hybrid feature allows for on-premises compute resources combined with Azure storage capabilities to enable unlimited capacity and cost savings.

### Scalability and flexibility

Unlike traditional on-premises storage systems, keeping your SQL Server data files on Azure allows you to scale capacity resources, without the need to purchase additional hardware or make changes to the existing infrastructure, which often requires downtime. This flexibility would allow Woodgrove Bank to optimize their storage costs, as they only pay for the amount of storage they consume.

You can learn more about SQL Server data files on Azure Storage in the article, [SQL Server data files in Microsoft Azure](/sql/relational-databases/databases/sql-server-data-files-in-microsoft-azure).

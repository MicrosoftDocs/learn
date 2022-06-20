The ledger feature of Azure SQL Database provides tamper-evidence capabilities in your database. You can cryptographically attest to other parties, such as auditors or other business parties, that your data hasn't been tampered with.

## How it works

Cryptography and blockchain have begun to appear in far reaching areas of technology with varying degrees of success. One place where it has proved useful and beneficial is in being used as the technology behind the Azure SQL Database Ledger feature. The Ledger feature provides tamper-evidence capabilities in your database. Using the Ledger feature of the Azure SQL Database, you can provide concrete proof to auditors, business partners or any interested parties what data has been changed or tampered with.

A traditional ledger is defined as a collection of accounts of a particular type and that's exactly what the Azure SQL Database Ledger feature provides in your environment. It provides transparent protection of your data from bad actors including but not limited to attackers or even database or cloud administrators. It provides guarantees of cryptographic data integrity while maintaining the power, flexibility, and performance of Azure SQL Database.

:::image type="content" source="../media/dp-3300-module-33-lab-32.png" alt-text=" Diagram of the ledger table architecture.":::

Each transaction that the database receives is cryptographically hashed (SHA-256). The function cryptographically links all transactions together, like a blockchain.

## Components

Azure SQL Database Ledger function currently exists for tables in two forms: The Updatable Ledger Tables and the Append-only Ledger Tables.

### Updatable ledger tables

Updatable ledger table can be used for applications that issue updates and deletes and inserts. It works well for system of record applications and transactional systems where matter of fact record keeping and auditing is required and happen. The updatable ledger tables track history of changes to any rows and uses the built-in system versioning to create a history table that stores the previous version of the row for full history is kept for any updates or deletes.

### Append-only ledger tables

Append-only ledger tables work well with insert only applications such as an accounting system, which still needs auditing or security information and event management (SIEM) applications. The append-only ledger table blocks all updates and deletes at the API level so not only does it provide certainty, it aides in management.

## Benefits

The Azure SQL Database Ledger feature provides multiple benefits:

**Ease Audits –** Audits are frequently enacted to ensure that proper security controls are in place to reduce potential attacks, backup and restore practices are as required, and thorough disaster recovery procedures are in place. Ledger provides documented proof that your data hasn't been altered in an auditing process.

**Increased trust –** Ledger also can help establish trust between multiple-party business processes without the complexity and performance implications that network consensus can introduce.

**Data integrity –** Querying the data on a blockchain network without sacrificing performance can be a serious challenge. Ledger provides data integrity for off-chain storage of blockchain networks, which helps ensure complete data trust through the entire system.

## Create a SQL database with ledger enabled

You can easily enable the ledger feature by following the steps below:

1. Browse to the **Select SQL Deployment option** page on Azure portal.

1. Under **SQL databases**, leave **Resource type** set to **Single database**, and select **Create**.

    :::image type="content" source="../media/dp-3300-module-33-lab-33.png" alt-text="Screenshot that shows how to select SQL deployment option.":::

1. On the **Basics** tab of the **Create SQL Database** form, under Project details, select the Azure subscription you want to use.

1. For **Resource group**, select **Create new**, enter *myResourceGroup*, and select **OK**.

1. For **Database name**, enter *demo*.

1. For **Server**, select **Create new**. Fill out the New server form with the following values, and select **OK**:

    - **Server name:** &lt;enter a unique server name&gt;
    - **Server admin login:** azureuser
    - **Password:** &lt;enter a strong password&gt;
    - **Location:** Select the same region where your resource group was created
    - **Allow Azure services to access this server:** Select this option to enable access to digest storage.

1. Leave **Want to use SQL elastic pool** set to **No**.

1. Under **Compute + storage**, select **Configure database**.

1. Select **Serverless**, and then select **Apply**.

    :::image type="content" source="../media/dp-3300-module-33-lab-34.png" alt-text="Screenshot that shows configuring a serverless database.":::

1. On the **Networking** tab, for **Connectivity method**, select **Public endpoint**.

1. For **Firewall rules**, set **Add current client IP address** to **Yes**. Leave **Allow Azure services and resources to access this server** set to **No**.

1. Select **Next: Security** at the bottom of the page.

    :::image type="content" source="../media/dp-3300-module-33-lab-35.png" alt-text=" Screenshot that shows the Networking tab of the Create SQL Database screen in the Azure portal.":::

1. On the **Security** tab, in the Ledger section, select the **Configure ledger** link.

    :::image type="content" source="../media/dp-3300-module-33-lab-36.png" alt-text=" Screenshot that shows configuring a ledger on the Security tab of the Azure portal.":::

1. On the Configure ledger pane, in the **Ledger** section, select the **Enable for all future tables in this database** checkbox. 
    
    >[!NOTE]
    >This setting ensures that all future tables in the database will be ledger tables. For this reason, all data in the database will show any evidence of tampering. By default, new tables will be created as updatable ledger tables, even if you don't specify `LEDGER = ON` in the `CREATE TABLE` statement. 
    >
    >You can also leave this option unselected. You're then required to enable ledger functionality on a per-table basis when you create new tables by using Transact-SQL.

1. In the **Digest Storage** section, **Enable automatic digest storage** is automatically selected. Then, a new Azure Storage account and container where your digests are stored is created.

1. Select **Apply**.

    :::image type="content" source="../media/dp-3300-module-33-lab-37.png" alt-text="Screenshot that shows the Configure ledger (preview) pane in the Azure portal.":::

1. Select **Review + create** at the bottom of the page.

    :::image type="content" source="../media/dp-3300-module-33-lab-38.png" alt-text=" Screenshot that shows reviewing and creating a ledger database on the Security tab of the Azure portal.":::

1. On the **Review + create** page, after your review, select **Create**.

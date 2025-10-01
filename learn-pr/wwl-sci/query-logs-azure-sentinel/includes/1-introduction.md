Microsoft Sentinel collects log data that is stored in tables. The Logs page in Microsoft Sentinel provides a user interface to build and view query results using the Kusto Query Language (KQL). KQL is the query language used to perform data analysis to create analytics, workbooks, and perform hunting with Microsoft Sentinel.

You're a Security Operations Analyst working at a company that's implementing Microsoft Sentinel. You must explore the tables available in your workspace. You use the Logs page in Microsoft Sentinel in the [Azure portal](https://portal.azure.com), and Advanced hunting, and Data lake pages available in the [Defender portal](https://security.microsoft.com/) to write Kusto Query Language (KQL) statements to view data stored in the tables.  When you connect log data to the Microsoft Sentinel workspace, the connectors write data to specific tables.

You need to have a basic understanding of the provided tables and their intended purpose. For example, the "SecurityEvents" table is designed for Windows Security Event log data.  With this knowledge, you're able to query the required tables to use in your search for malicious activity.

After completing this module, you'll be able to:

- Use the Logs page to view data tables with Microsoft Sentinel
- Query the most used tables using Microsoft Sentinel

## Prerequisites

Basic knowledge of operational concepts such as monitoring, logging, and alerting

> [!IMPORTANT]
> [Microsoft Sentinel is generally available in the Microsoft Defender portal](https://security.microsoft.com), including for customers without Microsoft Defender XDR or an E5 license.
>
> Starting in **July 2026**, all customers using Microsoft Sentinel in the Azure portal will be redirected to the Defender portal and will use Microsoft Sentinel in the Defender portal only. Starting in **July 2025**, many new customers are automatically onboarded and redirected to the Defender portal.
>
> If you're still using Microsoft Sentinel in the Azure portal, we recommend that you start planning your transition to the Defender portal to ensure a smooth transition and take full advantage of the unified security operations experience offered by Microsoft Defender. For more information, see [It’s Time to Move: Retiring Microsoft Sentinel’s Azure portal for greater security](https://techcommunity.microsoft.com/blog/microsoft-security-blog/planning-your-move-to-microsoft-defender-portal-for-all-microsoft-sentinel-custo/4428613).

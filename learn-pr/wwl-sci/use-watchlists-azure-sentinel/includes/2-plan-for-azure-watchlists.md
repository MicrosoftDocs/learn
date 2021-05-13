Azure Sentinel watchlists enable collecting data from external data sources for correlation with the events in your Azure Sentinel environment. Once created, you can use watchlists in your search, detection rules, threat hunting, and response playbooks. Watchlists are stored in your Azure Sentinel workspace as name-value pairs and are cached for optimal query performance and low latency.

Common scenarios for using watchlists include:

- Investigating threats and responding to incidents quickly with the rapid import of IP addresses, file hashes, and other data from CSV files. Once imported, you can use watchlist name-value pairs for joins and filters in alert rules, threat hunting, workbooks, notebooks, and general queries.

- Importing business data as a watchlist. For example, import user lists with privileged system access, or terminated employees, and then use the watchlist to create allow and deny lists used to detect or prevent those users from logging in to the network.

- Reducing alert fatigue. Create allow lists to suppress alerts from a group of users, such as users from authorized IP addresses that perform tasks that would normally trigger the alert, and prevent benign events from becoming alerts.

- Enriching event data. Use watchlists to enrich your event data with name-value combinations derived from external data sources.

> [!TIP]
> You can create and delete Watchlists, but you can't update Watchlists. If you are working with more dynamic lists, use KQL external data operators to create temporary virtual tables.


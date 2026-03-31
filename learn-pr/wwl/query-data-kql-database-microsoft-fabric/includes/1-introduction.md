An Eventhouse in Microsoft Fabric provides a data store for large volumes of data. It's a container that houses one or more KQL databases, each optimized for storing and analyzing real-time data that arrives continuously from various sources.

You can load data into a KQL database in an Eventhouse using an Eventstream or you can directly ingest data into a KQL database. Once you have ingested data, you can then:

- Query the data using Kusto Query Language (KQL) or T-SQL in a KQL queryset.
- Use Real-Time Dashboards to visualize the data.
- Use Fabric Activator to automate actions based on the data.

Understanding how KQL databases work helps you write effective queries to analyze real-time data. In this module, you'll learn about the characteristics that make KQL databases ideal for real-time data, then apply this knowledge by exploring KQL querying techniques and database objects like materialized views and stored functions.

## How do KQL databases work with real-time data?

KQL databases automatically partition data by ingestion time, making recent data quickly accessible while storing historical data for trend analysis. *Partitioning* means the database organizes data into separate storage locations based on when it arrived, so when you query for recent data, the database knows exactly where to search rather than scanning all the data.

Think of it like a digital conveyor belt - events flow in continuously, get organized automatically by when they arrive, and are immediately available for analysis while the stream keeps flowing.

This automatic time-based organization works because real-time data has a unique characteristic: it represents immutable events that happened at specific moments in time. *Immutable* means these events can't be changed once they've occurred - a temperature reading at 3:15 PM will always be that reading because it represents what actually happened at that moment. Since each event is permanently tied to when it happened, this creates what we call **time-series data** - data where the timestamp is often as important as the event itself.

Time-series data follows an append-only pattern where new events are continuously added, and data is rarely updated or deleted because events represent what actually happened at specific moments. This is fundamentally different from traditional relational databases, where you typically update existing records and maintain relationships between different data tables. 

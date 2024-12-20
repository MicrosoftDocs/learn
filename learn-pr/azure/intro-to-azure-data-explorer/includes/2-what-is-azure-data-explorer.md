Let's start by defining the service and taking a tour of the core features of Azure Data Explorer. This overview should help you decide if it's the right service for you to manage and analyze your data.

## What is Azure Data Explorer?

Azure Data Explorer is a big data analytics platform that makes it easy to analyze high volumes of data in near real time. Allowing you to extract key insights, spot patterns and trends, and create forecasting models.

The Azure Data Explorer toolbox gives you an end-to-end solution for data ingestion, query, visualization, and management. These tools allow you to analyze structured, semi-structured, and unstructured data across time series, and apply Machine Learning.

Azure Data Explorer is fully managed, scalable, secure, robust, and enterprise-ready. It's useful for log analytics, time series analytics, IoT, and general-purpose exploratory analytics.

## How to understand your big data

If you remember our example clothing company, they have many types of data coming in from varied domains. They need to use different kinds of analytics on these data types, and then share their results with a range of stakeholders. They're going to use Azure Data Explorer to get insights from all of their data across the company.

**Production** analyzes their product logs to manage their inventory and make manufacturing decisions. Geospatial analytics informs these decisions, which are used to identify geographical areas of high-performing ads and anticipate inventory.

The company's warehouses are outfitted with IoT devices, some of which are used by **security** to manage warehouse entry/exit logs, while others are used by operations to monitor the environment inside the warehouse. Individual stores use time series analytics to identify sales anomalies and predict future inventory events. 

The global **marketing** team uses clickstream data (also a form of log analytics) to optimize and scan online both ad campaigns and the customer funnel, while the customer success department uses text search to analyze user feedback on social media.

Every minute of the day, a company decision is being made based on data flowing into Azure Data Explorer.

## What are some of Azure Data Explorer's key features?

Now that you have an idea of what Azure Data Explorer can be used for, let's look at some of its key features.

### Data velocity, variety, and volume

Azure Data Explorer can ingest terabytes of data in minutes in batch or streaming mode. It can query petabytes of data and return results within milliseconds to seconds. This capacity allows for the high velocity (millions of events per second), low latency (seconds), and linear scale ingestion of raw data. This raw data can be ingested in different formats and structures and it can flow in from various pipelines and sources.

### User-friendly query language

Azure Data explorer uses the Kusto Query Language (KQL), an open-source language initially invented by the team. The language is simple to understand and learn, and highly productive. You can use simple operators and advanced analytics.

### Advanced analytics

Azure Data Explorer has a large set of functions for time series analysis. Including, adding and subtracting time series, filtering, regression, seasonality detection, geospatial analysis, anomaly detection, scanning, and forecasting. Time series functions are optimized for processing thousands of time series in seconds. Pattern detection is made easy with cluster plugins that can diagnose anomalies and do root cause analysis. You can also extend Azure Data Explorer capabilities by embedding python code in KQL queries.

### Easy-to-use wizard

The ingestion wizard makes the data ingestion process easy, fast, and intuitive. The web UI provides an intuitive and guided experience that helps customers ramp-up quickly to start ingesting data, creating database tables, and mapping structures. It enables a one time or continuous ingestion from various sources in various data formats. Table mappings and schema are auto suggested and easy to modify.

### Versatile data visualization

Data visualization helps you gain important insights. Azure Data Explorer offers built-in visualization and dashboarding out of the box, with support for various charts and visualizations. It has native integration with Power BI, native connectors for Grafana, Kibana and Databricks, ODBC support for Tableau, Sisense, Qlik and more.

### Automatic ingest, process, and export

Azure Data Explorer supports server-side stored functions, continuous ingest, and continuous export to Azure Data Lake store. It also supports ingestion time mapping transformations on the server side, update policies, and precomputed scheduled aggregates with materialized views.

### Integration with other services

Integrate easily and seamlessly with other tools in all aspects of your workflow, such as **Ingestion**, **Visualization**, **Orchestration**, and **Monitoring**.

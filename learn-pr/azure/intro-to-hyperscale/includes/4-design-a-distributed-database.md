If you want a database to perform well, it’s important to design it methodically. When designing a database, especially a large database, you need to assess your workloads and application. There are, generally, two types of workloads for databases.

### What are OLTP workloads?

Workloads that generate standard CRUD—create, read, update, delete—operations can involve **small amounts of data**, but generally have a **large number of transactions**. The data being analyzed is usually text, numeric, time, or JSON data. These workloads are usually called online transactional processing, or more simply **OLTP**, and are the most common type of workload. An example of this kind of workload might be sending a text, or purchasing clothes online.

Our contactless payment app will mostly have OLTP workloads - account-to-account transactions. The transactions will have small amounts of data, but occur in large numbers.

### What are OLAP workloads?

Workloads that generate reports can involve **large amounts of data**, but have a **low number of transactions**. The data being analyzed is generally event data or time series data. These workloads are usually called online analytical processing, or **OLAP**. Examples include applications that power customer-facing analytics dashboards, such as web and mobile analytics or anomaly and fraud detection.

In our scenario, when customer and merchant queries are run on the contactless payment app, these will be OLAP workloads. An example might be a status dashboard, showing if services are running or undergoing maintenance.

## Types of applications for Hyperscale

There are, broadly, two kinds of applications that work well on Hyperscale (Citus). The first step in designing a database is to identify which of them more closely resembles your application.

### SaaS applications

:::row:::
:::column span="3":::

Multi-tenant is the most common architecture used in SaaS applications, where multiple customers (tenants) share application resources.

Essentially, multi-tenant means that multiple customers share application resources with other **users, accounts, companies, or organizations**, which can provide massive cost savings. Multi-Tenant applications are inherently relational, with a natural dimension on which to distribute data across nodes: _**shard by tenant_id**_.

**Examples**: Websites which host store-fronts for other businesses, or sales automation tools.  
**Characteristics**:

* Queries relating to a single tenant rather than joining information across tenants
* Having dozens or hundreds of tables in your database schema
* Mixed workloads: OLAP workloads for serving per-tenant analytical queries, and large OLTP workloads

With Hyperscale, you can continue scaling far beyond a single node, giving you efficiency of scale, with many more tenants able to use a single application.
 :::column-end:::
:::column span="2":::

:::image type="content" source="../media/4a-multitenant.jpeg" alt-text="Multitenant architecture.":::

:::column-end:::
:::row-end:::

Our contactless payment app will be a multi-tenant application, with mixed workloads:

* **OLTP workloads** of large numbers of tenants (customers) with regular financial transactions
* **OLAP workloads** such as customer account statements

To distribute the data, a typical column to shard by could be *user_id*, *customer_id*, or *company_id*.

### Real-time applications

Real-time applications are aptly named - they’re applications that analyze real-time events as they happen.
:::row:::
:::column span="3":::

**Examples**: Customer-facing dashboards requiring sub-second response times and logistics companies who need to monitor if shipments are on-time.  
**Characteristics**:

* Few tables with a high volume of data - Often device, user, or IoT data
* Relatively simple (but computationally intensive) analytics queries

For fast results, these applications need massive amounts of compute - for numerical, statistical, or counting queries. Hundreds of cores need to be run in parallel. Hyperscale makes it possible to perform real-time queries across billions of records in under a second using horizontal scalability.
:::column-end:::
:::row-end:::

Our contactless payment app will also need customer facing dashboards. Merchants will need to analyze new events and new data as it happens, in real time. These **OLAP workloads** will be much more intensive than customer account statements.

## At a glance

| Multi-tenant applications                                 | Real-time applications                                |
|-----------------------------------------------------------|-------------------------------------------------------|
| Sometimes dozens or hundreds of tables in schema          | Small number of tables                                |
| Queries relating to one tenant (company/store) at a time  | Relatively simple analytics queries with aggregations |
| OLTP workloads for serving web clients                    | High ingest volume of mostly immutable data           |
| OLAP workloads that serve per-tenant analytical queries   | Often centering around large table of events            |

## Choose how to distribute data

Choosing how to distribute, or shard, your data is one of the most important distributed database decisions you'll make. Hyperscale distributes your data based on the distribution columns of your choosing. Once you have chosen a column to distribute, only one command is needed to distribute your data. So, choosing what columns to distribute is the most important step.

Different types of applications have different best practices for choosing which columns to distribute from.

### Sharding by ID

__Multi-tenant apps are usually distributed via a *tenant id*__. Common instances include company, account, organization, or customer. The column name will be something like *company_id* or *customer_id*.

As our example payment app is a multi-tenant app, with bank customers making up the tenants, it’s a perfect use case for distributing data. In the exercises we’ll shard by the banking customer id, which is named *user_id*.

**Sharding by user_id or tenant_id will be highly successful** because we have a large number of distinct tenants, increasing the potential number of shards that can hold data.

**Real-time applications** are usually distributed by an *entity id*. Common instances include users, hosts, or devices. The column name will be something like *user_id*, *vehicle_id*, *host_id*, or *device_id*.

For example, with our payment app, we'll have large numbers of merchants with payment machines. Merchants will need a real-time dashboard so they can see the service status - If the network is offline, or there are intermittent faults, or maintenance. We can shard by a *merchant_id*, or even by *device_id* - for each payment device.

Sharding by *merchant_id* or *device_id* will be highly successful, as:

* There are a large number of distinct values - increasing the potential number of shards that can hold the data.
* The tables will have an even distribution, giving better sharding performance. The table won't have common values that will tend to accumulate in certain shards.

When designing a database, especially a large database, it's critical to assess your workloads and application. There are, generally, two types of workloads for databases.

### What are OLTP workloads?

Transactional workloads have **small amounts of data** with **large numbers of transactions**. An example could be sending a text or purchasing clothes online. These transactions are commonly referred to as online transactional processing, or more simply **OLTP**, and are the most common type of workload.

Our contactless payment app will mostly have OLTP workloads - account-to-account transactions. The transactions will have small amounts of data, but occur in large numbers.

### What are OLAP workloads?

Analytical workloads have **large amounts of data** with **low numbers of transactions**. Examples include business intelligence dashboards and financial reporting. These workloads are usually called online analytical processing, or **OLAP**.

When analytics are run on the contactless payment app, these will be OLAP workloads. An example might be a status dashboard, showing if services are running or undergoing maintenance.

## Types of applications for Hyperscale

There are, broadly, two kinds of applications that work well on Hyperscale (Citus). The first step in designing a database is to identify which of them more closely resembles your application.

### What are multi-tenant applications?

Multi-Tenant applications are typically SaaS applications that **serve many customers**, or multiple tenants - other **companies, accounts, users, or organizations**. These applications are inherently relational, with a natural dimension on which to distribute data across nodes: shard by tenant_id.

**Examples**: Websites which host store-fronts for other businesses, or sales automation tools.  
**Characteristics**: Queries relating to a single tenant rather than joining information across tenants. Having dozens or hundreds of tables in your database schema. These applications have OLAP workloads for serving per-tenant analytical queries, and large OLTP workloads.

Multi-tenant applications provide massive cost savings, with many customers sharing resources. With Hyperscale, you can continue scaling far beyond a single node, giving you efficiency of scale with many more tenants able to use a single application.

Our contactless payment app will be a multi-tenant application, including:

* **OLTP workloads** of large numbers of tenants (customers) with regular financial transactions
* **OLAP workloads** such as customer account statements

To distribute the data, a typical column to shard by could be *user_id*, *customer_id*, or *company_id*.

### What are real-time applications?

Real-Time Applications are aptly named, generally providing real-time analytics.

**Examples**: Customer-facing analytics dashboards requiring sub-second response times and logistics companies who need to monitor if shipments are on-time.  
**Characteristics**: Few tables with a high volume of data - Often device, user, or IoT data. Relatively simple (but computationally intensive) analytics queries.

For fast results, these applications need massive amounts of compute - for numerical, statistical, or counting queries. Hundreds of cores need to be run in parallel. Hyperscale makes it possible to perform real-time queries across billions of records in under a second using horizontal scalability.

Our contactless payment app will also need real-time analytics. These **OLAP workloads** will be much more intensive than customer account statements.

## At a Glance

| Multi-Tenant Applications                                 | Real-Time Applications                                |
|-----------------------------------------------------------|-------------------------------------------------------|
| Sometimes dozens or hundreds of tables in schema          | Small number of tables                                |
| Queries relating to one tenant (company/store) at a time | Relatively simple analytics queries with aggregations |
| OLTP workloads for serving web clients                    | High ingest volume of mostly immutable data           |
| OLAP workloads that serve per-tenant analytical queries   | Often centering around large table of events            |

## Choose how to distribute data

Choosing how to distribute, or shard, your data is one of the most important modeling decisions you'll make. Hyperscale distributes your data based on distribution columns you choose.

**Multi-tenant apps** are usually distributed via a *tenant id*. Common instances include company, account, organization, or customer. The column name will be something like *company_id* or *customer_id*.

**Real-time apps** are usually distributed by an *entity id*. Common instances include users, hosts, or devices. The column name will be something like *user_id*, *host_id*, or *device_id*.

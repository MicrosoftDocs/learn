There are, generally, two types of workloads for databases.

### What are OLTP workloads?

Transactional workloads have small amounts of data with large numbers of transactions. An example could be sending a text message or purchasing clothes online. These transactions are commonly referred to as online transactional processing, or more simply **OLTP**, and are the most common type of workload.

### What are OLAP workloads?

Analytical workloads have large amounts of data with low numbers of transactions. Examples include business intelligence dashboards and financial reporting. These transactions are usually called online analytical processing, or simply **OLAP**.

## Types of applications for Hyperscale

There are, broadly, two kinds of applications that work well on Hyperscale (Citus). The first step in designing a database is to identify which of them more closely resembles your application.
Talking point: multi-tenant applications

### What are multi-tenant applications?

Multi-Tenant Applications are typically SaaS applications that serve many customers, or multiple tenants - other companies, accounts, users, or organizations. These applications are inherently relational - with a natural dimension on which to distribute data across nodes: shard by tenant_id.

Examples: Websites which host store-fronts for other businesses, or sales automation tools.
Characteristics: Queries relating to a single tenant rather than joining information across tenants. Having dozens or hundreds of tables in your database schema.

This includes OLTP workloads for serving web clients, and OLAP workloads for serving per-tenant analytical queries. 

Multi-tenant applications provide massive cost savings, with many customers sharing resources. With Hyperscale, you can continue scaling far beyond a single node, giving you efficiency of scale with many more tenants able to use a single application.
Talking point: real-time applications

## What are real-time applications?

Real-Time Applications are aptly named, generally providing real-time analytics.

Examples: Customer-facing analytics dashboards requiring sub-second response times and logistics companies who need to monitor if shipments are on-time.

Characteristics: Few tables with a high volume of data - Often device, user, or IoT data. Relatively simple (but computationally intensive) analytics queries.

For fast results, these applications need massive amounts of compute — for numerical, statistical, or counting queries. Hundreds of cores need to be run in parallel. With horizontal scalability, Hyperscale makes it possible to perform real-time queries across billions of records in under a second.

## At a Glance

| Multi-Tenant Applications                                 | Real-Time Applications                                |
|-----------------------------------------------------------|-------------------------------------------------------|
| Sometimes dozens or hundreds of tables in schema          | Small number of tables                                |
| Queries relating to one tenant (company/store) at a time | Relatively simple analytics queries with aggregations |
| OLTP workloads for serving web clients                    | High ingest volume of mostly immutable data           |
| OLAP workloads that serve per-tenant analytical queries   | Often centering around large table of events            |

## Choose how to distribute data

Choosing how to distribute, or shard, your data is one of the most important modeling decisions you'll make. Hyperscale distributes your data based on the distribution column.

**Multi-tenant apps** are usually distributed via a *tenant id*. Common instances include company, account, organization, or customer. The column name will be something like *company_id* or *customer_id*.

**Real-time apps** are usually distributed by an entity id. Common instances include users, hosts, or devices. The column name will be something like *user_id*, *host_id*, or *customer_id*.

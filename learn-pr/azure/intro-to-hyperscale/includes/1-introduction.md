When your database is small, it’s easy to throw more hardware at the problem and scale up. However, as these tables grow, you need to think about other ways to scale your database.

Hyperscale transforms PostgreSQL into a distributed database, letting you scale compute, memory, and storage. Your tables are broken into smaller parts and intelligently distributed over several servers.

*1b Talking point: Citus open source extension **Rework to 1 paragraph***

Citus, an open-source extension of PostgreSQL, was created to introduce horizontal scaling functionality to relational databases. Instead of giving up transactions, joins, or foreign keys.

By design, Postgres extensions can be loaded into the database and function like features that are built in. Citus, an open-source extension of PostgreSQL, was created to introduce horizontal scaling functionality to relational databases. Developers no longer had to sacrifice transactions, joins, or foreign keys for modern scale. Gaining popularity fast, Citus was open-sourced in 2016.

Soon after, Microsoft acquired Citus Data part of their open-source strategy, leading to the formation of Hyperscale — Combining the benefits of PostgreSQL, Citus, and Azure. As Citus was created as an extension, Hyperscale users can still leverage all of the benefits that two decades of open-source community development has given PostgreSQL.

------
In 2011, effective horizontal scaling wasn’t available for relational databases - which led some developers towards NoSQL. So, three engineers set out to provide a horizontally scalable, resilient, and worry-free database. No more giving up transactions, joins, or foreign keys. Citus, an open-source extension of PostgreSQL, was born.

Citus became so popular that it was open-sourced in 2016. Soon Microsoft, one of the biggest open-source contributors in the world, acquired Citus Data. It was part of their open-source strategy, leading to the formation of Hyperscale — Combining the benefits of PostgreSQL, Citus, and Azure.

By design, Postgres extensions can be loaded into the database and function like features that are built in. Creating Citus as an extension, grants users all of the benefits that two decades of open-source community development has given PostgreSQL. Citus is compatible with many versions of Postgres, meaning users can easily hyperscale different versions of postgres.
----

## What is Hyperscale?

Hyperscale is a deployment option, built into Azure Database for PostgreSQL. You get all the scaling benefits of Citus, along with the fully managed database-as-a-service, using the open-source Postgres relational database engine. You retain all the open-source tooling developers love, while scaling as much as you want to.

Hyperscale is used when applications require high performance or massive scale.  Examples include Clearent, where rising demand now sees over half a billion credit card transactions per year. Hyperscale takes care of the massive speed and high analytical workloads for employees and customers alike.

Another example is Helsinki Region Transport Authority (HSL), responsible for more than half of all public transportation in Finland. With over 1 million journeys every day made on HSL bus, train, Metro, tram, and ferry services, it’s critical to log and monitor this traffic efficiently.

[“Hyperscale (Citus) transforms PostgreSQL into a distributed database—giving developers game-changing performance improvements and delivering queries that are magnitudes faster than proprietary implementations of Postgres,” says Umur Cubukcu, co-founder and CEO of Citus. ] - Callout box

## The benefits of Hyperscale

Hyperscale allows for easy "scale out" - letting a single PostgreSQL instance run on multiple servers, instead of a single server. Collectively, multiple servers can hold more data and use more CPU cores than a single server, while having shorter distances to users. This gives faster responses on large datasets, even over multiple regions.

As an example, let’s say you work for Woodgrove Bank, and you’ve developed and trialed a contactless payment app that works from six feet away. Your app is currently using a single server deployment of Azure Database for PostgreSQL.

The trial went well, and now you have permission to start releasing your app to  customers in Europe and the United States. The current single on-premises server will slow transaction times, and may struggle under the heavy analytical loads that your bank requires. To avoid this problem, you need to scale the database solution for both capacity and geographic performance.

Hyperscale lets you scale out, seamlessly distributing and managing your data under the covers. Transactions will be spread across multiple servers, giving better transaction times and more room for analytical workloads.

In this module, we’ll create a Hyperscale instance on Azure, design how to effectively distribute the database, and scale it. More importantly, we’ll explain what we’re doing, and why.

## Prerequisites

- Basic knowledge of relational databases

## Learning objectives

In this module, you will:

- Create a Hyperscale instance of Azure Database for PostgreSQL
- Design a Hyperscale database for a real time application
- Scale and rebalance a Hyperscale server group

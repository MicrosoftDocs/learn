Understanding your options to accelerate and tune performance for Azure SQL is key to going further to deliver consistent performance. This includes understanding how to scale CPU capacity, increase I/O performance, configure memory and workers, improve application latency, and apply standard best practices for SQL Server tuning.

## Scale CPU capacity

You might need to scale the number of CPUs for your resource needs. For an on-premises environment, this would require you to reconfigure a VM, change hardware, and even migrate your database. Azure SQL allows you to do this with no migration on your part. You can use the portal, T-SQL, the Azure CLI, or REST APIs to scale your number of vCores up or down for your deployment.

Downtime is typically required, but this can be very fast for Azure SQL Database with no migration. Hyperscale deployments allow you to scale up in constant time regardless of data size, and Serverless deployments allow for autoscaling based on CPU demand.

> [!NOTE]
> Azure SQL Managed Instance scaling can take significant time but doesn't require any migration.

## I/O performance

I/O performance can be critical to a database application. Azure SQL abstracts you from physical file placement, but there are methods to ensure you get the I/O performance you need.

Input/output per second (IOPS) might be important to your application. Be sure you have chosen the right service tier and vCores for your IOPS needs. Understand how to measure IOPS for your queries on-premises if you are migrating to Azure. If you have restrictions on IOPS, you might see long I/O waits. Scale up vCores or move to Business Critical or Hyperscale if you don't have enough IOPS.

I/O latency is another key component for I/O performance. For faster I/O latency for Azure SQL Database, consider Business Critical or Hyperscale. For faster I/O latency for SQL Managed Instance, move to Business Critical or increase the file size or the number of files for the database. Improving transaction log latency might require you to use multi-statement transactions.

## Increase memory or workers

Having enough memory or workers might be important to your application and deployment. For Azure SQL Database, scale up vCores for higher memory limits or workers. For SQL Managed Instance, scale up vCores for higher memory limits. Currently, SQL Managed Instance also supports increasing workers with "max worker threads."

## Improve application latency

Even if you configure your deployment for all your resource needs, applications might introduce latency performance issues. Be sure to follow these best practices with Azure SQL applications:

- Use a redirect connection type instead of proxy.
- Optimize "chatty" applications by using stored procedures, or by limiting the number of query round trips through techniques like batches.
- Optimize transactions by grouping them, as opposed to singleton transactions.

## Tune like it is SQL Server

Azure SQL is still SQL Server. There is almost never a substitute for ensuring you tune your SQL Server queries and look at the following:

- Proper index design.
- Using batches.
- Using stored procedures.
- Parameterizing queries to avoid too many cached *ad hoc* queries.
- Processing results in your application quickly and correctly.

You will now go through an exercise to take the performance problem from the first exercise and improve it by scaling CPUs for Azure SQL.

In this section you will learn more information about how to accelerate and tune performance for Azure SQL as compared to SQL Server.

## Scaling CPU Capacity

You may need to scale the number of CPUs for your resource needs. Azure SQL allows you to do this with no migration on your part.

- You can use the portal, T-SQL, CLI, or REST APIs to scale your number of vCores up or down
- Downtime is typically required but can be very fast for Azure SQL Database
- Hyperscale allows you to scale up in constant time regardless of data size.
- Serverless allows for autoscaling based on CPU demand.

## I/O Performance

I/O performance can be critical to a database application. Azure SQL abstract you from physical file placement but there are methods to ensure you get the I/O performance you need

- Input/Output per Second (IOPS) may be important to your application. Be sure you have chosen the right service tier and vCores. Understand how to measure IOPS for your queries. If you have restrictions on IOPS you may see long I/O waits.
- Scale up vCores or move to Business Critical or Hyperscale if you don't have enough IOPs
- For faster I/O latency for Azure SQL Database, consider Business Critical or Hyperscale.
- For faster I/O latency for Managed Instance, move to Business Critical or increase file size or number of files for the database.
- Improving transaction log latency may require you to use multi-statement transactions.

## Increase Memory or Workers

Having enough memory or workers may be important to your application

- For Azure SQL Database, scale up vCores for higher memory limits or workers
- For Managed Instance, scale up vCores for higher memory limits
- Managed Instance also supports increase workers with 'max worker threads'

**Note**: Managed Instance in the future may limit workers based on vCores

## Improving Application Latency

Application query latency can be improved by:

- Using a redirect connection type instead of proxy
- Optimize "chatty" applications by using stored procedures or limiting the number of query round trips through techniques like batches.

## Tune like it is SQL Server

Azure SQL is still SQL Server. There is almost never a substitute for ensuring you tune your SQL Server queries and look at:

- Proper index design
- Using batches
- Using stored procedures
- Parameterize queries to avoid too many cached ad-hoc queries
- Process results in your application quickly and correctly

You will now go through an exercise to take the performance problem from the first exercise and improve it by scaling CPUs for Azure SQL.
Suppose you are a database administrator for a law firm, and you have upgraded some of the databases in your company. You now need to ensure everything is working normally before you reconfigure your applications to use the new databases. As well as finding and fixing broken queries and replacing deprecated features, you need the database performance to be equal or better than the existing version. 

You want a tool to automate this process, as it would not be possible to thoroughly test multiple applications, before users need to resume working.

## Post-migration tasks

Before your applications begin consuming the new target databases, you must find and fix any compatibility issues. If you are performing a large-scale upgrade operation on company critical databases, this is particularly crucial as you want the least downtime possible. Furthermore, you want to retain current performance levels or make improvements where possible.

It would be natural to assume that moving your database to new hardware and the latest version of SQL Server would increase the performance. However, this can catch out DBAs, as new features may be redesigned in a way that degrades the performance of older databases. Your stored procedures may not be optimal on the new server and testing this beforehand helps you avoid only finding out after the change has gone live and users are suffering the consequences of slow to respond queries.

## Optimize using Database Experimentation Assistant

The Database Experimentation Assistant (DEA) enables you to automate the process of testing the workload of your current database on a target server. It is specifically designed for **A/B** testing, and it enables you to test how the database will perform on an upgraded version of SQL Server, or different hardware, or with new features added, such as a new index. The crucial point of A/B testing is that you change ***one thing***: this gives you have a baseline against which you test a single variant.

![Database Experimentation Assistant](../media/5-dea-screenshot.png)

In practice, a server may have developers and DBAs making changes on a continuous basis, and when a query slows down, it can be difficult to pinpoint the change that causes the degradation. For the purpose of testing your database on an upgraded version, you can create the new database and replay a sample of the current workload on the upgraded database using DEA.

DEA compares a source and target database that are identical except for one variation - the upgraded database. You run a trace on your source production server to capture the queries that form a typical workload. Running the trace has a minimal impact on the server, so you can run tracing even during heavy demand periods. The DEA tool finds degraded queries and generates drill-through reports to highlight code that runs slower in the target environment, so you can optimize the code before you switch your production system to the target database.

## How to run realistic tests

For your law firm, you originally had a complex situation with many databases spread over servers running multiple versions of SQL Server.

Before you execute any upgrades, make sure that you use DEA to analyze the performance of the original system. Then you can compare the performance after you have performed the upgrade. This will ensure that your change has not had a negative impact on performance.

## Summary

The DEA tool reduces administrative time and eliminates human error, by automating much of the testing process after you have upgraded your databases. By generating an analysis report that highlights query errors, query plan information, and statistics, you can quickly fix and tune queries and have applications operational again. DEA is designed for A/B testing, so you can test the impact of a single change to your database, making it ideal for optimizing your databases prior to performing an upgrade.
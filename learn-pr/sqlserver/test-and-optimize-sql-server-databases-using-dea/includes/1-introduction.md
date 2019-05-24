Suppose you work at a telecommunications company, providing database support to the customer call center. For the last three years running, the company has won a number of industry and consumer awards for the high standard of customer service it has delivered. However, the call center software is using a version of SQL Server that is soon to be unsupported and the underlying hardware needs upgrading.

You need to upgrade the call center database to SQL Server 2017 without losing any performance, because the company is keen to maintain its award-winning standards. In order to reassure the stakeholders within the company that the call center software will remain responsive after the upgrade, you need to test the current workload on an upgraded database.

To solve this problem, you will install the **Microsoft Database Experimentation Assistant (DEA)** on your machine. This will run a trace capture against the workload on your existing database, which can then be run against the upgraded version to test the performance.

Here, you will see how the Database Experimentation Assistant can compare a typical workload between the existing and upgraded version of a database.

## Learning Objectives

In this module, you will:

- Decide if DEA is the right tool for your workload testing
- Install DEA on your client machine
- Test a typical workload on an upgraded database
- Review the results of a trace analysis report

## Prerequisites

- Experience administering SQL Server databases
- Knowledge of SQL Server Profiler and trace files
- Understanding of database performance

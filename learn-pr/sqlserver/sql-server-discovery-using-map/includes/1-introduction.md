Suppose you have just been hired as database administrator for an international company that has SQL Server instances located across the globe. The outgoing DBA has provided you with a list of server names and logins in a spreadsheet. You have no other detailed or up-to-date information about these servers and you want to take an inventory of the version, edition, services packs, installed components, and underlying hardware for each instance.

You begin by connecting to each server, but find that this manual process is taking too long and that you are repeating the same tasks each time. You also realize that you'll need to repeat this exercise on a regular basis, to ensure you have current data in line with hardware upgrades undertaken by the operations teams, as well as changes you apply to SQL Server.

You can solve this problem by installing the **Microsoft Assessment and Planning (MAP)** toolkit on your local machine and connecting to each instance to audit. The toolkit will analyze each instance and return a report that can be exported to Excel. You want to automate this process, because some of the SQL Servers you have already discovered need to be upgraded, and the process needs repeating to maintain a current inventory.

Here, you will see how to leverage the Microsoft Assessment and Planning toolkit to audit your database landscape, and repeat this process time and again in future.

## Learning Objectives

In this module, you will:

- Decide if MAP is the best tool to use for a given administration task
- Install MAP on your client machine
- Connect to instances of SQL Server
- Automate the collection of inventory data about your database landscape

## Prerequisites

- Experience administering SQL Server databases
- Knowledge of SQL Server editions and versions
- Understanding of SQL Server configuration settings
Containers are a lightweight way to deploy and manage virtualized servers for hosting services such as databases. They are smaller and more agile than Virtual Machines (VMs) because they share an operating system and hardware with the host computer.

Suppose you are a systems architect for a software company that develops a photo sharing application. Users who subscribe to your service can use a website or a mobile application to upload photos to your application and share them with their friends. Your developers want a way to automate the deployment of new versions of the software into the environments where integration and acceptance tests take place. They want such testing deployments to be rapid and consistent.

You are evaluating using containers to solve these issues.

In the testing environments, you want to deploy containers that include SQL Server, then script the creation of the database, its schema, and sample data. Because a container is lightweight, it can be deployed quickly and provide a clean environment in which to run tests.

In this module, you will learn how to run SQL Server 2017 on Linux containers.

## Learning objectives

At the end of this module, you will be able to:

- Install the Docker system on a Linux server.
- Manage Docker containers.
- Create a container from an image that includes SQL Server 2017.
- Create a customized container image.
- Run a database application with a web front end in containers.

## Prerequisites

Before you begin this module, you must be able to:

- Execute commands in a Linux shell such as Bash.
- Execute Transact-SQL commands against a SQL Server database.
- Use SQL Server Management Studio or Azure Data Studio to connect to a SQL Server.
- Understand basic networking concepts, such as IP addresses and port numbers.

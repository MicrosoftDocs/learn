SQL Server Integration Services (SSIS) is a platform for building complex Extract Transform and Load (ETL) solutions. SSIS is a component within SQL Server and consists of a Windows service that manages the execution of ETL workflows, along with several tools and components for developing those workflows. It is typically used to develop data integration pipelines for on-premises data warehousing solutions. It can also be used to create data migration pipelines when migrating data between different systems.

SSIS is primarily a control flow engine that manages the execution of workflows. Workflows are held in packages, which can be executed on demand, or on a schedule. Development of SSIS packages, the task workflow is referred to as the control flow of the package. A control flow can include a specific task to manage data flow operations. SSIS executes these Data Flow tasks by using a data flow engine that encapsulates the data flow in a pipeline. Each step in the Data Flow task operates in sequence on a rowset of data as it passes through the pipeline.

A SSIS solution usually consists of one or more SSIS projects, each containing one or more SSIS packages. 

## SSIS projects

From SQL Server 2012, a project is the unit of deployment for SSIS solutions. You can define project-level parameters to enable users to specify run-time settings, and project-level connection managers that reference data sources and destinations used in package data flows. You can then deploy projects to an SSIS catalog in a SQL Server instance, and configure project-level parameter values and connections as appropriate for execution environments.

## SSIS packages

A project contains one or more packages, each defining a workflow of tasks to be executed. The workflow of tasks in a package is referred to as its control flow. A package control flow can include one or more Data Flow task, each of which encapsulates its own data flow pipeline. Packages can include package-level parameters so that dynamic values can be passed to the package at run time. In previous releases of SSIS, deployment was managed at the package level. 


---
ms.custom:
  - build-2023
---
Data pipelines define a sequence of activities that orchestrate an overall process, usually by extracting data from one or more sources and loading it into a destination; often transforming it along the way. Pipelines are commonly used to automate *extract*, *transform*, and *load* (ETL) processes that ingest transactional data from operational data stores into an analytical data store, such as a lakehouse or data warehouse.

If you're already familiar with Azure Data Factory, then data pipelines in Microsoft Fabric will be immediately familiar. They use the same architecture of connected activities to define a process that can include multiple kinds of data processing tasks and control flow logic. You can run pipelines interactively in the Microsoft Fabric user interface, or schedule them to run automatically.

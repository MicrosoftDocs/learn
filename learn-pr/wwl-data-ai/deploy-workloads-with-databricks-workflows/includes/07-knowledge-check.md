### YamlMime:ModuleUnit
uid: learn.wwl.deploy-workloads-with-azure-databricks-workflows.knowledge-check
title: Knowledge check
metadata:
  title: Knowledge check
  description: "Knowledge check"
  ms.date: 08/29/2023
  author: wwlpublish
  ms.author: jamesh
  ms.topic: unit
azureSandbox: false
labModal: false
durationInMinutes: 3
quiz:
  questions:
  - content: "Which feature allows you to configure a Databricks workflow to execute tasks based on the successful completion of other tasks?"
    choices:
    - content: "Libraries"
      isCorrect: false
      explanation: "Incorrect. Libraries in Databricks contain packages or modules that can be used by notebooks and jobs. These can include Python packages, Java/Scala libraries, or R packages."
    - content: "Clusters"
      isCorrect: false
      explanation: "Incorrect. Azure Databricks can automatically manage the creation and termination of clusters for running tasks and are fine-tuned for performance based on the workload."
    - content: "Dependency"
      isCorrect: true
      explanation: "Correct. Dependency in Azure Databricks Workflows enable the configuration of jobs to run automatically based on certain conditions, such as the success or failure of other jobs. This feature is essential for managing tasks within complex workflows, ensuring they are executed in the correct order."
  - content: "Which Azure Databricks component is essential for scaling computational resources according to workload demands?"
    choices:
    - content: "Notebooks"
      isCorrect: false
      explanation: "Incorrect. Databricks notebooks are collaborative documents that contain runnable code, visualizations, and narrative text mainly used to orchestrate complex data transformations and visualizations."
    - content: "Jobs"
      isCorrect: false
      explanation: "Incorrect. Jobs are the primary component in Databricks Workflows. They allow you to define and schedule automated tasks such as running notebooks, scripts, or compiled JARs."
    - content: "Clusters"
      isCorrect: true
      explanation: "Correct. Clusters in Azure Databricks are groups of virtual machines that provide computational resources for running workflows. They can be configured to auto-scale, which means they automatically adjust the number of nodes in the cluster based on the workload, ensuring efficient use of resources and optimal performance."
  - content: "What is the primary use of the Databricks REST API in the context of Databricks Workflows?"
    choices:
    - content: "To manually execute SQL queries"
      isCorrect: false
      explanation: "Incorrect. Databricks REST API is not primarily used to execute SQL queries manually."
    - content: "To create, manage, and execute jobs programmatically"
      isCorrect: true
      explanation: "Correct. The Databricks REST API provides a programmatic interface to create, manage, and execute jobs in Azure Databricks. This capability is crucial for automating workflows and integrating Databricks tasks with other applications and services, allowing for a more flexible and scalable deployment of data workflows."
    - content: "To visualize data within Databricks notebooks"
      isCorrect: false
      explanation: "Incorrect. Databricks REST API is not primarily used to visualize data within Databricks notebooks."


DP-203: Module 5 Ingest and load data into the data warehouse 

Module 5 Overview 

As you begin to teach this module, get familiar with what the students will learn during the module. In this module students will learn about ingesting and loading data into the data warehouse and the massively parallel processing (MPP) service architecture. 

This module consists of two lessons: 

- Lesson 1 – Use data loading best practices in Azure Synapse Analytics 
- Lesson 2 – Petabyte-scale ingestion with Azure Data Factory 

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE5auXv] 

Module 5 Tips and Tricks 

- Nothing will out-perform Polybase or COPY to import data because of the MPP architecture 
- Remember that everything on scale and performance is based on 60 buckets in a distribution 
- The number of nodes in a dedicated SQL pool will always be a factor of 60 
- Documentation will always recommend some multiple of 60 equally sized files for loading 
- Pipelines are built on Azure Data Factory 
- Pipelines and ADF also understand COPY and Polybase 

Module 5 Demo 

- Demo loading data into warehouse using SQL Script and Polybase 

Module 5 Lab/Exercise 

- Ingest and load data into the data warehouse (~45 min) 
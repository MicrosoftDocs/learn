

DP-203: Module 2 Run interactive queries using Azure Synapse Analytics serverless SQL pools 

Module 2 Overview 

As you begin to teach this module, get familiar with what the students will learn during the module. In this module students will learn how to run interactive queries using Azure Synapse Analytics serverless SQL pools. 

This module consists of four lessons: 

- Lesson 1 – Explore Azure Synapse serverless SQL pools capabilities 
- Lesson 2 – Query data in the lake using Azure Synapse Analytics serverless SQL pools 
- Lesson 3 – Create metadata objects in Azure Synapse Analytics serverless SQL pools 
- Lesson 4 – Secure data and manage users in Azure Synapse serverless SQL pools 

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE5axAs] 

Module 2 Tips and Tricks 

- Serverless is for data exploration or transformation 
- Dedicated is for data warehousing workloads 
- Understand the dependencies and order for metadata object creation  
	- They remain the same for serverless or dedicated 
- Strongly prefer Azure Active Directory Authentication 

Module 2 Demos 

- Run “SELECT @@VERSION” on serverless and dedicated pools to show underlying technologies 
- Demonstrate opening a file in Data Lake and show the syntax of the generated statement  
	- Note that OPENROWSET will only work in serverless pools as it is available in Azure SQL Database, but not in Dedicated SQL pools 

Module 2 Lab/Exercise 

- Run interactive queries using Azure Synapse Analytics serverless SQL pools (~45) 
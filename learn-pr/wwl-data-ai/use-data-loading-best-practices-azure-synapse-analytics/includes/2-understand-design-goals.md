Optimizing and speeding up data loads to minimize the impact on the performance of ongoing queries is a key design goal in data warehousing.

Analytical systems are constantly balanced between loading and querying workloads. Some analytical systems have loading requirements that require data to be available in near real-time, others periodically throughout the business day, or at the end of the month. Most systems you will find have a mixture of these dependants on the data sources being ingested, and type of work being done with the data.

Loading data is essential because of the need to query or analyze the data to gain insights from it, so one of the main design goals in loading data, is to manage or minimize the impact on analytical workloads while loading the data with the highest throughput possible.

Some of the questions that need to be asked when considering data loading include:

-	Where is my data coming from?
-	Is the data net new? or do you receive changes from existing datasets?
-	How often is the data being refreshed, added to or replaced?
-	What formats are the data coming in?
-	Is the data ingestible as-is? or are transformations and cleansing tasks required?
-	Should I transform the data prior to or after loading?
-	How complex or robust does the loading process have to be?
-	Which takes priority, loading or querying/analysis?

By answering these questions, you’ll understand the design goals and considerations to the process of designing appropriate workflows and pipelines and which tools and methods you’ll need to utilize.

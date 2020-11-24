When you want to run notebooks in the Synapse Studio environment, you are able to run the code cells in your notebook individually or all at once. 
The status and progress of each cell will also be represented in the notebook.

The different functionalities for running a notebook are as follows:
* Run a Cell
If you want to run once cell of code or text, you can do so through the notebook experience in Azure Synapse Studio.
* Run all cells. If you have developed code that consists of multiple cells or is combined with text, you can do so through the notebook experience in Azure Synapse Studio.
* Cancel a running cell. If you hit run, but while the cell is running, you want to cancel one cell run, you can do so within Azure Synapse notebooks.
* Cell Status indicator
If you want to check the status of a cell while running or completed, you have the possibility to get a status indicator within the notebook experience in Synapse Studio.
* Spark progress indicator
Azure Synapse Studio notebook is purely Spark based. 
Remotely, the code cells that are executed, are executed on the serverless Apache Spark pool. If you want to see the progress of a spark job, you can see in real time the job execution status below a cell. 
The number of tasks per each job or stage help you to identify the parallel level of your spark job. You can also drill deeper to the Spark UI of a specific job (or stage) via selecting the link on the job (or stage) name.


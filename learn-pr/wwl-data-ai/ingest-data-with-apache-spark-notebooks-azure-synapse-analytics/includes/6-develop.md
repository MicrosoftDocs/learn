In order to understand the development of notebooks you need to understand that it consists of cells. 
Cells are individual blocks of code or text that can be ran independently or as a group.

In order to develop notebooks, there are a couple of things to take in mind
* Adding cells to notebooks
This will give you the opportunity to add code in a different cell. 
There are multiple ways to add a new cell to your notebook, which we will cover in the next topic. 

* Setting a primary language Azure Synapse Studio notebook has support for four Apache Spark languages to be set as primary languages in a notebook. 

These are pySpark (Python), Spark (Scala), SparkSQL, and .NET for Apache Spark (C#)
* Using multiple languages
Within a notebook you are enabled to use multiple languages. 
The one thing to take in mind is that you need to use magic commands, as explained in the previous topic, at the beginning of a cell. 

* Using temp tables to reference data across languages. It is not possible to reference data or variables directly across different languages in a Synapse Studio notebook. 
In Spark, it is possible to reference a temporary table across languages, like you've seen in the previous topic. 

* IDE-Style IntelliSense
When you use Azure Synapse Studio notebooks, you'll see the integration with the Monaco editor.
It enables you to bring IDE-style IntelliSense to the cell editor. 
This helps you in cases of Syntax highlight, error marker, and automatic code completions to help you to write code and identify issues quicker.
You do have to take in mind that The IntelliSense features are sometimes at different levels of maturity for different languages.
So depending on the language you want to write your code in, in the Azure Synapse Studio Notebooks environment you could check the following table that explains what is supported using the types of language at your convenience. 

|Languages| Syntax Highlight | Syntax Error Marker  | Syntax Code Completion | Variable Code Completion| System Function Code Completion| User Function Code Completion| Smart Indent | Code Folding|
|--|--|--|--|--|--|--|--|--|
|PySpark (Python)|Yes|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Spark (Scala)|Yes|Yes|Yes|Yes|-|-|-|Yes|
|SparkSQL|Yes|Yes|-|-|-|-|-|-|
|.NET for Spark (C#)|Yes|-|-|-|-|-|-|-|

* Undo Cell operations. When you, for example,  need to revoke a cell operation, you can do so within the Azure Synapse Studio notebook environment. 

* Move a cell. If you want to align different cells of code and put them in a correct order, the notebook environment gives you the opportunity to do so. 

* Delete a cell. If you have written a cell of code, but no longer need it or it needs to be deleted, the functionality can be used within the notebook environment. 

* Collapse Cell in and output
If you want to collapse a cell to check in or output, the functionality is available to you when using the notebook environment in Synapse Studio. 



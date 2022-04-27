To develop solutions in a notebook, you work with cells. Cells are individual blocks of code or text that can be run independently or as a group. There are a range of actions that can be performed against a cell including:


* Move a cell. 

    If you want to align different cells of code and put them in a correct order, the notebook environment gives you the opportunity to move cells to organize your work. 

* Delete a cell. 

    If you have written a cell of code, but no longer need it or it needs to be deleted, the delete functionality can be used within the notebook environment. 

* Collapse Cell in and output.

    If you want to collapse a cell to check in or output, the functionality is available to you when using the notebook environment in Azure Synapse Studio. 

* Undo Cell operations. 

    When, for example, you need to revoke a cell operation, you can do so within the Azure Synapse Studio notebook environment. 


When you use Azure Synapse Studio notebooks, you'll see the integration with the Monaco editor. The Monaco editor enables you to bring an IDE-style IntelliSense to the cell editor. The IDE-style IntelliSense helps you in cases of syntax highlighting, error handling and marking, and automatic code completions to help you write code and identify issues quickly.
The IntelliSense features are at different levels of maturity for different languages. So depending on the language you want to write your code in, there may be different IntelliSense features. The following table shows what is supported based on language. 

|Languages| Syntax Highlight | Syntax Error Marker  | Syntax Code Completion | Variable Code Completion| System Function Code Completion| User Function Code Completion| Smart Indent | Code Folding|
|--|--|--|--|--|--|--|--|--|
|PySpark (Python)|Yes|Yes|Yes|Yes|Yes|Yes|Yes|Yes|
|Spark (Scala)|Yes|Yes|Yes|Yes|Yes|Yes|-|Yes|
|SparkSQL|Yes|Yes|Yes|Yes|Yes|-|-|-|
|.NET for Spark (C#)|Yes|Yes|Yes|Yes|Yes|Yes|Yes|Yes|





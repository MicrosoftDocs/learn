Exercise - Validation of Microsoft Purview Scanning

One of the major aspects we are wanting to achieve by setting up this stack, is an end to end lineage of data movement through the data estate. If we look at what we have just done so far in the exercise, we can agre that we have our data in the container storage and that it has also now moved through CluedIn and back out to the same Container Storage - but in a different folder i.e. it has come from a folder called "raw" and we now have a new copy of that data in a folder called "mastered".

Because we only ran our scan in Microsoft Purview once, head back to your scan and we will once again select "Run Once" to scan the Storage Account. You could have also setup a scheulde to scan the sources every 1 hour, in which, chances are the system would have already foudn the new files by the time you got to this point. Either way, you will want to Run the scan again just to make sure that it picks up the new files. 

Now that we have data free flowing from ADLS Gen2 into CluedIn, via Microsoft Purview and then back into ADLS Gen2, we need to validate that Microsoft Purview is also automatically picking up on the mastered data coming out of CluedIn. 

Refresh your Data Map, in which you should now see a CluedIn Collection on your data map. More importantly search Microsoft Purview Assets for "Employee" in which you will see that it has found our Employees.csv in the Raw folder, it has now found files with the mastered directory as well. 

Select the Employees.csv file first, in which you will find that when you select the lineage tab, there is some detailed lineage of the exercise we just took within CluedIn i.e. we can see that Employees.csv was mapped into an Entity Type called /Employee and that it was also exported out to the same Conatiner Storage that it came from in a dolder called Mastered. 

![Purview_Employees](../media/Purview_Employees.png)
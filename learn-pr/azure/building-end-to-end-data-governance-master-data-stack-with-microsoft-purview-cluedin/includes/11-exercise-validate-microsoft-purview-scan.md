Exercise - Validation of Microsoft Purview Scanning

Now that we have data free flowing from ADLS Gen2 into CluedIn, via Microsoft Purview and then back into ADLS Gen2, we need to validate that Microsoft Purview is also automatically picking up on the mastered data coming out of CluedIn. 

Refresh your Data Map, in which you should now see a CluedIn Collection on your data map. More importantly search Purview Assets for Organization, Person and PowerPoint, in which you will see assets that contain the amalgumation of those 100 Purview Assets, un-curated, decoupled and duplicated now in very clean Domain assets. 

As an end user, we can now navigate to the Organization Domain Asset, inspect the properties and metadata and see that not only is this asset from our Mastered directory, but it clearly has a lot of other services wrapped around it, including the owners, the data quality metrics from CluedIn, the lineage of movement of data, even through the mapping in CluedIn. 
Exercise - Streaming Data out from CluedIn to ADLS Gen2

It may sound odd that we are going to stream data out into ADLS Gen2 in a folder called mastered, when there are still so many problems with the data that need to be addressed. At the same time, we need to realise that agility and time to value is of upmost importance in todays modern technology stack. This speaks to CluedIn's agility, in that we can, within moments, have a pipeline setup that is delivering some value very quickly - not locking up the data until we have fixed every single possible data issue. Let's be honest, the data is already in a better level od usability and we have not even done anything but map the data so far. 

Navigate to your Export Targets and select "Add Export Target". 

Choose Azure ADLS Gen2 and choose the ADLS Gen2 from the drop down. 

Select "Streams" in the Left-Hand Menu and Create a New Stream. 

A Stream in CluedIn will allow an end user to setup a Push-based delivery of data to a target. In this case, it will deliver it to one or more Export Targets. 

A stream requires that you provide it with a Filter (Which records you would like to share), an Export Target (where to send it), a project (What data in those records to share). In addition to this, users can optionally make final transformations or actions on the data to be applied to the data leaving the platform (but will not make any changes to that same data in the CluedIn platform). For example, imagine that you wanted to format the data in a specific way on the way out to a particular target, or you may even want to mask or anonymise certain records values on the way out to a specific target, but not in CluedIn itself. 

Navigate to your ADLS Gen2 and you should see a folder called Mastered as well as respectively named files created for the data. Because this is a stream of live data, CluedIn will create regular data files. You will need to stitch these together yourself when you are wanting to utilise them. 

Your end consumers can already start to use this data, with all its glory and failures. However we can say at this point already that the end users will prefer to use this than the original 100 files in our raw folder. 
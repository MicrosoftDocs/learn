Exercise - Streaming Data out from CluedIn to ADLS Gen2

It may sound odd that we are going to do this so early in the learning module, but we are now going to setup an outgoing stream of data back into ADLS Gen2 in a folder called mastered, even though there are still so many problems with the data that need to be addressed. At the same time, we need to realise that agility and time to value is of upmost importance in todays modern technology stack. This speaks to CluedIn's agility, in that we can, within moments, have a pipeline setup that is delivering some value very quickly - not locking up the data until we have fixed every single possible data issue. Let's be honest, the data is already in a better level od usability and we have not even done anything but map the data so far. 

1. Navigate to your Export Targets and select "Add Export Target". 

    ![Export_Target_Data_Lake](../media/Export_Target_Data_Lake.png)

1. Choose the Azure Data Lake Connector. Enter the details of your Container Storage into the form and select "Test Connection". If you get a green light, you are good to then move on. 

    ![Export_Target_Details](../media/Export_Target_Details.png)

1. Select "Streams" in the Left-Hand Menu of CluedIn and Create a New Stream called "Employees"

    ![Employee_Stream](../media/Employee_Stream.png)

    A Stream in CluedIn will allow an end user to setup a Push-based delivery of data to a target. In this case, it will deliver it to one or more Export Targets. 

    A stream requires that you provide it with a Filter (Which records you would like to share), an Export Target (where to send it), a projection (What data in those records to share). In addition to this, users can optionally make final transformations or actions on the data to be applied to the data leaving the platform (but will not make any changes to that same data in the CluedIn platform). For example, imagine that you wanted to format the data in a specific way on the way out to a particular target, or you may even want to mask or anonymise certain records values on the way out to a specific target, but not in CluedIn itself. 

    ![Stream_Filter](../media/Stream_Filter.png)

1. You will want to set a filter using the Conditions on the first tab of your newly created stream with a value of "Property", with a value of "Entity Type" and set the operator to "Equals". In the value for the Entity Type, choose Employee and save. Move to the Export Target tab, in which you will want to choose the Azure Data Lake Connector that you just added. 

    As you step through the wizard, it will then ask you to specific a Container name. This is essentially the folder in the Data Lake that we would like to stream our results back to. 

    >[!NOTE]
    > You will need to manually create the target folder in your Storage Account so that CluedIn has a container to write its data into. 

    ![Choose_Target](../media/Choose_Target.png)

1. Create a folder called "mastered" in your Storage Account and then use this exact folder name as the name of your Container name in your new stream. 

    When setting up the stream, it will also ask you to specify a mode of stream. Choose "Synchronization".

1. In the projection, it will ask you what Entity Properties and Vocabulary Keys you would like to share. Add employee.Job to the list (and any others that you would like). 

1. Select Save. 

    >[!NOTE]
    > You can look at the Data Tab to get a preview of the exact data that will be shared downstream. 

    ![Stream_Setup](../media/Stream_Setup.png)

1. Toggle the Inactive button and your stream will be activated. 

Navigate to your ADLS Gen2 and you should see a folder called Mastered as well as respectively named files created for the data. Because this is a stream of live data, CluedIn will create regular data files. You will need to stitch these together yourself when you are wanting to utilise them. 

Your end consumers can already start to use this data, with all its glory and failures. However we can say at this point already that the end users will prefer to use this than the original 100 files in our raw folder. 
---
services: storage
platforms: dotnet
author: robinsh
---

# Using the Circuit Breaker pattern in your HA apps with RA-GRS Storage

This sample shows how to use the Circuit Breaker pattern with an RA-GRS storage account to switch your high-availability application to secondary storage when there is a problem with primary storage, and then switch back when primary storage becomes available again. For more information, please see [Designing HA Apps with RA-GRS storage](https://docs.microsoft.com/azure/storage/common/storage-designing-ha-apps-with-ragrs).

If you don't have a Microsoft Azure subscription, you can get a FREE trial account <a href="http://go.microsoft.com/fwlink/?LinkId=330212">here</a>.

## How it works

This application uploads a file to a container in blob storage to use for the test. Then it proceeds to loop, downloading the file repeatedly, reading against primary storage. If there is an error reading the primary, a retry is performed, and your threshold has been exceeded, it will switch to secondary storage.

The application will continue to read from the secondary until it exceeds that threshold, and then it switches back to primary.

In the case included here, the thresholds are arbitrary numbers for the count of allowable retries against the primary before switching to the secondary, and the count of allowable reads against the secondary before switching back. You can use any algorithm to determine your thresholds; the purpose of this sample is just to show you how to capture the events and switch back and forth.

## How to run the sample

1. If you don't already have it installed, [install Fiddler](http://www.telerik.com/fiddler).
 
	This is used to modify the response from the service to indicate a failure, so it triggers the failover to secondary. 

2. Add an environment variable called **storageconnectionstring** string to your machine and put your storage connection string as the value. Change the `DefaultEndpointsProtocol` value from **https** to **http** within the connection string to ensure Fiddler can intercept the traffic. The account must have RA-GRS enabled, or the sample will fail.

    **Linux**
    
    ```bash
    export storageconnectionstring="DefaultEndpointsProtocol=http;AccountName=<mystorageaccount>;AccountKey=<myAccountKey>;EndpointSuffix=core.windows.net"
    ```
    **Windows**
    
    ```cmd
    setx storageconnectionstring "DefaultEndpointsProtocol=http;AccountName=<mystorageaccount>;AccountKey=<myAccountKey>;EndpointSuffix=core.windows.net"
    ```

3. Run Fiddler.

4. Start the application in Visual Studio. It displays a console window showing the count of requests made against the storage service to download the file, and tells whether you are accessing the primary or secondary endpoint. You can also see this in the Fiddler trace. 

5. Press any key to pause the application. 

6. Go to Fiddler and select Rules > Customize Rules. Look for the OnBeforeResponse function and insert this code. (An example of the OnBeforeResponse method is included in the project in the Fiddler_script.txt file.)

	if ((oSession.hostname == "YOURSTORAGEACCOUNTNAME.blob.core.windows.net") 
	&& (oSession.PathAndQuery.Contains("HelloWorld"))) {
	   oSession.responseCode = 503;  
        }

	Change YOURSTORAGEACCOUNTNAME to your storage account name, and uncomment out this code. Save your changes to the script. 

7. Return to your application and press any key to continue running it. In the output, you will see the errors against primary that come from the intercept in Fiddler. Then you will see the switch to secondary storage. After the number of reads exceeds the threshold, you will see it switch back to primary. It does this repeatedly. 

8. Pause the running application again. Go back into Fiddler and comment out the code and save the script. Continue running the application. You will see it switch back to primary and run successfully against primary again.

If you run this repeatedly, be sure the script change is commented out before you start the application.


## More information
- [About Azure storage accounts](https://docs.microsoft.com/azure/storage/storage-create-storage-account)
- [Designing HA Apps with RA-GRS storage](https://docs.microsoft.com/azure/storage/common/storage-designing-ha-apps-with-ragrs)
- [Azure Storage Replication](https://docs.microsoft.com/azure/storage/storage-redundancy)

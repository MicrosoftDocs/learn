As the Solution Architect for EasyHealthCare, you now want to start implementing the design to deploy a highly available application. As a first step, you're going to download and install Fiddler which will be used run the steps to deploy and test the application.

In this unit, you’ll use sample code from GitHub that shows how you can use the Circuit Breaker pattern with an RA-GRS account.  It will switch to the secondary storage account when a problem is detected and failback when the primary account is available again.

This application uploads a file to blob storage, it then loops, downloading the file. When there is an error reading the primary storage account, a retry is performed.  When the threshold has been exceeded, it will switch to secondary storage account.
The application will read from the secondary storage account until it exceeds that threshold, and then switches back to primary.

Download the sample code from here and save to your local drive: 

`https://github.com/Azure-Samples/storage-dotnet-circuit-breaker-ha-ra-grs`

![Failover Visual](../media/5-exercise-failover-visual.png)

## Install Fiddler & Visual Studio

First you'll install Fiddler which will be used to monitor the storage account for any failures.
This needs to be intalled on your local computer along with Visual Studio 2019

1. If you don't have Fiddler installed already, download it and install from here:

    `https://www.telerik.com/fiddler`

2. Visual Studio 2019 can be downloaded and installed from here:
    
   `https://visualstudio.microsoft.com/vs/`


## Add an Environment variable

Now that you have installed Fiddler and Visual Studio, your next step is to add an Environment variable to the system configuration on the local computer.

Before creating an environment variable, you need to retrieve your Azure storage account connection string.

1. From the Azure Cloud Shell, run the below command to obtain the Azure storage account connection string

````
    az storage account show-connection-string \
    --name $STORAGEACCT \
    --resource-group [sandbox resource group]
````
2. Copy the output connection string

You are now ready to create the environment variable on the local computer

5. Open Powershell on the local computer
6. Paste in the connection string you copied from step 1, but append the connection string with the word **setx**.  You will end up with the below command in your powershell command prompt:

````
setx storageconnectionstring "DefaultEndpointsProtocol=http;AccountName=<sandbox account name>;AccountKey=<sandbox storage account key>;EndpointSuffix=core.windows.net"
````
7. You need to ensure the **DefaultEndpointsProtocol** is set to **http** as shown above, else Fiddler will fail to intercept the traffic. 
8. Press Enter to continue

You will receive a **SUCCESS** prompt.  Close the Powershell session down.

## Test the application for failover using Circuit Breaker

Now you will run Fiddler and open the contents of the Github project in Visual Studio to test the application.

1. Run Fiddler
2. Run Visual Studio.  Open the Github CircuitBreaker.csproj application.
3. Once opened, in Visual Studio, click Debug - Start Debugging in Visual Studio or press F5.

This opens a command box and starts loading files to the Azure storage account.  If you have a look at Fiddler, you will see a screen similar to the below:

![Fiddler Visual](../media/5-fiddler-status.png)

Fiddler will show files being uploaded to your primary sandbox storage account.  

4. Press any key to pause the application in Visual Studio
5. Go to Fiddler and select Rules > Customize Rules. Look for the **OnBeforeResponse** function and insert this code:


```csharp
if ((oSession.hostname == "sandbox storage account name"".blob.core.windows.net") && (oSession.PathAndQuery.Contains("HelloWorld"))) { oSession.responseCode = 503;
    }
```
The code is creating blob files and uploading them to the Azure storage account with "HelloWorld" as the content of the file.  Each blob file has its own unique name. The purpose of this is to prove that circuit breakers can be used to force an application to failover to a secondary account when a resource cannot be accessed.

6. Click Save on the file.
7. Return to your application and press any key to continue running it.
8. In Fiddler, you will see errors being generated against the primary Azure storage account, and you will see the switch to the secondary storage account.
9. Pause the application once again.
10. Remove the code from Fiddler which was pasted in from step 5 above. Save the file.
11. Return to your application and press any key to continue running it.
12. In Fiddler, you will see the primary Azure storage account back online.
13. Close down Fiddler and Visual Studio

You've now verified that **Fiddler** acts as the circuit breaker and that the storage account can fail over from primary to secondary when there is a break in the communication with the application.
Now that we have a database, let's modify the Azure Function to call the Custom Vision Service and determine the likelihood that an image contains a polar bear, and to write the output to the Azure SQL database.

1. In the Azure portal, switch to the Azure Function App that you created earlier.

1. Select **Platform features** to open the "Platform features" tab and then click **Console**.

    ![Opening a function console](../media/11-open-function-console.png)

1. Execute the following commands in the function console to install the **request** package, the **tedious** package, and the **Azure Storage SDK for Node.js** so your function can use them, and ignore any warning messages that are displayed. Make sure to execute each one separately to ensure the packages are loaded properly.

    ```bash
    npm install request
    ```

    ```bash
    npm install tedious
    ```

    ```bash
    npm install azure-storage
    ```

    > [!TIP]
    > Azure Functions written in JavaScript execute in a Node.js environment. The function console gives you access to that environment and lets you install NPM packages the same as you would in a local environment.

1. Open the Azure Function contained in the Function App by selecting the function name you created (something like **HttpTrigger1**.

1. Replace the function code with the following code:

    ```javascript
    module.exports = function (context, req) {
        var predictionUrl = 'PREDICTION_URL';
        var predictionKey = 'PREDICTION_KEY';
        var storageAccountName = 'ACCOUNT_NAME';
        var storageAccountKey = 'ACCOUNT_KEY';
        var databaseServer = 'SERVER_NAME.database.windows.net';
        var databaseUsername = 'ADMIN_USERNAME';
        var databasePassword = 'ADMIN_PASSWORD';
        var databaseName = 'photodb';

        // Parse input
        var input = JSON.parse(req.rawBody)[0];
        var id = input.deviceid;
        var latitude = input.latitude;
        var longitude = input.longitude;
        var url = input.url;
        var blobName = url.substr(url.lastIndexOf('/') + 1);
        var timestamp = input.timestamp;

        // Generate a SAS
        var azure = require('azure-storage');
        var blobService = azure.createBlobService(storageAccountName, storageAccountKey);

        var now = new Date();
        var expiry = new Date(now).setMinutes(now.getMinutes() + 3);

        var policy = {
            AccessPolicy: {
                Permissions: azure.BlobUtilities.SharedAccessPermissions.READ,
                Start: now,
                Expiry: expiry
            },
        };

        var sas = blobService.generateSharedAccessSignature('photos', blobName, policy);

        // Call the Custom Vision Service
        const options = {
            url: predictionUrl,
            method: 'POST',
            headers: {
                'Prediction-Key': predictionKey
            },
            body: {
                'Url': url + '?' + sas
            },
            json: true
        };

        var request = require('request');

        request(options, (err, res, body) => {
            if (err) {
                context.log(err);
                context.done();
            }
            else {
                var probability =  body.predictions.find(p => p.tagName.toLowerCase() === 'polar bear').probability;
                var isPolarBear = probability > 0.8; // 80% threshhold

                // Update the database
                var Connection = require('tedious').Connection;
                var Request = require('tedious').Request;

                var config =
                {
                    authentication:
                    {
                        type: 'default',
                        options:
                        {
                            userName: databaseUsername,
                            password: databasePassword
                        }
                    },
                    server: databaseServer,
                    options:
                    {
                        database: databaseName,
                        encrypt: true
                    }
                }

                var connection = new Connection(config);

                connection.on('connect', (err) => {
                    if (err) {
                        context.log(err)
                        context.done();
                    }
                    else {
                        var query = "INSERT INTO dbo.PolarBears (CameraID, Latitude, Longitude, URL, Timestamp, IsPolarBear) " +
                            "VALUES ('" + id + "', " + latitude + ", " + longitude + ", '" + url + "', '" + timestamp + "', " + (isPolarBear ? "1" : "0") + ")";

                        dbRequest = new Request(query, err => {
                            if (err) {
                                context.log(err);
                                context.done();
                            }
                        });

                        dbRequest.on('error', err => {
                            context.log(err);
                            context.done();
                        });

                        dbRequest.on('requestCompleted', () => {
                            context.done();
                        });

                        connection.execSql(dbRequest);
                    }
                });
            }
        });
    };
    ```

1. Click **Save** to save the changes.

### Customize the code for your service

The code uses the **request** package to call the Custom Vision Service you created, passing the URL of the image to be analyzed. It parses the results and retrieves the value indicating the probability that the image contains a polar bear.

Then it uses the **tedious** package to write a record to the database. That record contains the camera ID, the latitude and longitude of the camera, the image URL, a timestamp indicating when the picture was taken, and an `IsPolarBar` value indicating whether the image contains a polar bear. The threshold for determining whether an image contains a polar bear is 80% per this line of code:

```javascript
var isPolarBear = probability > 0.8; // 80% threshhold
```

Another notable aspect of this code is its use of a **shared-access signature**, or _SAS_. The _photos_ container that you created previously is private. To access the blobs stored there, you must have access to the storage account or have the storage account's access key. Shared-access signatures allow anonymous users to access individual blobs, but only for a specified length of time and optionally with read-only access.

The code uses the **Azure Storage SDK for Node.js** to generate a read-only SAS for the blob that is passed to the Custom Vision Service, and appends it to the blob URL as a query string. The SAS is valid for 3 minutes and allows read access only. This allows your code to submit private blobs to the Custom Vision Service for analysis without putting the blobs in a public container where anyone could download them.

To make this work with your created Azure resources, we need to supply some variables. Make the following edits to the code in the Function editor.

1. Replace the following placeholders in the function code with the values below. Then save your changes.

    - Replace `PREDICTION_URL` on line 2 with the prediction URL from your custom vision service.
    - Replace `PREDICTION_KEY` on line 3 with the prediction key from your custom vision service.
    - Replace `ACCOUNT_NAME` on line 4 with the name of the storage account.
    - Replace `ACCOUNT_KEY` on line 5 with the storage account's access key.
    - Replace `SERVER_NAME` on line 6 with the name you assigned to the database server - make sure to keep the `.database.windows.net` suffix.
    - Replace `ADMIN_USERNAME` on line 7 with the database user name you specified.
    - Replace `ADMIN_PASSWORD` on line 8 with the database password you specified.

## Test the connectivity

As a final step, let's test out the connectivity end-to-end.

1. Switch back to your Stream Analytics job in the Azure portal.

1. Start the Stream Analytics job just as you did before.

1. Once the Stream Analytics job is running, switch to the Azure Cloud Shell and make sure you're in the project folder.

1. Start the camera array running with the following command:

    ```bash
    node run.js
    ```

1. **Let the camera array and the Stream Analytics job run for 3 to 5 minutes**. Then stop the Stream Analytics job and stop **run.js**.

1. Return to the database in the Azure portal and use the query editor to execute the following query:

    ```sql
    SELECT * FROM dbo.PolarBears
    ```

1. Confirm that the table contains a few rows representing images that were submitted to the Custom Vision Service for analysis. Look at the `IsPolarBear` column in each row. How many of the images that were analyzed contain a polar bear?

    ![Rows written to the database by the Azure Function](../media/11-data-explorer-query-results.png)

Next you'll use Power BI to produce a more compelling — and graphical — visualization of the data.
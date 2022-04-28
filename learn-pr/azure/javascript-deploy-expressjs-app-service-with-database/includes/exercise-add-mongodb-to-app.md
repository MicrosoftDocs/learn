Add Cosmos DB connection information to your local sample application.

## Copy connection string

1. In Visual Studio Code, select <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>A</kbd> to open the **Azure** pane on the left.
1. In the **Databases** section, right-click the sandbox subscription name. 
1. On your resource, right-click and select **Copy Connection String**.
1. In the Explorer, select the `.env.sample` file and paste the connection string into **MONGODB_URI_CONNECTION_STRING**.
1. Enter the database and collection names into the other two MONGODB variables in the `.env.sample` file:

    * MONGODB_URI_DATABASE_NAME
    * MONGODB_URI_COLLECTION_NAME

1. Right-click on the `.env.sample` file and choose **Rename**. Enter the name `.env`. 
 
## Check your work
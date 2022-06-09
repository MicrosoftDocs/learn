In this exercise, we're going to continue work on our social media monitoring app. We'll add a control action so the workflow can branch, based on the tweet's sentiment. The following diagram shows a conceptual view of the app and highlights the part that we'll work on.

![Diagram shows the triggers and actions in the social media monitoring logic app workflow. The third step is an action showing a control action that tests the sentiment score. If the score is greater than 0.7, the workflow branches to an **Insert row** action. If the score is less than or equal to 0.7, the workflow branches to a **Send an email** action.](../media/exercise-branch.png)

## Create SQL Server database to store positive tweets

When our workflow trigger receives a positive tweet, we want to save the tweet to a backend database. In this section, we'll run a script to create a database in the sandbox for us to use. You incur no costs because the database runs in the sandbox and is free for this exercise.

1. In the Cloud Shell to the right, run the following `curl` command to copy the **setup-sql-database.sh** script from GitHub:

   ```azurecli
   curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-route-and-process-data-logic-apps/master/setup-sql-database.sh > setup-sql-database.sh
   ```

1. Run the following command to run the script. This command will take a couple minutes:

   ```azurecli
   bash setup-sql-database.sh
   ```

1. Wait for the script to complete. When the script finishes, Cloud Shell displays the values for the following properties:

   - **SQL Server instance name**
   - **SQL Server username**
   - **SQL Server password**
   - **SQL Server database name**

1. Save these values somewhere safe. We need these values later in this exercise when we update our logic app workflow in the Azure portal. 

## Add a **Condition** control action

This first step adds the **Condition** control action to the logic app workflow in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). In programming terms, we're adding an *if statement* that tests a condition.

1. On your logic app resource menu, under **Development Tools**, return to the workflow designer by selecting **Logic app designer**.

1. On the designer, under the **Sentiment** action, select **New step**.

1. Under the **Choose an operation** search box, select **Built-in**. In the search box, enter **condition**.

1. Select the **Control** connector. From the actions section, select **Condition**.

## Set up the condition

Now we need to specify the condition to test. Remember that the **Sentiment** action returns a *score*, which is a number between zero and one. If the number is greater than 0.7, we'll consider the tweet positive. Otherwise, the tweet is negative.

1. In the **Condition** action, select the leftmost **Choose a value** field.

1. From the dynamic content list that opens, select **sentitment**.

1. In the middle column, from the operator list, select **is greater than**.

1. In the rightmost **Choose a value** field, enter **0.7**.

1. When you're done, save your workflow.

## Add the SQL Server "Insert row" action

Although the condition action is set up, the workflow doesn't specify the action to take if the score is positive or negative. As a reminder, we want to store parts of a tweet in a SQL database. For this task, let's find the SQL Server action named **Insert row**. When we add the action, we'll also provide our SQL Server database name and user credentials.

1. In the **True** section for the condition action, select **Add an action**.

1. In the **Choose an operation** search box, enter **SQL**.

1. Select the **SQL Server** connector. From the actions list, select **Insert row**.

1. If required, provide the information for your SQL Server connection.

   1. In the **Connection name** box, Enter **SQLConnection**.

   1. From the **Authentication type** list, select **SQL Server Authentication**.

   1. For **SQL server name**, enter the name for the SQL server that you previously created. Include the port number **3342** to access the public endpoint on the SQL Server instance.

      For more information, review [Connect to Azure SQL Database or SQL Managed Instance](/azure/connectors/connectors-create-api-sqlazure#connect-azure-sql-db).

   1. For **SQL database name**, enter **PositiveTweetDatabase**, which is the name for the database that we created with our script.

   1. Enter the **SQL username** and **SQL password** that you saved earlier when the setup script finished.

   1. When you're done, select **Create**.

## Set up the SQL Server **Insert row** action

Now, specify how to map the tweet data to your database columns. Let's store the tweet's text in a column called **Content** and the username for the person who made the tweet in a column called **Source**.

1. In the **Insert row** action, from the **Table name** list, and select the table named **Mentions**.

1. Open the **Add new parameter** list, and select **Content**.

1. When the dynamic content list opens, under **When a new tweet is posted**, select **Tweet text**.

   *Substitution*: If you're using the the RSS trigger named **When a feed item is published**, select the **FeedSummary** property instead.

1. Open the **Add new parameter** list, and select **Source**.

1. When the dynamic content list opens, under **When a new tweet is posted**, select **Tweeted by**.

   *Substitution*: If you're using the RSS trigger named **When a feed item is published**, select **FeedTitle**.

1. When you're done, save your workflow.

## Add the Outlook **Send an email** action

When the **Score** value is greater than **0.7**, we add the tweet to a SQL Server database. Let's now take tweets that are **0.7** or less and forward them to customer support through email. To start, we need to locate the Outlook **Send an email** action.

> [!NOTE]
> If you do not have an Outlook.com email account and prefer not to create one, you can change the connectors search filter to **Send an email** and select another email provider such as Gmail and Office 365 Outlook.

1. In the **If false** section of the **Condition** action, select **Add an action**.

1. In the **Search connectors and actions** field, enter *Outlook*.

1. Select **Outlook.com**.

1. Select **Send an email**.

## Configure your Outlook **Send an email** action

Now that we located the **Send an email** action, we need to map the tweet data to the respective email fields.

1. Select **Sign in**.

1. Sign in using a Microsoft account. If you don't have an account, you can create one now.

1. Select **Yes** to let your logic app have access to your email information.

1. In the **To** field, enter a valid email address. For testing, you can use your own address.

1. In the **Subject** field, enter *Negative tweet detected from* and then in the dynamic content popup, select **Original tweet tweeted by**.

    > [!NOTE]
    > If you are using the RSS **When a feed item is published** trigger, use the **FeedTitle** here.

1. In the **Body** field, enter *Contents of tweet.* In the dynamic content popup, select **Original tweet text**.

    > [!NOTE]
    > If you are using the RSS **When a feed item is published** trigger, use the **FeedSummary** here.

1. Select **Save**.

## Examine results of positive sentiment tweets

The **Control** action is now properly configured and running. Let's examine the SQL Server database to see our positive tweets.

1. In the Azure portal menu, select **All resources**, and then select **PositiveTweetDatabase** from the list of resources.

1. In the left menu pane, select **Query editor**.

1. Sign in using the **Server admin login** and **Password** that you saved when the script in the preceding unit created.

1. Select **OK**.

1. Select **New Query** on the top menu bar.

1. In the query editor, enter `Select * from dbo.mentions`.

1. Select **Run** to run the query, and list all positive tweets that have been written to the database.

## Examine results of negative sentiment tweets

Finally, let's check our email account to see if we received any messages about negative tweets.

Sign into the email account that you provided in the Outlook action, and wait for an email notification to arrive.

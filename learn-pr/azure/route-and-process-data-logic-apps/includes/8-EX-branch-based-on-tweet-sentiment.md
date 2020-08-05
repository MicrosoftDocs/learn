In this exercise, we're going to continue work on our social-media monitor app. We'll add a control action to branch based on the sentiment of the tweet. The following illustration shows a conceptual view of the app with the part that we'll work on highlighted.

![An illustration showing the triggers and actions in the social-media monitor logic app. The third step is an action showing a control action that is testing the sentiment score. If the score is greater than 0.7 the app branches to an **Insert row** action. If the score is less than or equal to 0.7, the app branches to a **Send an Email** action.](../media/exercise-branch.png)

## Create SQL Server database to store positive tweets

When we receive a positive tweet, we want to save it to a backend database. In this section, we'll run a script to create a database in the sandbox for us to use. You incur no costs; the database runs in the sandbox and is free for the purposes of this exercise.

1. In the Cloud Shell to the right, run the following curl command to copy the **setup-sql-database.sh** script from GitHub.

    ```azurecli
    curl https://raw.githubusercontent.com/MicrosoftDocs/mslearn-route-and-process-data-logic-apps/master/setup-sql-database.sh > setup-sql-database.sh
    ```

1. Run the following command to run the script. This command will take a couple of minutes.

    ```azurecli
    bash setup-sql-database.sh
    ```

1. Wait for the script to complete. When it finishes, the Cloud Shell displays values for the following properties.

     - **SQL Server instance name**
     - **SQL Server username**
     - **SQL Server password**
     - **SQL Server database name**

    Save the values that are displayed in the Cloud Shell somewhere safe. We need them in this exercise as we update our app in the Azure portal.

## Create a **Condition** control action

This first step is to add the control action to the app in the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). In programming terms, we're adding an *if statement* that will test a condition.

1. Return to the Logic Apps Designer by selecting **Logic Apps Designer**. This button is located under the development tools section of the left navigation bar.

1. Below the existing **Detect sentiment** action, click **New step**.

1. In the **Search connectors and actions** search box, type "control".

1. Select the **Control** connector.

1. In the actions section, select **Condition**.

## Configure the condition

Now that we have a **Condition** control action created, we need to specify what the condition is. Remember that the **Detect sentiment** action returns a *score*, which is a number between zero and one. If the number is greater than 0.7, we'll consider the tweet positive, otherwise it will be negative.

1. In the **Condition** action, select the leftmost **Choose a value** field.

1. In the **Dynamic** content popup, select **Score**.

1. Expand the drop-down menu that currently says **is equal to**.

1. Select **is greater than**.

1. Type **0.7** in the rightmost choose a value field.

1. Select the **Save** button to save your work.

## Locate the SQL Server insert row action.

The condition action is configured to detect if the **Score** value is greater than **0.7**; however, we haven't specified what should happen in that case. As a reminder, we want to store parts of a tweet into a SQL Database. To do that, let's locate the SQL Server insert row action.

1. In the **If true** section of the condition action, select **Add an action**.

1. In the search connectors and actions field, type **SQL**.

1. Select the **SQL Server** connector.

1. Select **Insert row**.

## Create a SQL Server insert row action

Now that we have located the SQL Server action, let's create it. During creation, we'll also provide our SQL Server database name and login credentials.

1. Type **SQLConnection** in the **Connection Name** field.

1. Select the SQL Server that you created earlier.

1. In **SQL Database Name**, select `PositiveTweetDatabase`, which is the name of the database we created with our script.

1. Enter the **SQL username** and **SQL password** that you saved earlier when the setup script finished.

1. Click **Create**.

## Configure your SQL Server **Insert row** action

The SQL Server action is now created; however, we need to specify how the tweet data will be mapped to our database's columns. Let's store the tweet's text in a column called `Content` and the username of the person who made the tweet in a column called `Source`.

1. Select the table `Mentions` from the **Table name** drop-down list.

1. Select `Content` from the **Add new parameter** drop-down list.

1. In the **Dynamic** content popup, select **Tweet text**.

    > [!NOTE]
    > If you are using the RSS **When a feed item is published** trigger, please use the **FeedSummary** here.

1. Select `Source` from the **Add new parameter** drop-down list.

1. In the **Dynamic** content popup, select **Tweeted by**.

    > [!NOTE]
    > If you are using the RSS **When a feed item is published** trigger, please use the **FeedTitle** here.

1. Click **Save**.

## Locate the Outlook **Send an email** action

When the **Score** value is greater than **0.7**, we add the tweet to a SQL Server database. Let's now take tweets that are **0.7** or less and forward them to customer support through email. To start, we need to locate the Outlook **Send an email** action.

> [!NOTE]
> If you do not have an Outlook.com email account and prefer not to create one, you can change the connectors search filter to **Send an email** and select another email provider such as Gmail and Office 365 Outlook.

1. In the **If false** section of the **Condition** action, select **Add an action**.

1. In the **Search connectors and actions** field, type **Outlook**.

1. Select **Outlook.com**.

1. Select **Send an email**.

## Configure your Outlook **Send an email** action

Now that we located the **Send an email** action, we need to map the tweet data to the respective email fields.

1. Click **Sign in**.

1. Sign in using a Microsoft account. If you don't have an account, you can create one now.

1. Click **Yes** to let your logic app have access to your email information.

1. In the **To** field, enter a valid email address. For testing, you can use your own address.

1. In the **Subject** field, type **Negative tweet detected from** and then in the dynamic content popup, select **Original tweet tweeted by**.

    > [!NOTE]
    > If you are using the RSS **When a feed item is published** trigger, please use the **FeedTitle** here.

1. In the **Body** field, type **Contents of tweet:** And then in the dynamic content popup, select **Original tweet text**.

    > [!NOTE]
    > If you are using the RSS **When a feed item is published** trigger, please use the **FeedSummary** here.

1. Click **Save**.

## Examine results of positive sentiment tweets

The **Control** action is now properly configured and running. Let's examine the SQL Server database to see our positive tweets.

1. In the Azure portal left navigation bar, select **All resources** and then select **PositiveTweetDatabase** from the list of resources.

1. In the left navigation bar, select **Query editor**.

1. Sign in using the **Server admin login** and **Password** that you saved when the script in the preceding unit created.

1. Click **OK**.

1. Select **+ New Query** on the top navigation bar.

1. In the query editor type `Select * from dbo.mentions`.

1. Select **Run** to run the query and list all positive tweets that have been written to the database.

## Examine results of negative sentiment tweets

Finally, let's check our email account to see if we received any messages about negative tweets.

1. Sign into the email account that you provided in the Outlook action and wait for an email notification to arrive.

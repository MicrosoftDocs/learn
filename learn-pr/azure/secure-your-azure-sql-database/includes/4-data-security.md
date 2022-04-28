The _marketplaceDb_ database stores information that is sensitive, such as physical addresses, email addresses, and phone numbers. If exposed, this information could be used by malicious attackers to harm our business or our customers. Let's look at how we can use encryption and data masking to enhance the security of our database.

## TLS network encryption

Azure SQL Database enforces Transport Layer Security (TLS) encryption at all times for all connections, which ensures all data is encrypted "in transit" between the database and the client. By using TLS encryption, you can ensure that anyone who may have intercepted the traffic between the app server and database would not be able to read the data. TLS encryption is a standard of securing traffic over the internet, and in this case ensures your network traffic to and from your Azure SQL database is secure by default.

## Transparent data encryption

Azure SQL Database protects your data at rest using transparent data encryption (TDE). TDE performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application. Using a database encryption key, transparent data encryption performs real-time I/O encryption and decryption of the data at the page level. Each page is decrypted when it's read into memory and then encrypted before being written to disk.

By default, TDE is enabled for all newly deployed Azure SQL databases. It's important to check that data encryption hasn’t been turned off, and older Azure SQL Server databases may not have TDE enabled.

Let's take a look in the portal at where TDE is configured on our _marketplaceDb_ database.

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. In the search bar at the top of the portal, search for **marketplaceDb**, then select the database in the portal.

1. In the left menu pane, under **Security**, select **Transparent data encryption**.

1. In the data encryption option, verify that **Data encryption** is set to **On**. You should also see an encryption status of **Encrypted**.

Because new databases are encrypted by default, we can be sure that our data is encrypted on disk from as soon as we create the database.

> [!NOTE]
> Azure includes a built in service called Microsoft Defender for Cloud that gives you visibility into the security of your environment, including Azure SQL databases. Microsoft Defender for Cloud will flag any databases that don't have TDE enabled on them, giving you the ability to report and take action to secure your data.

## Dynamic data masking

You might have noticed when we ran our query in the previous unit that some of the information in the database is sensitive; there are phone numbers, email addresses, and other information that we may not want to fully display to everyone with access to the data.

Maybe we don't want our users to be able to see the full phone number or email address, but we'd still like to make a portion of the data available for customer service representatives to identify a customer. By using the dynamic data masking feature of Azure SQL Database, we can limit the data that is displayed to the user. Dynamic data masking is a policy-based security feature that hides the sensitive data in the result set of a query over designated database fields, while the data in the database is not changed.

Data masking rules consist of the column to apply the mask to, and how the data should be masked. You can create your own masking format, or use one of the standard masks, such as:

- Default value, which displays the default value for that data type instead.
- Credit card value, which only shows the last four digits of the number, converting all other numbers to lower case x’s.
- Email, which hides the domain name and all but the first character of the email account name.
- Number, which specifies a random number between a range of values. For example, on the credit card expiry month and year, you could select random months from 1 to 12 and set the year range from 2018 to 3000.
- Custom string, which allows you to set the number of characters exposed from the start of the data, the number of characters exposed from the end of the data, and the characters to repeat for the remainder of the data.

When querying the columns, database administrators will still see the original values, but non-administrators will see the masked values. You can allow other users to see the non-masked versions by adding them to the SQL users excluded from masking list.

Let's take a look at how data masking would work in our _marketplaceDb_ database.

1. While still in the portal on the _marketplaceDb_ database panel, in the left menu pane, under **Security**, select **Dynamic Data Masking**.

    The Masking rules screen shows a list of existing dynamic data masks, and recommendations for columns that should potentially have a dynamic data mask applied.

    ![Screenshot of the Azure portal showing a list of the recommended masks for the various database columns of a sample database.](../media/4-view-recommended-masked-columns.png)

1. Let's add a mask for the phone number that only displays the last four digits. Select the **Add mask** button at the top to open the **Add masking rule** dialog box.

1. Select the following values.

    | Setting                  | Value                                   |
    | ------------------------ | --------------------------------------- |
    | **Schema**               | SalesLT                                 |
    | **Table**                | Customer                                |
    | **Column**               | Phone (nvarchar)                        |
    | **Masking field format** | Custom string (prefix [padding] suffix) |
    | **Exposed Prefix**       | 0                                       |
    | **Padding String**       | XXX-XXX-                                |
    | **Exposed Suffix**       | 4                                       |

    Select **Add** to add the masking rule.

    ![Screenshot of the Azure portal showing the values to add a masking rule.](../media/4-add-masking-rule.png)

1. Let's add one more for the email address. Select the **Add mask** button at the top again to open up the **Add masking rule** dialog box.

    | _Setting_                | _Value_                                 |
    | ------------------------ | --------------------------------------- |
    | **Schema**               | SalesLT                                 |
    | **Table**                | Customer                                |
    | **Column**               | EmailAddress (nvarchar)                 |
    | **Masking field format** | Email (aXXX@XXX.com)                    |

    Select **Add** to add the masking rule.

1. Each new mask will be added to the masking rules list. Select **Save** to apply the masks.

Let's take a look at how data masking changes our query.

1. Now let's log back in to the database, but as the _ApplicationUser_ user.

    ```bash
    sqlcmd -S tcp:serverNNNN.database.windows.net,1433 -d marketplaceDb -U 'ApplicationUser' -P '[password]' -N -l 30
    ```

1. Run the following query.

    ```sql
    SELECT FirstName, LastName, EmailAddress, Phone FROM SalesLT.Customer;
    GO
    ```

    Look at how the output has been masked.

    ```output
    FirstName     LastName      EmailAddress         Phone
    ------------- ------------- -------------------- ------------
    Orlando       Gee           oXXX@XXXX.com        XXX-XXX-0173
    Keith         Harris        kXXX@XXXX.com        XXX-XXX-0127
    Donna         Carreras      dXXX@XXXX.com        XXX-XXX-0130
    Janet         Gates         jXXX@XXXX.com        XXX-XXX-0173
    ...
    ```

With the masking rules we created, our data is masked with format that we've specified. These rules allow our customer service reps to verify a customer with the last four digits of their phone number, but hides the full number and the customer's email address from reps view.

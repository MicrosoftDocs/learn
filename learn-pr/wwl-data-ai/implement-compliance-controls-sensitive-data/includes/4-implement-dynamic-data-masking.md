[Dynamic Data Masking](/azure/azure-sql/database/dynamic-data-masking-overview) works by obfuscating data in order to limit its exposure. Users who don't need to see sensitive data can view the column that contains the data, but not the actual data itself. Dynamic Data Masking works at the presentation layer, and that unmasked data is always visible by high privileged users.

Dynamic Data Masking has the advantage that it doesn't require many modifications to the application or database. You can configure it through the Azure portal, or using T-SQL as follows.

:::image type="content" source="../media/module-33-security-final-13.png" alt-text="Screenshot of the dynamic data masking T-SQL commands.":::

In the example, both the *PhoneNumber* and *EmailAddress* columns are hidden from *DDMDemo* user who only has `SELECT` permission on the table. The user is allowed to see the last four digits of the phone number as it's masked using a *partial* function that replaces all but the last four digits in the column. This masking is considered to be a custom function. In addition to T-SQL, if you're using Azure SQL Database, you can create dynamic masking rules in the Azure portal:

:::image type="content" source="../media/module-33-security-final-14.png" alt-text="Screenshot of how to add masking rule in Azure portal.":::

You can reach the screen to add a masking rule by navigating to your database in the Azure portal and selecting **Dynamic Data Masking** in the **Security** section of the main blade for your database.

Dynamic Data Masking supports the following masking patterns that can be used:

| Masking function | Definition | T-SQL example |
|------------|-------------|-------------|
|**Default** | Masks the data in the column without exposing any part of the values to the user. The user would see XXXX for string values, 0 for numbers, and 01.01.1900 for date values. | `ALTER TABLE [Customer] ALTER COLUMN Address ADD MASKED WITH (FUNCTION = 'default()')` |
|**Credit card** | Masks all but the final four characters, allowing users to view the final four digits. This masking can be useful for customer service agents who need to view the last four digits of a credit card number but who don't need to see the entire number. The data is shown in the usual format of a credit card number XXXX-XXXX-XXXX-1234. | `ALTER TABLE [Customer] ALTER COLUMN Address ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX-XXXX-XXXX-",4)')` |
|**Email** | Only the first letter and the trailing domain suffix aren't masked; for example, “aXXX@XXXXXXX.com” | `ALTER TABLE [Customer] ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()')` |
|**Number** | This masking format should be used on numeric columns. It shows a random number as the masked value instead of the actual value. With each query, a different number is displayed. | `ALTER TABLE [Customer] ALTER COLUMN [Month] ADD MASKED WITH (FUNCTION = 'random(1, 12)')` |
|**Custom string** | This option allows text to be masked with any value, and to display a custom number of characters at either end of the masked value. If the length of the value being masked is equal to or less than the number of characters which the mask specifies are to be displayed, then only the masked characters are displayed. | `ALTER TABLE [Customer] ALTER COLUMN [PhoneNumber] ADD MASKED WITH (FUNCTION = 'partial(1,"XXXXXXX",0)')` |

To enable users to retrieve unmasked data from the columns for which masking is defined, you need to explicitly grant `UNMASK` permission.

>[!NOTE]
>It's possible to identify masked data using inference based on the results. If you're using data masking, you should also limit the ability of the user to run unplanned queries.
>
>For that reason, it's highly recommended to use dynamic data masking with other security features, such as auditing, encryption, row level security in order to better protect sensitive data.

## Use case

Data masking is a simple and lightweight feature, and it's ideal for many scenarios, including:

- Mask data from application users who have no direct access to the database.

- Restricting private information for a group of users.

- Provide masked data to external vendors, where you need to protect sensitive information while still preserving the relationships among items in the data.

- Export a copy of your production database to a lower environment for development purposes with a user who doesn’t have `UNMASK` permission. The export of the data will be in a masked format.

## Import and export data

Copying data from a masked column to another table using `SELECT INTO` or `INSERT INTO` results in masked data in the target table.

When a user without `UNMASK` privilege runs SQL Server Import and Export, the exported data file contains masked data, and the imported database will contain inactively masked data.

To learn more about how Dynamic Data Masking works, see [Dynamic Data Masking](/sql/relational-databases/security/dynamic-data-masking).

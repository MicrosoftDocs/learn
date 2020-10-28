Dynamic Data Masking allows users to view secure data without viewing the entire value. This masking allows users who do not need to see sensitive data such as credit card numbers, tax identification numbers, etc. to view the column that contains the data, but without seeing the actual data that is stored in the table. Note that Dynamic Data Masking is a presentation layer feature, and that unmasked data will always be seen by administrators. The best use case of Dynamic Data Masking is to mask data from application users who have no direct access to the database.

Dynamic Data Masking can be implemented in the Azure portal, or using T-SQL as shown below:

:::image type="content" source="../media/module-33-security-final-13.png" alt-text="Dynamic Data Maintain":::

In the above example, both the phone number and email address are hidden from a user named DDMDemo who only has SELECT access on the table. The user is allowed to see the last four digits of the phone number as it's masked using a ‘partial’ function that replaces all but the last four digits in the column. This masking is considered to be a custom function. In addition to T-SQL, if you are using Azure SQL Database, you can create dynamic masking rules in the Azure portal:

:::image type="content" source="../media/module-33-security-final-14.png" alt-text="Add Masking Rule Screen in Azure portal":::

You can reach the screen to add a masking rule by navigating to your database in the Azure portal and selecting Dynamic Data Masking in the security section of the main blade for your database.

Dynamic Data Masking supports a variety of masking patterns that can be used. These include Default, Credit Card, Social Security Number, Random Number, and Custom Text.

The **default** masking option fully masks the data in the column without exposing any part of the values to the user. The user would see XXXX for string values, 0 for numbers, and 01.01.1900 for date values

The **Credit Card** masking option masks all but the final four characters allowing users to view the final four digits. This masking can be useful for customer service agents who need to view the last four digits of a credit card number but who do not need to see the entire number. The data is shown in the usual format of a credit card number XXXX-XXXX-XXXX-1234.

The **Social Security Number** option masks all but the final four characters, with the masked data showing as the United States Social Security Number in the format XXX-XX-1234.

The **Random Number** masking option should be used on numeric columns. It shows a random number as the masked value instead of the actual value. Each time the record is queried a different number is displayed.

The **Custom Text** masking option allows you to specify any rules that are needed. This option allows text to be masked with any value, and to display a custom number of characters at either end of the masked value. If the length of the value being masked is equal to or less than the number of characters which the mask specifies are to be displayed, then only the masked characters are displayed.

A good use case of Dynamic Data Masking is for exporting a copy of your production database to a lower environment for development purposes, which may have fewer security restrictions. If you execute the export process using the credentials of a lower privileged user who doesn’t have UNMASK permissions, the data will be exported in its masked format.

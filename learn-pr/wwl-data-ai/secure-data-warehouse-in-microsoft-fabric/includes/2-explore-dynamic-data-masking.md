Dynamic Data Masking (DDM) is a security feature that limits data exposure to nonprivileged users by obscuring sensitive information. 

Dynamic data masking offers several key benefits that enhance the security and manageability of your data. One of the primary advantages is its real-time masking feature. When a query is made on sensitive data, DDM applies dynamic masking to it in real time. This process means that the actual data is never exposed to unauthorized users, thus enhancing the security of your data. Furthermore, DDM is straightforward to implement. It doesn’t require complex coding, making it accessible for users of all skill levels.

Another benefit of DDM is that the data in the database isn’t changed when DDM is applied. Instead, the masking rules are applied to the query results. This benefit means that the actual data remains intact and secure, while nonprivileged users only see a masked version of the data.

## Define masking rule

Dynamic data masking, which is set up at the column level, offers a suite of features including comprehensive and partial masking capabilities, along with a random masking function designed for numeric data. 

| Masking Type | Description | Use Case | Limitations | Masking Rule |
| --- | --- | --- | --- | --- |
| **Default** | Full masking according to the data types of the designated fields. | Useful when you want to completely hide the actual data. | Completely mask the data. No information is visible. | `default()` |
| **Email** | Exposes the first letter of an email address and the constant suffix ".com" | Useful when you want to show that the data field contains an email without revealing the actual email. | Only applicable to email fields. | `email()` |
| **Custom Text** | Exposes the first and last 'n' characters and adds a custom padding string in the middle. | Useful when you want to partially hide the actual data. | Not suitable for numeric, date, and time data types. | `partial(prefix_padding, padding_string, suffix_padding)` |
| **Random** | Replaces any numeric or binary value with a random number within a specified range. | Useful when you want to hide the actual numeric or binary data. | Only applicable to numeric and binary data types. | `random(low, high)` |

The `prefix_padding` and `suffix_padding` parameters in the `partial()` function specify the number of characters to expose at the beginning and end of the string, and the `padding_string` parameter specifies the string to use for masking the remaining characters. 

The `low` and `high` parameters in the `random()` function specify the range of random numbers to generate. 

These masking types help prevent unauthorized viewing of sensitive data by enabling administrators to specify how much sensitive data to reveal, with minimal effect on the application layer. They're applied to query results, so the data in the database isn't changed. This approach allows many applications to mask sensitive data without modifying existing queries.

### Configure data masking

Let's consider an example of a warehouse that stores customer information. The warehouse contains a `Customer` table with fields such as `CustomerName`, `Email`, `PhoneNumber`, and `CreditCardNumber`.

To apply data masking on the `CustomerName`, `Email`, `PhoneNumber`, and `CreditCardNumber` columns, run the following command:

```tsql
-- For Email
ALTER TABLE Customers
ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()');

-- For PhoneNumber
ALTER TABLE Customers
ALTER COLUMN PhoneNumber ADD MASKED WITH (FUNCTION = 'partial(3,"XXX-XXX-",4)');

-- For CreditCardNumber
ALTER TABLE Customers
ALTER COLUMN CreditCardNumber ADD MASKED WITH (FUNCTION = 'partial(4,"XXXX-XXXX-XXXX-",4)');
```

## View masked results

Without Dynamic Data Masking, if a nonprivileged user runs a query to fetch customer details, they might see something like this:

```
CustomerName: John Doe
Email: johndoe@contoso.com
PhoneNumber: 123-456-7890
CreditCardNumber: 1234-5678-9012-3456
```

However, with DDM applied to the `Email`, `PhoneNumber`, and `CreditCardNumber` fields, the same query would return:

```
CustomerName: John Doe
Email: j*****@contoso.com
PhoneNumber: XXX-XXX-7890
CreditCardNumber: XXXX-XXXX-XXXX-3456
```

As you can see, the sensitive data is hidden from the nonprivileged user, enhancing the security of your data. This scenario is a basic example of how Dynamic Data Masking works. It helps to ensure that sensitive data isn't exposed to users who don't have the necessary privileges to view it.

![NOTE]
> Unprivileged users with query permissions can infer the actual data since the data isn’t physically obfuscated.

DDM should be used as part of a comprehensive data security strategy that includes proper management of object-level security with SQL granular permissions and adherence to the principle of minimal required permissions.
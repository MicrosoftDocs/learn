Sensitive data in a warehouse — email addresses, credit card numbers, salary figures — shouldn't be visible to every user who has query access. Dynamic data masking (DDM) lets you obscure column values in query results without changing the underlying data. Nonprivileged users see a masked version; the actual values stay intact in storage.

Because masking happens at query time, not at the storage layer, DDM is easy to add to an existing warehouse without schema changes or application modifications.

## Define a masking rule

Masking rules are defined at the column level. Fabric warehouses support four masking types:

| Masking type | What it shows | Masking rule |
|---|---|---|
| **Default** | Fully replaces the value based on the data type — numbers become 0, strings become XXXX, dates become 1900-01-01. | `default()` |
| **Email** | Shows the first character and appends a fixed `.com` suffix. For example, `johndoe@contoso.com` becomes `j*****@contoso.com`. | `email()` |
| **Custom text** | Exposes a specified number of characters at the start and end, with custom padding in between. Useful for partial identifiers like the last four digits of a credit card. | `partial(prefix, padding, suffix)` |
| **Random** | Replaces numeric or binary values with a random number within a specified range. | `random(low, high)` |

## Configure data masking

To apply masks to columns in a `Customers` table, use `ALTER TABLE ... ALTER COLUMN ... ADD MASKED WITH`:

```tsql
-- Mask the email address
ALTER TABLE Customers
ALTER COLUMN Email ADD MASKED WITH (FUNCTION = 'email()');

-- Show only the last four digits of the phone number
ALTER TABLE Customers
ALTER COLUMN PhoneNumber ADD MASKED WITH (FUNCTION = 'partial(0,"XXX-XXX-",4)');

-- Show only the last four digits of the credit card number
ALTER TABLE Customers
ALTER COLUMN CreditCardNumber ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX-XXXX-XXXX-",4)');
```

To remove a mask, use `ALTER TABLE ... ALTER COLUMN ... DROP MASKED`.

## View masked results

Once masks are in place, a nonprivileged user querying the `Customers` table sees masked output:

```
CustomerName: John Doe
Email: j*****@contoso.com
PhoneNumber: XXX-XXX-7890
CreditCardNumber: XXXX-XXXX-XXXX-3456
```

Users with the `CONTROL` permission — Admins, Members, and Contributors — always see the unmasked values.

>[!NOTE]
> Unprivileged users with query permissions can infer the actual data since the data isn't physically obscured. For example, a user could write a query that divides by a masked salary column and trigger a divide-by-zero error only when the hidden value matches their guess — revealing the actual data without ever seeing it directly.

## Manage masking permissions

By default, only users with the `CONTROL` permission (Admins, Members, and Contributors) can view unmasked data. To allow a specific non-admin user to see unmasked values, grant them the `UNMASK` permission:

```tsql
-- Grant a specific user the ability to see unmasked data
GRANT UNMASK ON dbo.Customers TO [user@contoso.com];
```

To add or remove masks from columns, a user needs the `ALTER ANY MASK` permission:

```tsql
-- Allow a data engineer to manage masking rules without granting admin rights
GRANT ALTER ANY MASK TO [engineer@contoso.com];
```

To revoke access to unmasked data:

```tsql
REVOKE UNMASK ON dbo.Customers FROM [user@contoso.com];
```

The `UNMASK` permission gives you fine-grained control over who sees real data — without requiring you to grant full admin or table ownership rights.

DDM hides values — it doesn't prevent a user from querying the column. A masked user can still see that a value exists; they just can't read the real data. Use masking as one layer of protection, not as your only control.
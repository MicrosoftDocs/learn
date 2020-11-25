In this topic, we'll go through how you can manage authorization through column and row level security within Azure Synapse Analytics. 
We'll start off by talking about column level security in Azure Synapse Analytics, and finish with row level security. 

**Column Level Security in Azure Synapse Analytics**: 

Generally speaking, column level security is simplifying a design and coding for the security in your application. 
It allows you  to restrict column access in order to protect sensitive data. 
For example, if you want to ensure that a specific user 'Leo' can only access certain columns of a table because he's in a specific department. 
The logic for 'Leo' only to access the columns specified for the department he works in, is a logic that is located in the database tier, rather on the application level data tier. 
If he needs to access data from any tier, the database should apply the access restriction every time he tries to access data from another tier. 
The reason for doing so, is to make sure that your security is reliable and robust since we're reducing the surface area of the overall security system. 
Colum level security will also eliminate the necessity for the introduction of view, where you would filter out columns, to impose access restrictions on 'Leo'

The way to implement column level security, is by using the GRANT T-SQL statement. 
Using this statement, SQL and Azure Active Directory (AAD) support the authentication. 

![Showing Column-level security](../media/column-level-security.png)

**Syntax**
The syntax to use for implementing column level security looks as follows:
```syntaxsql
GRANT <permission> [ ,...n ] ON
    [ OBJECT :: ][ schema_name ]. object_name [ ( column [ ,...n ] ) ] // specifying the column access
    TO <database_principal> [ ,...n ]
    [ WITH GRANT OPTION ]
    [ AS <database_principal> ]
<permission> ::=
    SELECT
  | UPDATE
<database_principal> ::=
      Database_user // specifying the database user
    | Database_role // specifying the database role 
    | Database_user_mapped_to_Windows_User
    | Database_user_mapped_to_Windows_Group
```

So when would you use column-level security?
Let's say that you are a financial services firm, and can only have account manager allowed to have acces to a customer's social security number, phone numbers or other PII (personal identifiable information). It is imperative to distinguish the role of an account manager versus the manager of the account managers. 

Another usecase might be related to the Healthcare Industry. 
Let's say you have a specific health care provider. This healthcare provider only wants doctors and nurses to be able to access medical records. The billing department should not have access to view this data. Column-level security might be the option to use. 

So how does column level security distinguishes from row-level security. 
Let's look into that. 

**Row Level Security in Azure Synapse Analytics**:
Row-level security (RLS) can help you to create a group membership or execution context in order to control not just columns in a database table, but actually, the rows. 
RLS, just like column-level security, can simply a design and coding of your application security. 
However, compared to column-level security where it's focused on the columns (parameters), RLS helps you implement restrictions on data row access. 
Let's say that your employee can only access rows of data that are important of the department, you should implement RLS. 
If you want to restrict for example, customer's data acces that is only relevant to the company, you can impelment RLS. 
The restriction on access of the rows, is a logic that is located in the database tier, rather on the application level data tier. 
If, 'Leo' needs to access data from any tier, the database should apply the access restriction every time he tries to access data from another tier.  The reason for doing so, is to make sure that your security is reliable and robust since we're reducing the surface area of the overall security system. 

The way to implement RLS is by using the CREATE SECURITY POLICY[!INCLUDEtsql] statement. 
It predicates created as inline table-valued functions.
It is imperative to understand that within Azure Synapse, it only supports filter predicates. 
If you need to use a block predicate, you won't be able to find support at this moment within in Azure synapse.

![Schema of RLS](../media/row-level-security-graphic.png)

**Description** 

RLS within Azure Synapse supports one type of security predicates.  
  
- Filter predicates silently filter the rows available to read operations (SELECT, UPDATE, and DELETE).  

  
 Access to row-level data in a table is restricted by a security predicate defined as an inline table-valued function. The function is then invoked and enforced by a security policy. For filter predicates, the application is unaware of rows that are filtered from the result set. If all rows are filtered, then a null set will be returned. For block predicates, any operations that violate the predicate will fail with an error.  
  
 Filter predicates are applied while reading data from the base table. They affect all get operations: **SELECT**, **DELETE**  and **UPDATE**. The users can't select or delete rows that are filtered. The user can't update rows that are filtered. But, it's possible to update rows in such a way that they'll be filtered afterward. Block predicates affect all write operations.  
  
  
 Both filter  predicates and security policies have the following behavior:  
  
- You may define a predicate function that joins with another table and/or invokes a function. If the security policy is created with `SCHEMABINDING = ON` (the default), then the join or function is accessible from the query and works as expected without any additional permission checks. If the security policy is created with `SCHEMABINDING = OFF`, then users will need **SELECT** permissions on these additional tables and functions to query the target table. If the predicate function invokes a CLR scalar-valued function, the **EXECUTE** permission is needed in addition.
  
- You may issue a query against a table that has a security predicate defined but disabled. Any rows that are filtered or blocked aren't affected.  
  
- If a dbo user, a member of the **db_owner** role, or the table owner queries a table that has a security policy defined and enabled, the rows are filtered or blocked as defined by the security policy.  
  
- Attempts to alter the schema of a table bound by a schema bound security policy will result in an error. However, columns not referenced by the predicate can be altered.  
  
- Attempts to add a predicate on a table that already has one defined for the specified operation results in an error. This will happen whether the predicate is enabled or not.
  
- Attempts to modify a function, that is used as a predicate on a table within a schema bound security policy, will result in an error.  
  
- Defining multiple active security policies that contain non-overlapping predicates, succeeds.  
  
 Filter predicates have the following behavior:  
  
- Define a security policy that filters the rows of a table. The application is unaware of any rows that are filtered for **SELECT**, **UPDATE**, and **DELETE** operations. Including situations where all the rows are filtered out. The application can **INSERT** rows, even if they will be filtered during any other operation.  
  
 Block predicates have the following behavior:  
  
- Block predicates for UPDATE are split into separate operations for BEFORE and AFTER. Consequently, you can't, for example, block users from updating a row to have a value higher than the current one. If this kind of logic is required, you must use triggers with the [DELETED and INSERTED](../triggers/use-the-inserted-and-deleted-tables.md) intermediate tables to reference the old and new values together.  
  
- The optimizer will not check an AFTER UPDATE block predicate if the columns used by the predicate function weren't changed. For example: Alice shouldn't be able to change a salary to be greater than 100,000. Alice can change the address of an employee whose salary is already greater than 100,000 as long as the columns referenced in the predicate weren't changed.  
  
- No changes have been made to the bulk APIs, including BULK INSERT. This means that block predicates AFTER INSERT will apply to bulk insert operations just as they would regular insert operations.  
  

**Usecases**:
Here are design examples of how RLS can be used:  
  
- A hospital can create a security policy that allows nurses to view data rows for their patients only.  
  
- A bank can create a policy to restrict access to financial data rows based on an employee's business division or role in the company.  
  
- A multi-tenant application can create a policy to enforce a logical separation of each tenant's data rows from every other tenant's rows. Efficiencies are achieved by the storage of data for many tenants in a single table. Each tenant can see only its data rows.  
  
 RLS filter predicates are functionally equivalent to appending a **WHERE** clause. The predicate can be as sophisticated as business practices dictate, or the clause can be as simple as `WHERE TenantId = 42`.  
  
 In more formal terms, RLS introduces predicate based access control. It features a flexible, centralized, predicate-based evaluation. The predicate can be based on metadata or any other criteria the administrator determines as appropriate. The predicate is used as a criterion to determine if the user has the appropriate access to the data based on user attributes. Label-based access control can be implemented by using predicate-based access control.  

**Permissions**
Creating, altering, or dropping security policies requires the **ALTER ANY SECURITY POLICY** permission. Creating or dropping a security policy requires **ALTER** permission on the schema.  
  
 Additionally the following permissions are required for each predicate that is added:  
  
- **SELECT** and **REFERENCES** permissions on the function being used as a predicate.  
  
- **REFERENCES** permission on the target table being bound to the policy.  
  
- **REFERENCES** permission on every column from the target table used as arguments.  
  
 Security policies apply to all users, including dbo users in the database. Dbo users can alter or drop security policies however their changes to security policies can be audited. If high privileged users, such as sysadmin or db_owner, need to see all rows to troubleshoot or validate data, the security policy must be written to allow that.  
  
 If a security policy is created with `SCHEMABINDING = OFF`, then to query the target table, users must have the  **SELECT** or **EXECUTE** permission on the predicate function and any additional tables, views, or functions used within the predicate function. If a security policy is created with `SCHEMABINDING = ON` (the default), then these permission checks are bypassed when users query the target table.  

**Best Practices**

- It's highly recommended to create a separate schema for the RLS objects: predicate functions, and security policies. This helps to separate the permissions that are required on these special objects from the target tables. Additional separation for different policies and predicate functions may be needed in multi-tenant-databases, but not as a standard for every case.
  
- The **ALTER ANY SECURITY POLICY** permission is intended for highly privileged users (such as a security policy manager). The security policy manager doesn't require **SELECT** permission on the tables they protect.  
  
- Avoid type conversions in predicate functions to avoid potential runtime errors.  
  
- Avoid recursion in predicate functions wherever possible to avoid performance degradation. The query optimizer will try to detect direct recursions, but isn't guaranteed to find indirect recursions. An indirect recursion is where a second function calls the predicate function.  
  
- Avoid using excessive table joins in predicate functions to maximize performance.  
  
 Avoid predicate logic that depends on session-specific [SET options](../../t-sql/statements/set-statements-transact-sql.md): While unlikely to be used in practical applications, predicate functions whose logic depends on certain session-specific **SET** options can leak information if users are able to execute arbitrary queries. For example, a predicate function that implicitly converts a string to **datetime** could filter different rows based on the **SET DATEFORMAT** option for the current session. In general, predicate functions should abide by the following rules:  
  
- Predicate functions should not implicitly convert character strings to **date**, **smalldatetime**, **datetime**, **datetime2**, or **datetimeoffset**, or vice versa, because these conversions are affected by the [SET DATEFORMAT &#40;Transact-SQL&#41;](../../t-sql/statements/set-dateformat-transact-sql.md) and [SET LANGUAGE &#40;Transact-SQL&#41;](../../t-sql/statements/set-language-transact-sql.md) options. Instead, use the **CONVERT** function and explicitly specify the style parameter.  
  
- Predicate functions should not rely on the value of the first day of the week, because this value is affected by the [SET DATEFIRST &#40;Transact-SQL&#41;](../../t-sql/statements/set-datefirst-transact-sql.md) option.  
  
- Predicate functions should not rely on arithmetic or aggregation expressions returning **NULL** if they error (such as overflow or divide-by-zero), because this behavior is affected by the [SET ANSI_WARNINGS &#40;Transact-SQL&#41;](../../t-sql/statements/set-ansi-warnings-transact-sql.md), [SET NUMERIC_ROUNDABORT &#40;Transact-SQL&#41;](../../t-sql/statements/set-numeric-roundabort-transact-sql.md), and [SET ARITHABORT &#40;Transact-SQL&#41;](../../t-sql/statements/set-arithabort-transact-sql.md) options.  
  
- Predicate functions should not compare concatenated strings with **NULL**, because this behavior is affected by the [SET CONCAT_NULL_YIELDS_NULL &#40;Transact-SQL&#41;](../../t-sql/statements/set-concat-null-yields-null-transact-sql.md) option.  

**Side-Channel Attacks**:
### Malicious security policy manager

It is important to observe that a malicious security policy manager, with sufficient permissions to create a security policy on top of a sensitive column and having permission to create or alter inline table-valued functions, can collude with another user who has select permissions on a table to perform data exfiltration by maliciously creating inline table-valued functions designed to use side channel attacks to infer data. Such attacks would require collusion (or excessive permissions granted to a malicious user) and would likely require several iterations of modifying the policy (requiring permission to remove the predicate in order to break the schema binding), modifying the inline table-valued functions, and repeatedly running select statements on the target table. We recommend you limit permissions as necessary and monitor for any suspicious activity. Activity such as constantly changing policies and inline table-valued functions related to row-level security should be monitored.  
  
### Carefully crafted queries

It is possible to cause information leakage through the use of carefully crafted queries. For example, `SELECT 1/(SALARY-100000) FROM PAYROLL WHERE NAME='John Doe'` would let a malicious user know that John Doe's salary is $100,000. Even though there is a security predicate in place to prevent a malicious user from directly querying other people's salary, the user can determine when the query returns a divide-by-zero exception. 

**Cross Feature Compatability**:

In general, row-level security will work as expected across features. However, there are a few exceptions. This section documents several notes and caveats for using row-level security with certain other features of [!INCLUDE[ssNoVersion](../../includes/ssnoversion-md.md)].  
  
- **DBCC SHOW_STATISTICS** reports statistics on unfiltered data, and can leak information otherwise protected by a security policy. For this reason, access to view a statistics object for a table with a row-level security policy is restricted. The user must own the table or the user must be a member of the sysadmin fixed server role, the db_owner fixed database role, or the db_ddladmin fixed database role.  
  
- **Filestream:** RLS is incompatible with Filestream.  
  
- **PolyBase:** RLS is supported with Polybase external tables for Azure Synapse only.

- **Memory-Optimized Tables:** The inline table-valued function used as a security predicate on a memory-optimized table must be defined using the `WITH NATIVE_COMPILATION` option. With this option, language features not supported by memory-optimized tables will be banned and the appropriate error will be issued at creation time. For more information, see the **Row-Level Security in Memory Optimized Tables** section in [Introduction to Memory-Optimized Tables](../../relational-databases/in-memory-oltp/introduction-to-memory-optimized-tables.md).  
  
- **Indexed views:** In general, security policies can be created on top of views, and views can be created on top of tables that are bound by security policies. However, indexed views cannot be created on top of tables that have a security policy, because row lookups via the index would bypass the policy.  
  
- **Change Data Capture:** Change Data Capture can leak entire rows that should be filtered to members of **db_owner** or users who are members of the "gating" role specified when CDC is enabled for a table (note: you can explicitly set this function to **NULL** to enable all users to access the change data). In effect, **db_owner** and members of this gating role can see all data changes on a table, even if there is a security policy on the table.  
  
- **Change Tracking:** Change Tracking can leak the primary key of rows that should be filtered to users with both **SELECT** and **VIEW CHANGE TRACKING** permissions. Actual data values are not leaked; only the fact that column A was updated/inserted/deleted for the row with B primary key. This is problematic if the primary key contains a confidential element, such as a Social Security Number. However, in practice, this **CHANGETABLE** is almost always joined with the original table in order to get the latest data.  
  
- **Full-Text Search:** A performance hit is expected for queries using the following Full-Text Search and Semantic Search functions, because of an extra join introduced to apply row-level security and avoid leaking the primary keys of rows that should be filtered: **CONTAINSTABLE**, **FREETEXTTABLE**, semantickeyphrasetable, semanticsimilaritydetailstable, semanticsimilaritytable.  
  
- **Columnstore Indexes:** RLS is compatible with both clustered and nonclustered columnstore indexes. However, because row-level security applies a function, it is possible that the optimizer may modify the query plan so that it doesn't use batch mode.  
  
- **Partitioned Views:** Block predicates cannot be defined on partitioned views, and partitioned views cannot be created on top of tables that use block predicates. Filter predicates are compatible with partitioned views.  
  
- **Temporal tables:** Temporal tables are compatible with RLS. However, security predicates on the current table are not automatically replicated to the history table. To apply a security policy to both the current and the history tables, you must individually add a security predicate on each table.  
  

In this topic, we'll go through how you can manage authorization through column and row level security within Azure Synapse Analytics. 
We'll start off by talking about column level security in Azure Synapse Analytics, and finish with row level security. 

## Column level security in Azure Synapse Analytics 

Generally speaking, column level security is simplifying a design and coding for the security in your application. 
It allows you  to restrict column access in order to protect sensitive data. 
For example, if you want to ensure that a specific user 'Leo' can only access certain columns of a table because he's in a specific department. 
The logic for 'Leo' only to access the columns specified for the department he works in, is a logic that is located in the database tier, rather on the application level data tier. 
If he needs to access data from any tier, the database should apply the access restriction every time he tries to access data from another tier. 
The reason for doing so, is to make sure that your security is reliable and robust since we're reducing the surface area of the overall security system. 
Column level security will also eliminate the necessity for the introduction of view, where you would filter out columns, to impose access restrictions on 'Leo'

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
Let's say that you are a financial services firm, and can only have account manager allowed to have access to a customer's social security number, phone numbers or other personal identifiable information. It is imperative to distinguish the role of an account manager versus the manager of the account managers. 

Another use case might be related to the Healthcare Industry. 
Let's say you have a specific health care provider. This healthcare provider only wants doctors and nurses to be able to access medical records. The billing department should not have access to view this data. Column-level security might be the option to use. 

So how does column level security distinguishes from row-level security. 
Let's look into that. 

## Row level security in Azure Synapse Analytics

Row-level security (RLS) can help you to create a group membership or execution context in order to control not just columns in a database table, but actually, the rows. 
RLS, just like column-level security, can simply help and enable your design and coding of your application security. 
However, compared to column-level security where it's focused on the columns (parameters), RLS helps you implement restrictions on data row access. 
Let's say that your employee can only access rows of data that are important of the department, you should implement RLS. 
If you want to restrict for example, customer's data access that is only relevant to the company, you can implement RLS. 
The restriction on access of the rows, is a logic that is located in the database tier, rather on the application level data tier. 
If 'Leo' needs to access data from any tier, the database should apply the access restriction every time he tries to access data from another tier.  The reason for doing so, is to make sure that your security is reliable and robust since we're reducing the surface area of the overall security system. 

The way to implement RLS is by using the CREATE SECURITY POLICY[!INCLUDEtsql] statement. 
The predicates are created as inline table-valued functions.
It is imperative to understand that within Azure Synapse, it only supports filter predicates. 
If you need to use a block predicate, you won't be able to find support at this moment within in Azure synapse.

![Schema of RLS](../media/row-level-security-graphic.png)

### Description of row level security in relation to filter predicates

RLS within Azure Synapse supports one type of security predicates, which are Filter predicates, not block predicates.  
What filter predicates do, are silently filtering the rows that are available for read operations such as SELECT, UPDATE, DELETE.

The access to row-level data in a table, is restricted as an inline table-valued function, which is a security predicate. 
This table-valued function will then be invoked and enforced by the security policy that you need. 
An application, is not aware of rows that are filtered from the result set for filter predicates. 
So what will happen is that if all rows are filtered, a null set is returned. 

When you are using filter predicates, it will be applied when data is read from the base table. 
The filter predicate affects all get operations such as SELECT, DELETE, UPDATE. 
You are unable to select or delete rows that have been filtered. It is not possible for you to update a row that has been filtered. 
What you can do, is update rows in a way that they will be filtered afterwards. 

### Use cases

We've already mentioned some use cases for RLS. 
Another use case might where you have created a multi-tenant application where you create a policy where logical separations of a tenants data rows from another tenants data rows are enforced. 
In order to implement this efficiently, it is highly recommended to store data for many tenants in a single table. 

When we look at RLS filter predicates, they are functionally equivalent to appending a **WHERE** clause. 
The predicate can be as sophisticated as business practices dictate, or the clause can be as simple as `WHERE TenantId = 42`.  
  
When we look at RLS more formally, RLS introduces predicate based access control. 
The reason why RLS can be used for predicate access control is that it is flexible, centralized, predicate-based evaluation. 
The filter predicate can be based on metadata or any other criteria you would determine as appropriate. 
The predicate is used as a criterion to determine if the user has the appropriate access to the data based on user attributes. 
Label-based access control can be implemented by using predicate-based access control.  

### Permissions

If you want to create, alter or drop the security policies, you would have to use the **ALTER ANY SECURITY POLICY** permission. 
The reason for that is when you are creating or dropping a security policy it requires **ALTER** permissions on the schema.  
  
In addition to that, there are other permissions required for each predicate that you would add:  
  
* **SELECT** and **REFERENCES** permissions on the inline table-valued function being used as a predicate.  
  
* **REFERENCES** permission on the table that you target to be bound to the policy.  
  
* **REFERENCES** permission on every column from the target table used as arguments.  
  
Once you've set up the security policies, they will apply to all the users (including dbo users in the database)
Even though DBO users can alter or drop security policies, their changes to the security policies can be audited. 
If you have special circumstances where highly privileged users, like a sysadmin or db_owner, need to see all rows to troubleshoot or validate data, you would still have to write the security policy in order to allow that.  
  
If you have created a security policy where `SCHEMABINDING = OFF`, in order to query the target table, the user must have the  **SELECT** or **EXECUTE** permission on the predicate function.
They also need permissions to any additional tables, views, or functions used within the predicate function. 
If a security policy is created with `SCHEMABINDING = ON` (the default), then these permission checks are bypassed when users query the target table.  

## Best practices

There are some best practices to take in mind when you want to implement RLS. 
We recommended creating a separate schema for the RLS objects. 
RLS objects in this context would be the predicate functions, and security policies. 
Why is that a best practice?
It helps to separate the permissions that are required on these special objects from the target tables. 
In addition to that, separation for different policies and predicate functions may be needed in multi-tenant-databases. 
However, it is not a standard for every case.

Another best practice to bear in mind is that the **ALTER ANY SECURITY POLICY** permission should only be intended for highly privileged users (such as a security policy manager). 
The security policy manager should not require **SELECT** permission on the tables they protect.  

In order to avoid potential runtime errors, you should take in mind type conversions in predicate functions that you write. 
Also, you should try to avoid recursion in predicate functions.
The reason for this is to avoid performance degradation. 
Even though the query optimizer will try to detect the direct recursions, there is no guarantee to find the indirect recursions. 
With an indirect recursion we mean where a second function call the predicate function. 

It would also be recommended to avoid the use of excessive table joins in predicate functions.
This would maximize performance.  

Generally speaking when it comes to the logic of predicates, you should try to avoid logic that depends on session-specific SET options. Even though this is highly unlikely to be used in practical applications, predicate functions whose logic depends on certain session-specific **SET** options can leak information if users are able to execute arbitrary queries. For example, a predicate function that implicitly converts a string to **datetime** could filter different rows based on the **SET DATEFORMAT** option for the current session. 


  

All Relational Database Management platforms have 4 basic permissions which control data manipulation language (DML) operations. These permissions are SELECT, INSERT, UPDATE, and DELETE. These permissions apply to all SQL Server platforms as well as Azure SQL Database for MySQL and Azure SQL Database for PostgreSQL. All of these permissions can be granted, revoked or denied on tables and views. If a permission is granted using the GRANT statement, then the permission is given to the user or role referenced in the GRANT statement. Users can also be denied permissions using the DENY command. If a user is granted a permission and denied the same permission, the DENY will always supersede the grant, and the user will be denied access to the specific object.

:::image type="content" source="../media/module-33-security-final-03.png" alt-text="A T-SQL Example of a DENY overriding a GRANT":::

In the above example, the user Demo is granted SELECT and then denied SELECT permissions on the dbo.Company table. When the user tries to execute a query that selects from the dbo.Company table, the user receives an error that SELECT permission was denied.

## Table and view permissions

Tables and views represent the objects on which permissions can be granted within a database. Within those tables and views, you can additionally restrict the columns that are accessible to a given security principal (user or login). SQL Server and Azure SQL Database also include row-level security which can be used to further restrict access.

The SELECT permission, when granted, will allow the user to view the data within the object (table or view). When denied, the user will be prevented from viewing the data within the object.

The INSERT permission, when granted, will allow the user to insert data into the object. When denied, the user will be prevented from inserting data into the object.

The UPDATE permission, when granted, will allow the user the update data within the object. When denied, the user will be prevented from updating data in the object.

The DELETE permission, when granted, will allow the user to delete data within the object. When denied, the user will be prevented from deleting data from the object.

Azure SQL Database and Microsoft SQL Server have additional permissions which can be granted, revoked or denied as needed.

The CONTROL permission grants all rights to the objects. This allows the user who has this permission to perform any action they wish against the object, including deleting the object.

The REFERENCES permission grants the user the ability to view the foreign keys on the object. This permission is also available in Azure SQL Database for MySQL and Azure SQL Database for PostgreSQL.

The TAKE OWNERSHIP permission allows the user the ability to take ownership of the object.

The VIEW CHANGE TRACKING permission allows the user to view the change tracking setting for the object.

The VIEW DEFINITION permission allows the user to view the definition of the object.

## Function and stored procedure permissions

Like tables and views, functions and stored procedures have several permissions which can be granted or denied.

The ALTER permission grants the user the ability to change the definition of the object.

The CONTROL permission grants the user all rights to the object.

The EXECUTE permission grants the user the ability to execute the object. This permission can be granted to Azure SQL Database for MySQL and Azure SQL Database for PostgreSQL.

The VIEW CHANGE TRACKING permission allows the user to view the change tracking setting for the object.

The VIEW DEFINITION permission allows the user to view the definition of the object.

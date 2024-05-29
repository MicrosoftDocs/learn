Creating a stored procedure for a specific task has many advantages, including extending the functionality of your Azure for PostgreSQL database. Use a stored procedure when you want to:

- Develop and test complex code in one place, then call it where needed.
- Execute code efficiently. Stored procedures that return the same result are more efficient because they're precompiled and stored in the Azure Database PostgreSQL server.
- Make your code easier to read.
- Include error handling within a transaction.
- Hide complexity from users.

In addition, Azure Database for PostgreSQL supports many languages including:

- SQL
- PL/pgSQL
- PL/Python
- PL/Perl and PL/PerlU
- PL/Python
- PL/Tcl and PL/TCLU

SQL is PostgreSQL's native language and works best with the optimizer.

A stored procedure is created with the key words CREATE PROCEDURE. Alternatively, use CREATE OR REPLACE PROCEDURE to either create a new procedure or replace a procedure with the same name.

Include a schema name to create the procedure in a specific schema. Otherwise, created in the current schema. The procedure name must be unique within the schema, including the input argument types. You can however overload procedure names by giving the same name to a procedures or function with *different* argument types.

The user who creates the procedure is the owner of the procedure. You must also specify the language.

Procedures take the following parameters:

- **name** - optionally include the schema name.
- **argmode** - the mode of the argument. Can be IN, INOUT, or VARIADIC. The default is IN. OUT isn't supported; use INOUT instead. VARDIADIC is an undefined number of input arguments of the same type, and must be the last input arguments.
- **argname** - argument name.
- **argtype** - the argument data type.
- **default_expr** - a default expression (of the same type) to be used if the parameter isn't specified. Input parameters following a parameter with a default value must also have default values.
- **lang_name -** the language used to write the procedure. Can be sql, c, internal, or the name of a user-defined procedural language, for example, plpgsql.

In the following example, a stored procedure is created called myprocedure, which takes input parameters a and b. IN is the default for parameters, so we don't have to explicitly identify them as input parameters. When the stored procedure is called, the values assigned to these parameters are inserted into mytable.

```sql
CREATE PROCEDURE myprocedure (a integer, b integer)
    LANGUAGE SQL
    AS $$
        INSERT INTO mytable VALUES (a, b);
    $$;
```

The `$$` symbol is used to start and end a string. You can also use single quotation marks, but it can cause problems with other programming languages so `$$` is preferred.

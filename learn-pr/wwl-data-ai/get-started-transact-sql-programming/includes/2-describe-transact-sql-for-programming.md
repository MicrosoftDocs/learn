Transact-SQL (T-SQL) is a proprietary extension of the open standard Structured Query Language (SQL).  It supports declared variables, string and data processing, error and exception handling, and transaction control.  While SQL is a programming language, T-SQL adds support for procedural programming and the use of local variables.

A T-SQL program will usually start with a BEGIN statement and terminate with an END statement, with the statements you'll want to execute in between.

As you move from executing code objects to creating them, you'll need to understand how multiple statements interact with the server on execution. As you develop programs, you'll need to temporarily store values. For example, you might need to temporarily store values that will be used as parameters in stored procedures.

Finally, you might want to create aliases, or pointers, to objects so that you can reference them by a different name or from a different location than where they're defined.

Here are a few of the supported T-SQL programming structures:

- IF..ELSE - A conditional statement that lets you decide what aspects of your code will execute.
- WHILE - A looping statement that is ideal for running iterations of T-SQL statements.
- DECLARE - You'll use this to define variables.
- SET - One of the ways you'll assign values to your variables.
- BATCHES - Series of T-SQL statements that are executed as a unit.

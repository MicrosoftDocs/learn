Transact-SQL (T-SQL) are a proprietary extension of the open standard Structured Query Language (SQL). It supports declared variables, string and data processing, error and exception handling, and transaction control. While SQL is a programming language, T-SQL adds support for procedural programming and the use of local variables.

T-SQL statements in a batch are executed in order from first to last. When you need multiple statements to execute together as a single logical unit—for example inside an `IF` or `WHILE` block—you wrap them in `BEGIN...END`.

As you move from executing code objects to creating them, you need to understand how multiple statements interact with the server on execution. As you develop programs, you need to temporarily store values. For example, you might need to temporarily store values that are used as parameters in stored procedures.

Finally, you might want to create aliases, or pointers, to objects so that you can reference them by a different name or from a different location than where they're defined.

Here are a few of the supported T-SQL programming structures:

- `IF`..`ELSE` - A conditional statement that lets you decide what aspects of your code execute.
- `WHILE` - A looping statement that's ideal for running iterations of T-SQL statements.
- `DECLARE` - You use it to define variables.
- `SET` - One of the ways you assign values to your variables.
- BATCHES - Series of T-SQL statements that are executed as a unit.

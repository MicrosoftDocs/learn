

Choose the best response for each of the questions, then select **Check your answers**.

## Multiple Choice

In which order should you load tables in the data warehouse?

(x) Staging tables, then dimension tables, then fact tables {{That's correct. The correct order of operations is stage, populate dimensions to transform keys and SCDs, then load facts with numeric values.}}  
() Staging tables, then fact tables, then dimension tables {{That's incorrect. Fact tables should be loaded last with the appropriate surrogate keys from dimensions.}}  
() Dimension tables, then staging tables, then fact tables {{That's incorrect. This would put changes to dimensions behind and cause potential corruption.}}

## Multiple Choice

Which command should you use to load a staging table with data from files in the data lake?

(x)COPY {{That's Correct. With existing tables, the copy command is the most efficient way to populate the warehouse from the data lake.}}  
()LOAD {{That's incorrect. Load is not a valid operation in this context}}  
()INSERT {{That's incorrect. Although INSERT is an option, it doesn't perform as well as the COPY command.}}

## Multiple Choice

When a customer changes their phone number, the change should be made in the existing row for that customer in the dimension table. What type of slowly changing dimension is this?

()Type 0 {{That's incorrect. We will want the new phone number stored.}}  
(x)Type 1 {{That's correct. In this case, simply changing the number with no history is appropriate.}}  
()Type 2 {{That's incorrect. There should be no historical context for storing an old phone number.}}

## Knowledge check

## Multiple Choice

Which SQL Server function should be used to compute the exact value at a specified percentile without interpolating between data points?
() APPROX_PERCENTILE_CONT {{ That's incorrect. APPROX_PERCENTILE_CONT interpolates between data points to provide a more accurate estimate. }}
(x) PERCENTILE_CONT {{ That's correct. PERCENTILE_CONT computes the exact value at a specified percentile without interpolating between data points. }}
() APPROX_PERCENTILE_DISC {{ That's incorrect. APPROX_PERCENTILE_DISC efficiently calculates the nearest existing data point, but it doesn't compute the exact value without interpolating between data points. }}

## Multiple Choice

In SQL Server 2022, which function is used to select the smallest value among multiple expressions?
() MIN_VALUE {{ That's incorrect. MIN_VALUE doesn't exist as a function in SQL Server 2022. The correct function to use is MIN, but it's an aggregate function and can't be used for multiple expressions. }}
(x) LEAST {{ That's correct. LEAST selects the smallest value among multiple expressions. }}
() FIRST_VALUE {{ That's incorrect. FIRST_VALUE selects the first value in an ordered set of values. }}

## Multiple Choice
In SQL Server 2022, which function is used to obtain a given date rounded down to a specified level of granularity, such as year, month, or day, without needing to specify the width of the datepart intervals from the origin time?

(x) DATETRUNC {{ That's correct. DATETRUNC rounds down a given date to a specified level of granularity, such as year, month, or day, without needing to specify the width of the datepart intervals from the origin time. }}
() DATE_BUCKET {{ That's incorrect. DATE_BUCKET returns the start of each date-time interval based on a specified origin, time unit, and the width of the intervals. }}
() DATEPART {{ That's incorrect. DATEPART returns the specified part of a date or time value. }}

## Multiple Choice
Which of the following SQL Server 2022 commands allows you to pause and resume an ALTER TABLE ADD CONSTRAINT operation?

(x) ALTER INDEX {{ That's correct. ALTER INDEX is used to pause and resume constraint operations, like adding PRIMARY KEY and UNIQUE constraints, in SQL Server 2022. }}
() ALTER TABLE {{ That's incorrect. ALTER TABLE is used to add, modify, or drop constraints, but it doesn't  pause and resume constraint operations. }}
() ALTER CONSTRAINT {{ That's incorrect. ALTER CONSTRAINT isn't a valid command in SQL Server. }}

## Multiple Choice
What is the primary difference between the "=" operator and the "IS NOT DISTINCT FROM" operator?

() There's no difference; they both compare values for equality in the same exact way. {{ That's incorrect. While both "=" and "IS NOT DISTINCT FROM" compare values for equality, they handle NULL values differently. }}
(x) "IS NOT DISTINCT FROM" handles NULL values in comparisons, while "=" doesn't. {{ That's correct. "IS NOT DISTINCT FROM" Compares the equality of two expressions and guarantees a true or false result, even if one or both operands are NULL. The "=" operator returns UNKNOWN when one or both expressions are NULL. }}
() The "=" operator can compare any data type, while "IS NOT DISTINCT FROM" can only compare string values. {{ That's incorrect. Both "=" and "IS NOT DISTINCT FROM" operators can compare various data types. }}

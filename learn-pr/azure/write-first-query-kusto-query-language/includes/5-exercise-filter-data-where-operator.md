
Where- filtering on a condition


Values can have different types, so you might need to cast them to perform comparisons on the correct type. For example, the SecurityEvent Level column is of type String, so you must cast it to a numerical type, such as int or long, before you can use numerical operators on it, as shown here: SecurityEvent | where toint(Level) >= 10


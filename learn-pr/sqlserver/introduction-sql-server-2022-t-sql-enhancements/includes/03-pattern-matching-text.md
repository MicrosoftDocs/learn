SQL Server 2025 adds new regular expression (REGEXP) functions and enhances the `SUBSTRING` function to simplify working with structured text. These additions allow developers to perform flexible text searches, extract complex patterns, and clean or transform data directly in T-SQL without relying on client-side scripting or CLR functions.

## Overview of Pattern Matching and Text Extraction Functions

The new REGEXP family of functions supports regular expression evaluation directly inside SQL Server. Each function enables specific pattern-based text operations.

### REGEXP_LIKE  
Checks if a string matches a regular expression pattern. Returns 1 if it matches, 0 otherwise.

### REGEXP_SUBSTR  
Extracts the first substring that matches a regular expression pattern. Useful for pulling out specific information such as phone numbers, dates, or email addresses.

### REGEXP_REPLACE  
Searches a string for a pattern and replaces all occurrences that match the pattern. It can be used for data cleanup and formatting.

### REGEXP_INSTR  
Returns the starting position of the first substring that matches the pattern within the given text. Ideal for locating key markers in structured text.

### REGEXP_COUNT
Counts the number of matches of a regular expression pattern in a given string. This count is useful when you need to measure pattern frequency, such as counting digits, words, or symbols in text.

### REGEXP_MATCHES
Returns all substrings that match a regular expression pattern as a table result. Use it when you need multiple captures from a single string rather than only the first match.

### REGEXP_SPLIT_TO_TABLE  
Splits a string into multiple rows using a regular expression delimiter.

### SUBSTRING Enhancement  
The `SUBSTRING` function now supports an optional length parameter. When omitted, it automatically extracts from the specified start position to the end of the string, reducing the need for manual LEN() calculations.

Together, these capabilities let you search, extract, and manipulate text patterns directly in SQL Server 2025 with concise, readable T-SQL.

---

## Example Scenario: Extracting and Cleaning Contact Data

A marketing team maintains a database of customer messages in a column named `MessageText`. Many entries include phone numbers in different formats. You need to extract the first phone number from each message, normalize it to a standard format, and identify messages that contain invalid phone numbers.

### Sample Data

Let's assume you have the following sample data in a table called `CustomerMessages`:

| MessageID | MessageText |
|------------|-------------|
| 1 | "Call me at (713) 555-1298 or office 555-8811." |
| 2 | "Reach out to me: +1-832-555-7821 thank you!" |
| 3 | "My number is 713-555-9876 ext. 33" |
| 4 | "No phone listed yet." |

### Query: Identify, Extract, and Standardize

```sql
-- Extract the first phone number pattern and format it consistently
SELECT MessageID,
       REGEXP_SUBSTR(MessageText, '\d{3}[)\-\s]*\d{3}[\-\s]*\d{4}') AS RawNumber,
       REGEXP_REPLACE(
           REGEXP_SUBSTR(MessageText, '\d{3}[)\-\s]*\d{3}[\-\s]*\d{4}'),
           '\D', ''
       ) AS DigitsOnly,
       CASE 
           WHEN REGEXP_LIKE(MessageText, '\d{3}[)\-\s]*\d{3}[\-\s]*\d{4}') = 1 THEN 'Valid'
           ELSE 'Missing'
       END AS PhoneStatus
FROM dbo.CustomerMessages;
```

### Results

| MessageID | RawNumber | DigitsOnly | PhoneStatus |
|------------|------------|-------------|--------------|
| 1 | (713) 555-1298 | 7135551298 | Valid |
| 2 | +1-832-555-7821 | 18325557821 | Valid |
| 3 | 713-555-9876 | 7135559876 | Valid |
| 4 | NULL | NULL | Missing |

This example uses `REGEXP_SUBSTR` to extract the first matching pattern, `REGEXP_REPLACE` to strip non-numeric characters, and `REGEXP_LIKE` to verify valid numbers. The query standardizes phone numbers into a consistent digits-only format directly in T-SQL.

---

## Example 2: Splitting Data with REGEXP_SPLIT_TO_TABLE and SUBSTRING

Suppose another table, `CustomerFeedback`, stores comma-separated tags describing customer interests. You want to separate them into individual rows and extract the first keyword for quick indexing.

```sql
SELECT FeedbackID,
       value AS Tag,
       SUBSTRING(value, 1) AS FirstWord
FROM CustomerFeedback
CROSS APPLY REGEXP_SPLIT_TO_TABLE(Tags, '\s*,\s*');
```

This query splits each comma-delimited string into rows while using the new `SUBSTRING` behavior (without specifying length) to extract the entire remaining text from the start position.

### Results

| FeedbackID | Tag | FirstWord |
|-------------|-----|-----------|
| 1 | travel | travel |
| 1 | photography | photography |
| 2 | hiking | hiking |
| 2 | camping | camping |

---

## Summary

The new REGEXP functions and the enhanced SUBSTRING function in SQL Server 2025 deliver native pattern-matching and text-extraction capabilities. These additions eliminate the need for external string processing, making it easier to clean, parse, and analyze textual data inside the database engine. With these tools, developers can simplify ETL pipelines, improve data quality, and enable advanced text-driven analytics directly in T-SQL.

SQL Server 2025 introduces a range of new T‑SQL features and enhancements that support modern workloads while keeping queries clear and maintainable. This module focuses on language additions for AI and vectors, pattern matching, JSON output, string processing, and improved date and numeric operations.

In this module, we cover the following topics:

- **Vector and AI integration**: Learn how to generate embeddings and work with vector data using functions and features such as `AI_GENERATE_EMBEDDINGS`, `AI_GENERATE_CHUNKS`, `VECTOR_DISTANCE`, `VECTOR_NORM`, `VECTOR_NORMALIZE`, `VECTORPROPERTY`, `CREATE EXTERNAL MODEL`, `CREATE VECTOR INDEX`, and `VECTOR_SEARCH`.
- **Pattern matching and text extraction**: Use `REGEXP_LIKE`, `REGEXP_SUBSTR`, `REGEXP_REPLACE`, `REGEXP_INSTR`, `REGEXP_COUNT`, `REGEXP_MATCHES`, and `REGEXP_SPLIT_TO_TABLE`, plus the enhanced `SUBSTRING` behavior.
- **JSON and string aggregation**: Build structured output with `JSON_ARRAYAGG` and `JSON_OBJECTAGG`, and create delimited text with `STRING_CONCAT_WS`. You can also use the `||` operator for string concatenation and `UNISTR` for Unicode escape sequences.
- **Encoding and similarity functions**: Encode and decode text with `BASE64_ENCODE` and `BASE64_DECODE`, and compare strings with `STRING_SIMILARITY`, `EDIT_DISTANCE`, `EDIT_DISTANCE_SIMILARITY`, `JARO_WINKLER_DISTANCE`, and `JARO_WINKLER_SIMILARITY`.
- **Date and numeric enhancements**: Work with `CURRENT_DATE`, `DATEADD` with `bigint`, and the `PRODUCT()` aggregate for multiplicative calculations.

## Learning objectives

Upon completing this module, you should be able to:

- Understand the new and enhanced T‑SQL features in SQL Server 2025.  
- Apply these capabilities to integrate AI, parse and format text, build JSON output, and support analytics.  
- Choose the right function or operator to keep queries readable and efficient.

## Prerequisites

- SQL Server 2025  
- Basic working knowledge of SQL Server and query processing  
- Fundamental knowledge of Transact‑SQL (T‑SQL)  
- Familiarity with functions, operators, and JSON handling in SQL Server

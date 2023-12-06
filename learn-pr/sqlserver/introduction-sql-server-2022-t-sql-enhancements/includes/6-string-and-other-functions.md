---
ms.custom:
  - build-2023
---
In SQL Server 2022, new features have been added to several of our string manipulation functions, enhancing them for greater flexibility. Previously, SQL Server provided LTRIM, RTRIM, and TRIM functions to remove leading and trailing spaces. In SQL Server 2022, these functions have been enhanced to allow specifying a set of characters to remove. Additionally, the STRING_SPLIT function now offers an optional parameter for returning an index value of each substring's position in the input string.

## LTRIM, RTRIM, and TRIM

In SQL Server 2022, LTRIM and RTRIM functions have been enhanced with an optional *characters* parameter that allows you to specify a set of characters to be removed from the beginning or end of the string. The TRIM function has also been enhanced to remove specified characters from the start, end or both of a string using the LEADING, TRAILING or BOTH keywords.

## STRING_SPLIT

SQL Server 2022 adds a third optional *ordinal* parameter to the end of the STRING_SPLIT function, enabling the option to create a 1-based index array of values for each substring's position in the input string. By default, the function has the value of zero or *disabled*. To enable it, set it to the value of 1, or *enabled*. The output rows might be in any order, since the sort order isn't guaranteed to match the order of the original string.

## Easily remove prefix and postfix characters using LTRIM, RTRIM and TRIM

The marketing team needs to send some fliers to our customers for our latest holiday sale, but would like to know if any of them are using a P.O. Box. They ask our DBA team to list our customers whose address is a P.O. Box, and return the name of the customer name, the postal code and the number. When you use the new capability of LTRIM, RTRIM and TRIM you should be able to easily return the requested data.

```sql
SELECT P.FirstName + ' ' + ISNULL(P.MiddleName,'') + ' ' + P.LastName AS Name
	, LTRIM(A.AddressLine1,'POBoxN.# ') AS POBox
	, PostalCode
FROM AdventureWorks2012.Sales.Customer C
	JOIN AdventureWorks2012.Person.Person P ON P.BusinessEntityID = C.PersonID
	JOIN AdventureWorks2012.Person.BusinessEntityAddress BEA on P.BusinessEntityID = BEA.BusinessEntityID
	JOIN AdventureWorks2012.Person.Address A ON A.AddressID = BEA.AddressID
WHERE LOWER(AddressLine1) like 'p%o%box%'
```

Results:

| Name | POBox | PostalCode |
|---|---|---|
| Chase  Cox | 8070 | 92806 |
| Darren  Prasad | 1052 | 4169 |
| Jordyn N Griffin | 9178 | 98027 |
| Barbara  Xu | 2851 | 4217 |
| Destiny  Jones | 9257 | 4217 |
| Nicole J Bryant | 4559 | 98020 |
| Clayton  Anand | 5413 | Y024 1GF |
| Sarah V Davis | 1053 | 98168 |
| Nathan  Nelson | 2851 | 97005 |
| Ashlee N Chande| 2513 | 2113 |
| Cedric  Huang | 9257 | 90210 |
| Jeffery J Lin | 4559 | 7001 |
| Douglas  Subram | 8070 | 5023 |
| Stephanie N Young | 2513 | 98312 |
| Alexia  Washington | 1052 | V8P |
| Randy J Zhao | 2162 | 2450 |
| Aidan  Henderson | 5413 | 98168 |
| Neil N Ruiz | 9178 | W10 6BL |

In this example, we used the LTRIM function to clean up the P.O. Box by removing the unwanted prefixes, providing the marketing team with the requested data. Notice how the characters included in the search set include all the characters in the possible prefixes we defined.

## GREATEST and LEAST

The GREATEST and LEAST functions are new to SQL Server 2022, and they return the maximum and minimum values from a list of expressions, respectively.

With the improvements to LTRIM, RTRIM, TRIM, and STRING_SPLIT in SQL Server 2022, you can boost your database query abilities. Additionally, the introduction of GREATEST and LEAST functions enables more efficient handling and analysis of your data.

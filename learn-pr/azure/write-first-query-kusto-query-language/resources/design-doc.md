# Write your first query with Kusto Query Language

## Role(s)

Data scientist  
Data analyst  
Business analyst  
Security Operations Analyst

## Level

Beginner

## Product(s)

Kusto Query Language

## Prerequisites

* An Azure subscription. Create a [free Azure account](https://azure.microsoft.com/free/).

## Summary

Get started by writing simple queries in Kusto Query Language (KQL) to explore and gain insights from your data. Learn how to use the most common query filters take, project, where, count, and sort.

## Learning objectives

1. Write your first query with Kusto Query Language (KQL)
1. Use KQL to filter data by using the operators take, project, count, where, and sort.

## Chunk your content into subtasks

Identify the subtasks of module title.

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: Exercise or Knowledge check? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Introduce basic structure of KQL | TODO | Knowledge check at end | Write your first query with Kusto Query Language | yes |
| Use the take operator | TODO | Exercise | Use KQL to filter data by using the operators take, project, count, where, and sort. | yes |
| Use the project operator | TODO | Exercise | Use KQL to filter data by using the operators take, project, count, where, and sort. | yes |
| Use the where operator | TODO | Exercise | Use KQL to filter data by using the operators take, project, count, where, and sort. | yes |
| Use the count operator | TODO | Exercise | Use KQL to filter data by using the operators take, project, count, where, and sort. | yes |
| Use the sort operator | TODO | Exercise | Use KQL to filter data by using the operators take, project, count, where, and sort. | yes |

## Outline the units

Add more units as needed for your content

1. **Introduction**

    You're a data analyst with a passion for meteorological data. You want to use KQL to explore and prepare a dataset that will enable you to answer basic questions about the kinds and locations of storms in the US.

1. Basic structure of a KQL query
    - Each operator consumes tabular input and produces tabular output.
    - Query statements- single or multiple.
    - Operators sequenced using a pipe.
    - Operators are KQL-specific, although often have parallels to SQL or other languages
    - Data sets are sequentially processed according to pipes.
    - Statements are separated with a semicolon.
1. **Exercise:** return specific number of rows by using the `take` operator
    - Explore data
    - Each time returns random rows
    - Returns unaltered rows with all columns
    - notice aspects of returned data, such as column names and types of data included
1. **Exercise:** select columns to return by using the `project` operator
    - Selects which columns to include in output. For example, you only want to see the state and the kind of storm.
    - take 10 and project certain columns - e.g just the states, type of storm.
1. **Exercise:** filter data by using the `where` operator
    - Filter based on a certain value in the column(s)
    - Used together with other operators, for example string operators
    - By itself, is not performing data manipulations, just filtering
    - Filter to return certain kinds of storms (e.g. including the word "wind" or "flood")
WHEN ACTUALLY WRITING IT, THIS DOESN'T FIT HERE. Will keep dcount() and count() to agg functions, and count on its own is pretty useless
    1. **Exercise:** count instances by using the `count` operator
        - You can count how many instances or distinct instances there are for a certain set of conditions. 
        - Attach to the `where` operator.
        - Count how many different kinds of storms include the word "wind". 
1. **Exercise:** reorder returned data by using the `sort` operator
    - Reorders data based on asc/desc for a particular column
1. **Exercise:** Build queries using multiple operators
1. **Challenge**
    - Give them a question - e.g. how many different kinds of storms were there in Alaska? and ask them to construct a query that answers this.
1. **Solution**
1.   **Knowledge check**

      - Ask about inputs/outputs
      - Ask about piping
      - Significance of order in pipes
1. **Summary**  
    
We learned how KQL queries are constructed, and used simple KQL queries to explore a new dataset. By using some of the most common operators such as project, where, take, count, and sort, we were able to filter the dataset and view a specified subset of the data. We used these queries to draw basic insights from the data, such as how many or what kinds of events occurred by areas.

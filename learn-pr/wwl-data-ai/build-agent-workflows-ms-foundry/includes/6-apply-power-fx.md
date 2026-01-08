Power Fx is the low-code, Excel-like language that acts as the glue of a workflow. It allows you to manipulate data, evaluate conditions, and control the flow of execution without writing complex code. In a workflow, Power Fx formulas are used wherever decisions are made, variables are set, or loops are applied, enabling workflows to react dynamically to user input, agent outputs, or stored data.

## How formulas work

A Power Fx formula is an expression that evaluates to a value. Formulas can reference **system** and **local** variables:

- **System variables** provide contextual information about the workflow or conversation, such as the current activity, last message, or user info.  
- **Local variables** store data captured or created during workflow execution and can be used in subsequent nodes.

For example, you might create formulas to:

- Convert a user's input to uppercase: `Upper(Local.Input)`  
- Check whether an agent's confidence score is above a threshold: `Local.Confidence > 0.8`  
- Sum values in a list or a column of records: `Sum(Local.ItemList, Amount)`  

Using variables in formulas allows workflows to adapt based on context and previous steps.

## Conditions as decision points

Power Fx expressions are commonly used in **If/Else** nodes to evaluate conditions and branch execution. Conditions can reference system or local variables, structured agent outputs, or other workflow data. For example, a workflow might check an agent's confidence score to decide whether to continue processing automatically or escalate to a human.

## Loops for processing multiple items

**For-each** nodes use Power Fx to iterate over collections, applying the same set of actions to each item. By combining loops with variables and conditions, workflows can handle lists of inputs—such as multiple support tickets—without duplicating nodes or logic.

## Power Fx formula examples

| Purpose | Formula Example | Notes |
|---------|----------------|-------|
| Convert text to uppercase | `Upper(Local.Input)` | Transforms a string to all caps |
| Convert text to lowercase | `Lower(Local.Input)` | Transforms a string to all lowercase |
| Get string length | `Len(Local.Input)` | Returns the number of characters in a string |
| Conditional check | `Local.Confidence > 0.8` | Returns true/false; used in If/Else nodes |
| If/Else logic | `If(Local.Confidence > 0.8, "Proceed", "Escalate")` | Returns one of two values depending on a condition |
| Sum a list of numbers | `Sum([10, 20, 30])` | Adds up numbers in a simple list |
| Sum a column in a table | `Sum(Local.ItemList, Amount)` | Adds up the `Amount` property of each record in a table |
| Count items in a table or list | `Count(Local.ItemList)` | Returns the number of items |
| Check if blank | `IsBlank(Local.Input)` | Returns true if variable or input is empty |
| Check if empty table | `IsEmpty(Local.ItemList)` | Returns true if a table has no records |
| Loop over items | `ForAll(Local.ItemList, Upper(Name))` | Applies a formula to each item in a list or table |
| Concatenate text | `Concatenate(Local.FirstName, " ", Local.LastName)` | Joins multiple strings into one |

By using Power Fx formulas throughout a workflow, you create dynamic, data-driven processes that respond intelligently to inputs and agent outputs. This low-code approach empowers you to build complex logic while keeping workflows maintainable and understandable.

> [!TIP]
> For more information about the Power Fx language, refer to the [Power Fx documentation](/power-platform/power-fx/overview?azure-portal=true).
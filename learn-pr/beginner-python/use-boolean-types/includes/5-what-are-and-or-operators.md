You might occasionally want to combine test expressions to evaluate multiple conditions in one `if`, `elif`, or `else` statement. To do this, you use the Boolean operators `and` and `or`. 

## The `or` operator

You can connect two Boolean, or test, expressions by using the Boolean `or` operator. For the entire expression to evaluate to `true`, at least one of the subexpressions must be true. If none of the subexpressions is true, the whole expression evaluates to `false`. For example, in the following expression, the entire test expression evaluates to `true`, because one of the conditions in the subexpressions has been met:

```python
a = 23
b = 34
if a = 34 or b = 34:
    print(a + b)
```

If both subexpressions are true, the entire test expression also evaluates to `true`.

A Boolean expression that uses `or` has the following syntax:

```python
sub-expression1 or sub-expression2
```

## The `and` operator

You can also connect two test expressions by using the Boolean `and` operator. Both conditions in the test expression must be true for the entire test expression to evaluate to `true`. In any other case, the test expression is `false`. In the following example, the entire test expression evaluates to `false`, because only one of the conditions in the subexpressions is true:

```python
a = 23
b = 34
if a = 34 and b = 34:
    print (a + b)
```

A Boolean expression that uses `and` has the following syntax:

```python
sub-expression1 and sub-expression2
```

## The difference between `and` and `or`

To highlight the difference between the two Boolean operators, you can use a *truth table*. A truth table shows you what the entire test expression evaluates to based on the two subexpressions. 

Here's the truth table for `and`:

| `subexpression1` | Operator | `subexpression2` | Result |
|-----------------|----------|-----------------|--------|
| `true`            | `and`      | `true`            | `true`   |
| `true`            | `and`      | `false`           | `false`  |
| `false`          | `and`      | `true`            | `false`  |
| `false`           | `and`      | `false`           | `false`  |

Here's the truth table for `or`:

| `subexpression1` | Operator | `subexpression2` | Result |
|-----------------|----------|-----------------|--------|
| `true`            | `or`       | `true`            | `true`   |
| `true`            | `or`       | `false`           | `true`   |
| `false`           | `or`       | `true`            | `true`   |
| `false`           | `or`       | `false`           | `false`  |

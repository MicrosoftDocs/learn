Sometimes, you'll want to combine test expressions to evaluate multiple conditions in one `if`, `elif`, or `else` statement. To do this, you'll need to use the Boolean operators `and` and `or`. 

## The or operator

You can connect two Boolean, or test, expressions using the Boolean `or` operator. For the entire expression to be true, at least one of the subexpressions must be true. If none of the subexpressions are true, then the whole expression is false. For example, in this expression, the entire test expression would evaluate to `True`, since one of the conditions in the subexpressions has been met:

```python
a = 23
b = 34
if a = 34 or b = 34:
    print(a + b)
```

If both subexpressions are true, the entire test expression will also evaluate to `True`.

Here's the syntax for a Boolean expression using `or`:

```python
sub-expression1 or sub-expression2
```

## The and operator

You can also connect two test expressions using the Boolean `and` operator. Both conditions in the test expression must be true in order for the entire test expression to be `True`. In any other case, the test expression is `False`. For example, in this expression, the entire test expression would evaluate to `False`, since only one of the conditions in the subexpressions is `True`:

```python
a = 23
b = 34
if a = 34 and b = 34:
    print (a + b)
```

Here's the syntax for a Boolean expression using `and`:

```python
sub-expression1 and sub-expression2
```

## The difference between and and or

To highlight the difference between the two Boolean operators, you can use a **truth table**. A truth table shows you what the entire test expression evaluates to based on the two subexpressions. Here's the truth table for `and`:

| `sub-expression1` | Operator | `sub-expression2` | Result |
|-----------------|----------|-----------------|--------|
| `true`            | `and`      | `true`            | `true`   |
| `true`            | `and`      | `false`           | `false`  |
| `false`          | `and`      | `true`            | `false`  |
| `false`           | `and`      | `false`           | `false`  |

And here's the truth table for `or`:

| `sub-expression1` | Operator | `sub-expression2` | Result |
|-----------------|----------|-----------------|--------|
| `true`            | `or`       | `true`            | `true`   |
| `true`            | `or`       | `false`           | `true`   |
| `false`           | `or`       | `true`            | `true`   |
| `false`           | `or`       | `false`           | `false`  |

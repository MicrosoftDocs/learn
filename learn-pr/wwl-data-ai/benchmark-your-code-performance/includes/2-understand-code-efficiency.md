## Understand code efficiency

Two functions can solve the same problem and run at very different speeds. The difference comes from the **algorithm**, which is the set of steps the code follows.

Consider finding a name in a phone book with 1 million names:

- **Approach 1**: Check every page in order until you find the name. In the worst case, this takes 1 million checks.
- **Approach 2**: Use the alphabetical order. Open the middle page, decide whether the name comes before or after it, and discard half the names. Repeat. This finds any name in about 20 checks.

The problem is the same, but the second approach does far less work. This is **algorithmic efficiency**.

### Describe growth with Big O notation

**Big O notation** describes how the number of steps an algorithm takes grows as the data grows. It doesn't measure time in milliseconds. It describes a pattern that you can use to compare algorithms.

#### O(1): constant time

The number of steps doesn't change when the data grows.

```python
def get_first_item(my_list):
    return my_list[0]
```

Getting the first item takes the same time for a list of 10 items or 10 million items.

#### O(n): linear time

The number of steps grows in proportion to the data.

```python
def find_maximum(my_list):
    max_value = my_list[0]
    for item in my_list:
        if item > max_value:
            max_value = item
    return max_value
```

The loop runs once for each item. With 100 items, it runs 100 times. With 1 million items, it runs 1 million times.

#### O(n²): quadratic time

The number of steps grows with the square of the data. Nested loops over the same data are a common cause.

```python
def find_duplicates(my_list):
    duplicates = []
    for i in range(len(my_list)):
        for j in range(i + 1, len(my_list)):
            if my_list[i] == my_list[j]:
                duplicates.append(my_list[i])
    return duplicates
```

The function compares every item with every item after it. With 100 items, that's about 5,000 comparisons. With 1,000 items, it's about 500,000 comparisons. Ten times more data means about 100 times more work.

### Compare the patterns

The following table shows what happens to the number of steps when you double the data:

| Pattern | Name | Effect of doubling the data |
|---|---|---|
| O(1) | Constant | No change. |
| O(n) | Linear | The work doubles. |
| O(n²) | Quadratic | The work quadruples. |

For a list of 1 million items, an O(n) algorithm takes about 1 million steps. An O(n²) algorithm takes about 1 trillion steps, which can be impractical.

The choice of algorithm usually matters more than small changes to the code. A slow O(n²) algorithm eventually loses to an O(n) algorithm, no matter how carefully you tune it.

### Decide when efficiency matters

Not every function needs to be efficient. Ask these questions:

- Does the data become large, for example more than a few thousand items?
- Does the function run frequently?
- Is there a different approach that does less work?

An O(n²) function that processes 10 items once is fine. The same function in a search that runs thousands of times on millions of items is a serious problem.

## Measure and profile code performance

Big O notation predicts how code scales. To learn how fast code actually runs, you measure it. When a whole program is slow, you profile it to find the function that causes the delay. This unit teaches both techniques.

### Measure with timeit

Python's built-in `timeit` module measures how long code takes to run. The following code compares two ways to add the numbers from 0 through 999:

```python
import timeit

def sum_with_loop():
    total = 0
    for i in range(1000):
        total += i
    return total

def sum_with_builtin():
    return sum(range(1000))

time1 = timeit.timeit(sum_with_loop, number=10000)
time2 = timeit.timeit(sum_with_builtin, number=10000)

print(f"Loop version: {time1:.4f} seconds")
print(f"Built-in version: {time2:.4f} seconds")
print(f"Built-in is {time1 / time2:.1f}x faster")
```

```output
Loop version: 0.2306 seconds
Built-in version: 0.0888 seconds
Built-in is 2.6x faster
```

Your times differ, but the built-in version is faster.

The `number=10000` argument runs the function 10,000 times and returns the total time. Running the code many times smooths out small variations in your computer's speed.

Both versions are O(n), so Big O doesn't explain the difference. The built-in `sum` is faster because Python runs it in optimized C code, while the loop runs as Python code. Big O describes how the work grows, and measuring shows how much each step costs.

### Measure at different data sizes

To see the Big O pattern, time the same function with more data. The `timeit` function needs a function that takes no arguments, so wrap a call that takes arguments in a `lambda`, as the following example does. The function counts duplicate values by comparing every pair of items, so it's O(n²):

```python
import timeit

def count_duplicates(numbers):
    count = 0
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            if numbers[i] == numbers[j]:
                count += 1
    return count

for size in [500, 1000, 2000]:
    data = list(range(size))
    time_taken = timeit.timeit(lambda: count_duplicates(data), number=3)
    print(f"{size:5d} items: {time_taken:.3f}s")
```

```output
  500 items: 0.009s
 1000 items: 0.040s
 2000 items: 0.156s
```

Each time the data doubles, the time roughly quadruples. This matches the O(n²) pattern from the previous unit.

### Decide what to measure

Don't measure every function. Measure when:

- A function runs frequently.
- A function handles large amounts of data.
- You have two approaches and can't decide between them.
- Users report that something is too slow.

A function that runs once at startup rarely needs measuring. A function that runs millions of times does.

### Find the bottleneck with cProfile

Timing a function shows how fast that function is. When a whole program is slow, you need to know which function to focus on. A **bottleneck** is the part of a program that limits its overall speed, and a **profiler** finds it by reporting where the program spends its time.

Python's built-in `cProfile` module reports how many times each function was called and how long each one took. The following program has three steps, and one of them is slow:

```python
import cProfile


def load_numbers(count):
    return list(range(count))


def find_pairs(numbers, target):
    pairs = []
    for i in range(len(numbers)):
        for j in range(len(numbers)):
            if numbers[i] + numbers[j] == target:
                pairs.append((numbers[i], numbers[j]))
    return pairs


def summarize(pairs):
    return len(pairs)


def run_report():
    numbers = load_numbers(2000)
    pairs = find_pairs(numbers, 100)
    return summarize(pairs)


cProfile.run("run_report()", sort="tottime")
```

The `sort="tottime"` argument lists the functions that spent the most time first. The output looks like this:

```output
         2110 function calls in 0.172 seconds

   Ordered by: internal time

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.172    0.172    0.172    0.172 profile_example.py:8(find_pairs)
     2002    0.000    0.000    0.000    0.000 {built-in method builtins.len}
        1    0.000    0.000    0.172    0.172 profile_example.py:21(run_report)
        1    0.000    0.000    0.000    0.000 profile_example.py:4(load_numbers)
        1    0.000    0.000    0.000    0.000 profile_example.py:17(summarize)
```

Your times and some lines differ. These columns matter most:

| Column | Meaning |
|---|---|
| `ncalls` | How many times the function was called. |
| `tottime` | Time spent inside the function itself, not counting the functions it calls. |
| `cumtime` | Time spent in the function and everything it calls. |

The `find_pairs` function has almost all of the `tottime`, so it's the bottleneck. The nested loops make it O(n²). Optimizing `load_numbers` or `summarize` wouldn't help, because they take almost no time.

### Follow the optimization workflow

Use the same steps each time:

1. **Measure the whole program.** Record how slow it is.
2. **Profile to find the bottleneck.** Identify the function with the most time.
3. **Measure that function.** Check how much time you could save.
4. **Optimize if it's worth it.** Make sure the gain justifies the added complexity.
5. **Measure again.** Confirm that the change made the program faster and that it still returns the same result.

The biggest gains usually come from a better algorithm, such as replacing an O(n²) approach with an O(n) approach. Small changes, such as removing a variable, rarely matter.

### Avoid premature optimization

The computer scientist Donald Knuth wrote that "premature optimization is the root of all evil." In practice, this means:

- Don't optimize code that's already fast enough.
- Don't guess where the bottleneck is. Measure it.
- Don't make code harder to read to save a millisecond.

Profiling lets you spend your effort where it makes a difference.

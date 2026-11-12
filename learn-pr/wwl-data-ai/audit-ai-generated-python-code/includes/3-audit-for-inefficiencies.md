AI-generated code is often correct but slow. A function that returns the right result in 10 seconds when it should take 0.1 seconds still needs to be fixed.

**Inefficiency** is code that produces the correct result but wastes time or resources.

### Why inefficiency matters

Code that performs well on 10 items can slow down significantly as the data grows. A production application might need to process 1 million items.

The following example works correctly on small lists:

```python
# AI-generated code: correct for small lists
def find_duplicates(numbers):
    duplicates = []
    for i in range(len(numbers)):
        for j in range(len(numbers)):  # Compares every item with every other item
            if i != j and numbers[i] == numbers[j]:
                duplicates.append(numbers[i])
    return duplicates

# Correct, but the cost grows quickly:
# - 100 items: 10,000 comparisons
# - 1,000 items: 1 million comparisons
# - 1 million items: 1 trillion comparisons (very slow)
```

The AI didn't account for scale. The code is correct, but inefficient.

### Common inefficiencies in AI code

**1. Repeated calculations**

```python
# Inefficient: reads the same file on every iteration
for order in orders:
    tax_rate = load_tax_rate_from_file()  # Reads the file again each time
    total = order.subtotal * tax_rate

# Better: read the file once, before the loop
tax_rate = load_tax_rate_from_file()
for order in orders:
    total = order.subtotal * tax_rate
```

**2. Inefficient string operations**

```python
# Inefficient: creates a new string on every iteration
result = ""
for word in words:
    result = result + word + ", "  # Creates new string each time

# Better: use join()
result = ", ".join(words)  # Joins the words in one step
```

**3. Searching a list when a set would work**

```python
incoming = list(range(10_000))

# Inefficient: "in" checks each item in the list one at a time
allowed_ids = list(range(100_000))
accepted = [x for x in incoming if x in allowed_ids]

# Better: a set lookup takes about the same time regardless of size
allowed_ids = set(range(100_000))
accepted = [x for x in incoming if x in allowed_ids]
```

### How to spot inefficiency

Ask these questions:

1. **Are there nested loops?** Nested loops often mean O(n²) complexity, which is slow for large data
2. **Is something calculated repeatedly?** Move it outside the loop
3. **Are there simpler built-in methods?** Python has efficient built-in functions; use them
4. **Would this code slow down with 1 million items?** If yes, it's probably inefficient

### Testing for inefficiency

The best way to catch inefficiency is to test with realistic data sizes:

```python
import timeit

# AI's version
def slow_find_duplicates(numbers):
    duplicates = []
    for i in range(len(numbers)):
        for j in range(len(numbers)):
            if i != j and numbers[i] == numbers[j]:
                duplicates.append(numbers[i])
    return duplicates

# Time it with 5,000 items
data = list(range(5000))
time_taken = timeit.timeit(lambda: slow_find_duplicates(data), number=1)
print(f"Time: {time_taken:.2f} seconds")  # Takes several seconds on most computers
```

If it takes noticeably long for reasonable data sizes, it's inefficient.

### Write a unit test for performance

Timing a function once in a script is useful for investigation, but it doesn't stop the problem from returning. A unit test with a time limit catches regressions automatically. The following pytest test checks a corrected version of `find_duplicates` that uses a set:

```python
import time

def find_duplicates(numbers):
    seen = set()
    duplicates = set()
    for n in numbers:
        if n in seen:
            duplicates.add(n)
        seen.add(n)
    return list(duplicates)

def test_find_duplicates_handles_large_input():
    data = list(range(1_000_000))  # No duplicates in this input
    start = time.perf_counter()
    result = find_duplicates(data)
    elapsed = time.perf_counter() - start
    assert result == []
    assert elapsed < 1.0, f"find_duplicates took {elapsed:.2f} seconds"
```

The set-based version returns each duplicate value once. The original version appends every extra occurrence, so `[1, 1, 1]` returns `[1, 1]` from the original and `[1]` from the corrected version. Check that a correction keeps the behavior your code needs. The nested-loop version would take hours on this input, so the problem is visible as soon as the test runs. Set the time limit based on your application's requirements, and run the test on the same hardware where the code will run.

### The review checklist

When auditing AI code for efficiency, ask:

- Are there nested loops? (Often inefficient)
- Is anything calculated multiple times? (Should be calculated once)
- Are simpler built-in methods available?
- Would this code struggle with 10x the data?
- Does it use appropriate data structures? (List for order, set for uniqueness)

Inefficient code passes tests on small inputs, so it's easy to miss. In production, it causes slow load times, poor user experience, and higher server costs. Check for it before the code reaches production.

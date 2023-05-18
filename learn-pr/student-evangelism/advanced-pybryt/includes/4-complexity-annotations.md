Complexity annotations can be used to assert that a block of student code runs within a certain level of complexity. PyBryt determines the complexity of a block of student code by comparing the number of execution steps for various input lengths. It then uses least-squares to determine which complexity class best represents the relationship.

Making use of complexity annotations is a two-part endeavor: First, you must create an annotation that tells PyBryt to look for time complexity in the memory footprint. Second, you must also create a block of code in the student's submission that tells PyBryt, which block of code to run the complexity check on.

Creating the annotation is simple: just instantiate the `pybryt.TimeComplexity` class. This annotation takes as its argument a complexity class supplied by the module `pybryt.complexities`:

```python
>>> import pybryt.complexities as cplx
>>> cplx.complexity_classes
[pybryt.annotations.complexity.complexities.constant,
 pybryt.annotations.complexity.complexities.logarithmic,
 pybryt.annotations.complexity.complexities.linear,
 pybryt.annotations.complexity.complexities.linearithmic,
 pybryt.annotations.complexity.complexities.quadratic,
 pybryt.annotations.complexity.complexities.cubic]
```

The `TimeComplexity` constructor also requires the `name` option to be supplied, as this option is how the data from the student's submission is tied to the annotation.

```python
>>> pybryt.TimeComplexity(cplx.linear, name="foo")
pybryt.TimeComplexity
```

And that's all that's required on the reference implementation end. The real work of checking the time complexity of students' code comes in writing the scaffold provided to students, which must use PyBryt's `check_time_complexity` context manager to mark a block of code as a block that should be checked for time complexity. This context manager accepts as arguments the name of the block (which should be the same as the `name` provided to the annotation) and the size of input being run in that context.

For example, consider a basic exponentiation algorithm where the size of the input is the power that the base is being raised to.

```python
def power(b, p):
    if p == 0:
        return 1
    return b * power(b, p - 1)

with pybryt.check_time_complexity("foo", 10):
    assert power(2, 10) == 2 ** 10
```

One data point, however, isn't enough. To collect data for multiple input sizes, you can use the context manager with the same name and vary the input length:

```python
for p in [2, 5, 10, 15, 20]:
    with pybryt.check_time_complexity("foo", p):
        assert power(2, p) == 2 ** p
```

For simplicity, if the input you're running is an object that supports `len` for determining its size, you can also just pass the input itself as the second argument:

```python
l = [1, 2, 3]
with pybryt.check_time_complexity("bar", l):
    sort(l)
```

When used in the student's code, or in any context where PyBryt isn't executing the notebook to generate a memory footprint, the `check_time_complexity` context does nothing. However, when PyBryt is running the code, it tracks the number of steps it takes to execute the block. Because the input lengths that are needed to accurately measure time complexity can get unworkably high, PyBryt doesn't trace for values inside these contexts. Any calls that are needed to satisfy value annotations must occur **outside** a `check_time_complexity` context. Otherwise, PyBryt doesn't see the value in the student's memory footprint.

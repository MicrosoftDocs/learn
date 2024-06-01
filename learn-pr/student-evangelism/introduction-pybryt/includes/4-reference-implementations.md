A [**reference implementation**](https://microsoft.github.io/pybryt/html/reference_implementations.html) defines a set of conditions for validating a solution to a problem. A set of reference implementations defines the different solutions to a problem set for students, and allow instructors to validate unstructured student code for algorithmic correctness. In PyBryt, these references take the form of the [`pybryt.ReferenceImplementation`](https://microsoft.github.io/pybryt/html/api_reference.html#pybryt.reference.ReferenceImplementation) object, which houses a series of annotations that assert conditions on the memory footprint of a submission.

Reference implementations can be put to different uses: you might write some based on correct implementations to validate that a submission follows an accepted format, or write some that match incorrect solutions to flag common issues for students. Coupling these validations with descriptive annotation messages allows for a robust automated feedback system for student work.

## Creating and checking reference implementations

Reference implementations can be created in a couple of ways: programmatically, by collecting annotations into a list and instantiating the `pybryt.ReferenceImplementation` object, or via compiling a reference notebook that contains annotations. PyBryt automatically tracks every annotation that gets created. So, when compiling a notebook, it isn't necessary to collect the annotations into a list or create a reference implementation object. Instead, PyBryt assumes that all of the annotations are part of a single reference implementation and creates the object for you. You can find more information about compiling references [here](https://microsoft.github.io/pybryt/html/reference_implementations.html#automatic-reference-creation).

To create a reference implementation programmatically, as we'll in this module, annotations are collected into a list, which is then passed to the `pybryt.ReferenceImplementation` constructor along with the name of the reference. Let's construct a reference for finding the [hailstone sequence](https://en.wikipedia.org/wiki/Collatz_conjecture) of a number. The function `hailstone` returns the sequence as a list and contains annotations for tracking the progress of the list construction. The annotations are then stored in `hailstone_annotations`.


```python
hailstone_annotations = []

def hailstone(n: int) -> List[int]:
    if n == 1:
        ret = [n]
    elif n % 2 == 0:
        ret = [n] + hailstone(n // 2)
    else:
        ret = [n] + hailstone(3 * n + 1)

    hailstone_annotations.append(pybryt.Value(ret))
    return ret
```

Let's test out our `hailstone` implementation. The function `run_hailstone_test_cases` runs a few test cases on a function `hailstone_fn`, which returns a number's hailstone sequence, resetting the `hailstone_annotations` list before each run so that we don't create duplicate annotations. Let's use it to test `hailstone`:


```python
def run_hailstone_test_cases(hailstone_fn):
    global hailstone_annotations
    hailstone_annotations = []

    assert hailstone_fn(9) == [9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]
    assert hailstone_fn(50) == \
        [50, 25, 76, 38, 19, 58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]
    assert hailstone_fn(117) == \
        [117, 352, 176, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]

run_hailstone_test_cases(hailstone)
```

Now let's create a reference implementation using the `hailstone_annotations` list. Call the reference `hailstone`.

```python
hailstone_ref = pybryt.ReferenceImplementation("hailstone", hailstone_annotations)
```

Using the context manager `pybryt.check`, we can run our test cases against this reference implementation to validate that everything is working:


```python
>>> with pybryt.check(hailstone_ref):
...     run_hailstone_test_cases(hailstone)
REFERENCE: hailstone
SATISFIED: True
```

## Using multiple reference implementations

Now that we understand how to construct single references, let's take a look at combining multiple references. One of PyBryt's core ideas is to be flexible and student-implementation-agnostic, allowing instructors to write multiple reference implementations for the various was that students can solve problems. To demonstrate this flexibility, let's create another reference for the hailstone sequence. The previous implementation used recursion to construct the list from the bottom-up, giving us a series of annotations that look like this:


```python
>>> [hailstone_annotations[i].initial_value for i in range(len(hailstone_annotations)) if i < 20]
[[1],
 [2, 1],
 [4, 2, 1],
 [8, 4, 2, 1],
 [16, 8, 4, 2, 1],
 [5, 16, 8, 4, 2, 1],
 [10, 5, 16, 8, 4, 2, 1],
 [20, 10, 5, 16, 8, 4, 2, 1],
 [40, 20, 10, 5, 16, 8, 4, 2, 1],
 [13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],
 [9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]]
```

But suppose that the student instead constructed the list iteratively, from the top-down:


```python
def iterative_hailstone(n: int) -> List[int]:
    ret = [n]
    while n != 1:
        if n % 2 == 0:
            n = n // 2
        else:
            n = 3 * n + 1
        ret.append(n)
        hailstone_annotations.append(pybryt.Value(ret))
    return ret
```

Let's try testing this implementation against our reference. We should see that it fails, even though `run_hailstone_test_cases` doesn't raise any errors. This failure is because the `iterative_hailstone` function is a correct implementation, but it doesn't follow the algorithm `hailstone_ref` is expecting.


```python
>>> with pybryt.check(hailstone_ref):
...     run_hailstone_test_cases(iterative_hailstone)
REFERENCE: hailstone
SATISFIED: False
```

To solve this issue, let's turn `iterative_hailstone` into its own reference:


```python
>>> iterative_hailstone_ref = pybryt.ReferenceImplementation("iterative_hailstone", hailstone_annotations)
>>> iterative_hailstone_ref
<pybryt.reference.ReferenceImplementation at 0x7fe4c242aa10>
```

To run checks against multiple reference implementations, pass in a list of them. Let's validate our old and new references using `pybryt.check`; we should see that each implementation satisfied one of the references, allowing us to check for two different kinds of implementations!


```python
>>> with pybryt.check([hailstone_ref, iterative_hailstone_ref]):
...     run_hailstone_test_cases(hailstone)
>>> print()
>>> with pybryt.check([hailstone_ref, iterative_hailstone_ref]):
...     run_hailstone_test_cases(iterative_hailstone)
REFERENCE: hailstone
SATISFIED: True

REFERENCE: iterative_hailstone
SATISFIED: False

REFERENCE: hailstone
SATISFIED: False

REFERENCE: iterative_hailstone
SATISFIED: True
```


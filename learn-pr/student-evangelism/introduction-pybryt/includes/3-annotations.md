To understand how to build a reference implementation, we must first take a look at the building blocks of reference implementations: annotations. **Annotations** are Python objects that an instructor creates to assert conditions on each submission; these conditions can be things like the presence of a value, the temporal relationship between values, or even the time complexity of a block of code. You create annotations by instantiating classes provided by the `pybryt` package.

There are three main types of annotations:

* _Value annotations_, which assert the presence of some value in the student's memory footprint
* _Relational annotations_, which assert a relationship between values in the student's memory footprint, founded in boolean logic or temporality
* _Complexity annotations_, which assert a time complexity on a block of code

In this module, we discuss the first type.

## Value annotations

[**Value annotations**](https://microsoft.github.io/pybryt/html/annotations/value_annotations.html) assert the presence of a value in the student's memory footprint. They're created by instantiating the class [`pybryt.Value`](https://microsoft.github.io/pybryt/html/api_reference.html#pybryt.annotations.value.Value), which takes the value you want to look for as its only positional argument.

Consider, for example, that you wanted to check that a student correctly initialized an array. In a reference implementation, you would initialize the array, and then create an instance of the class:


```python
>>> np.random.seed(42)
>>> arr = np.random.normal(size=(100,100))
>>> pybryt.Value(arr)
pybryt.Value
```

PyBryt tracks all of the annotations you create, so there's no need to assign them to a variable unless you want to use them to create more complex annotations.

Value annotations, when being used to check numerical values—including arrays, iterables of numbers, and dataframes—also support absolute and relative tolerance using the `atol` and `rtol` arguments:


```python
>>> value_annotation = pybryt.Value(arr, atol=1e-3)
>>> value_annotation.check_against(arr.round(3)), value_annotation.check_against(arr.round(2))
(True, False)
```

The method `pybryt.Value.check_against` returns a boolean value indicating whether the object passed to it satisfies the value annotation. As previously shown, by allowing an absolute tolerance of $10^{-3}$, the value was satisfied when the array values were rounded to three places, but failed when rounded to two places.

### Equivalence functions

While `Value` objects define an algorithm to determine whether two objects are equal, they also allow users to specify a custom equivalence function to be used for the comparison. For example, let's say you wanted to look for a string in the student's code, but were unconcerned about the capitalization of that string. You could use a custom equivalence function that compares the lowercased representation of two strings:


```python
def str_equal_lower(s1, s2):
    return s1.lower() == s2.lower()
```

Then, we could use this function to create a `Value` annotation to check hexadecimal strings, for example:


```python
>>> message = "hash me"
>>> sha1_hash = hashlib.sha1(message.encode()).hexdigest()
>>> sha1_annotation = pybryt.Value(sha1_hash, equivalence_fn=str_equal_lower)
>>> sha1_annotation.check_against(sha1_hash.upper())
True
```

## Annotation options

All annotations support options that allow you to tailor the feedback your students receive as a result of the pass or fail of those annotations. The two primary methods of providing this feedback are using the `success_message` and `failure_message` arguments in the constructor, available to all annotations:


```python
v = pybryt.Value(1, success_message="Found 1!", failure_message="Didn't find 1 :(")
```

If the value is found in the student's memory footprint, the `success_message` is included in the report that PyBryt's student implementation checker generates; if it isn't found, the `failure_message` is included. If these arguments aren't provided, no message is shown.

These messages can also be set by updating the correspondingly named fields in the annotation object:


```python
v.success_message = "Congrats!"
v.failure_message = "Try again"
```

## Collection annotations

The most basic type of relational annotation is the [collection annotation](https://microsoft.github.io/pybryt/html/annotations/collections.html), which simply collects a group of annotations together so they can be operated on as a unit. It's possible to enforce the order of the annotations in the collection (based on insertion order), but this enforcement is optional. Like all other annotations, feedback can be provided based on whether the collection is satisfied using the `success_message` and `failure_message` arguments.

To create a collection, instantiate a `pybryt.Collection`. The constructor takes any number of positional arguments, which correspond to the initial set of annotations in the collection. To initialize an empty collection, provide no positional arguments.


```python
col = pybryt.Collection(pybryt.Value(1))
```

To enforce the order of annotations in the collection, pass `enforce_order=True`:


```python
col = pybryt.Collection(pybryt.Value(1), enforce_order=True)
```

Annotations can be added to the collection using `pybryt.Collection.add`:


```python
col.add(pybryt.Value(2))
```

An annotation collection is satisfied when all of its children are satisfied and, if `enforce_order` is true, if the satisfying timestamps of its children occur in nondecreasing order. For example, let's check `col` against two memory footprints: one in which 1 occurs before 2, and the other in which 2 occurs before 1.


```python
>>> col.check(pybryt.MemoryFootprint.from_values(1, 1, 2, 2)), col.check(pybryt.MemoryFootprint.from_values(2, 1, 1, 2))
(AnnotationResult(satisfied=True, annotation=pybryt.Collection),
 AnnotationResult(satisfied=False, annotation=pybryt.Collection))
```

Annotation collections can be useful for grouping annotations together that represent parts of a problem for providing cohesive feedback. For example, if you're writing a reference for summing a list of numbers, you might put an annotation for each partial sum into a collection that has its own success and failure message. Students then get a single message in their feedback for validating their sum. You can also use this collection to enforce the ordering of the iteration over the list, to make sure students are going in the correct order.

There are several more types of relational annotations beyond just collections. You can learn more in the advanced PyBryt module.

Sometimes, it makes sense to generate a list algorithmically. Consider the code example in the preceding unit. We just wanted a list of numbers from 1 to 10. Rather than typing those numbers explicitly, you can use a _list comprehension_ to generate it:

```python
numbers = [x for x in range(1,11)] # Remember to specify a range stop value that's 1 more than the number you want.
numbers
```

The output is:

```Output
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

You can also do computation on the items generated for the list:

```python
squares = [x*x for x in range(1,11)]
squares
```

The output is:

```Output
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

You can even do logical tests on list items in the comprehension:

```python
odd_squares = [x*x for x in range(1,11) if x % 2 != 0]
odd_squares
```

The output is:

```Output
[1, 9, 25, 49, 81]
```

### Try it yourself

Use a list comprehension to generate a list of odd cubes from 1 to 2,197.

<br />

<details>
  <summary>Hint <i>(expand to reveal)</i></summary>

  ```python
  odd_cubes = [x*x*x for x in range(1, 2197) if x % 2 != 0]
  odd_cubes
  ```

  ```Output
  [1,
   27,
   125,
   343,
   729,
   1331,
   2197,
   3375,
   4913,
   ...]
  ```
  
</details>

<br /><br />

***

> [!div class="alert is-tip"]
> ### Takeaway
>
> List comprehensions are popular in Python because they enable the rapid, programmatic generation of lists. This economy and ease of use make them an essential tool for you. And, they're a necessary topic to master so you can understand Python code written by others.
>

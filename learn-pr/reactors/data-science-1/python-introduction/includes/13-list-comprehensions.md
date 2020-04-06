> [!div class="alert is-tip"]
> ### Learning goal
>
> By the end of this subsection, you should understand how to economically and computationally create lists.

Sometimes, it makes more sense to generate a list algorithmically. Consider the last example. We really wanted just a list of numbers from 1 to 10. Rather than type those out, we can use a _list comprehension_ to generate it:

> [!Note]
> **Sarah: Conversion feedback**
> 
> Consider moving the learning goal text to the list of Learning Objectives in the Introduction unit.
>

```Python
numbers = [x for x in range(1,11)] # Remember to create a range 1 more than the number you actually want.
numbers
```

```output
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

We can also perform computation on the items generated for the list:

```Python
squares = [x*x for x in range(1,11)]
squares
```

```output
[1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
```

We can even perform logical tests on list items in the comprehension:

```Python
odd_squares = [x*x for x in range(1,11) if x % 2 != 0]
odd_squares
```

```output
[1, 9, 25, 49, 81]
```

### Exercise

Use a list comprehension to generate a list of odd cubes from 1 to 2,197.

> [!div class="alert is-tip"]
> ### Takeaway
>
> List comprehensions are a popular tool in Python because they enable the rapid, programmatic generation of lists. The economy and ease of use therefore make them an essential tool for you (in addition to a necessary topic to understand as you try to understand Python code written by others).
> 
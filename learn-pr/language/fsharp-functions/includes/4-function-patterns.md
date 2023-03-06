So far, you've taken repetitious expressions and put those expressions in functions. Your code now looks better and is easier to read. As you get more used to using functions, it's worth starting to look at some powerful patterns that exist in this space. By using these patterns, you get code that's easier to read and maintain.

## Declarative vs. imperative

When you start coding, you most likely write an expression. Then you write another expression followed by another, one after another. Your focus is on solving the problem, and you're being specific about how you solve it. This approach is referred to as an *imperative* approach. There's nothing wrong with it because it solves the problem at hand. But there's another route to take, which is the *declarative* approach. You can see an example of a declarative approach when you query a database by using SQL.

Here's an example expression:

```sql
SELECT * 
FROM Students s
WHERE s.Location = "Ohio" 
```

What makes this code declarative is that you ask for *what* you want, but you don't specify *how* you want the problem solved. You leave the *how* to SQL.

You can also apply this approach to F#. The following code uses a declarative approach:

```fsharp
let studentsFromOhio = 
    allStudents  
    |> filterLocation "Ohio"
```

In the preceding code, you operate on data and ask for what you want without being specific about how you want it done. When your code looks like the preceding example, it's easy to read and to reason about. To get to this point, let's look at some useful patterns that are supported in F#.

## Functional patterns

There are some useful patterns in F# that you can use to take on a more *functional* approach. We'll cover the following patterns:

- **Composition**: A composition combines multiple functions together into one function.
- **Pipeline**: A pipeline starts with a value and then sequentially calls multiple functions by using the output from one function as the input for the next function.

### Composition

Composition is about combining functions and applying them, one after the other, in a certain order. The composition operator takes two functions and returns a new function.

When you author code, you'll often find yourself calling one function and then another function right after it. For example, you might want to order a list and filter out all products that are on discount.

In the following example, the function `add2()` is called and its result is fed to the `multiply3()` function.

```fsharp
let add2 a = a + 2
let multiply3 a = a * 3 
let addAndMultiply a =
    let sum = add2 a
    let product = multiply3 sum
    product

printfn "%i" (addAndMultiply 2) // 12
```

This pattern is so common that F# has an operator for it. The `>>` operator lets you combine two or more functions into one larger function. By using the `>>` operator, you can simplify the preceding code, like so:

```fsharp
let add2 a = a + 2
let multiply3 a = a * 3 
let addAndMultiply = add2 >> multiply3

printfn "%i" (addAndMultiply 2) // 12
```

The combined function `addAndMultiply()` applies the functions it consists of from left to right. In this example, `add2()` happens first and `multiply3()` happens last.

### Pipeline

The pipeline operator `|>` takes a function and an argument and returns a value. Let's see how the pipeline differs from composition with this example:

```fsharp
let list = [4; 3; 1]
let sort (list: int list) = List.sort list
let print (list: int list)= List.iter(fun x-> printfn "item %i" x) list

list |> sort |> print // item 1 item 3 item 4
```

In the last line of code, you start with a list of integers, `list`, which serves as input to the first function, `sort()`. The result of that operation is fed into `print()`. The main difference between pipeline and composition is that with a pipeline, you start with some data, which is a list of integers in this case, and then you lead it through a set of functions.

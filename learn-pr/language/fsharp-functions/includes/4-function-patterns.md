So you've taken repetitious expressions and put those expressions in functions. Great, your code looks a lot better, easier to read. As you get used to using functions more, it's worth starting to look at some powerful patterns that exist in this space. By using these patterns, you will get code that's easier to read and maintain. 

## Declarative versus imperative

When you start out coding, you most likely write an expression, then another expression and then another, one after another. Your focus is on solving the problem and you are being specific on how you solve the problem, this approach is referred to as an imperative approach. There's nothing wrong with it, it solves the problem at hand. However, there's another route to take, the declarative approach. You can see an example of a declarative approach when you query a database using SQL. Here's an example expression:

```sql
SELECT * 
FROM Students s
WHERE s.Location = "Ohio" 
```

What makes this code declarative is that you ask for _what_ you want, but you don't specify _how_ you want the problem solved, you leave the _how_ to SQL.

You can apply this approach to F# as well, the following code takes on a declarative approach:

```fsharp
let studentsFromOhio = 
    allStudents  
    |> filterLocation "Ohio"
```

Above you're able to operate on data, asks for what you want, but without being specific on how you want it done, just like with SQL. When your code looks like the above, it's easy to read, and to reason about. But to get to this point, let's look at some useful patterns that's supported in F#.

## Functional patterns

There are some useful patterns in F# that allows you to take on a more _functional_ approach. We will cover the following patterns:

- **Composition**, is how you connect several functions together into one function.
- **Pipeline**. A pipeline starts with a value and then sequentially calls many functions using the output from one function as the input for the next function.

### Composition

Authoring code, you will often find yourself calling one function and then another function right after it. For example, you want to order a list and filter out all products that's on discount. Below is an example where the function `add2()` is called and its result is fed to the `multiply3()` function.

Here's an example:

```fsharp
let add2 a = a + 2
let multiply3 a = a * 3 
let addAndMultiply a =
    let sum = add2 a
    let product = multiply3 sum
    product
```

This pattern is so common that F# has an operator for it, the `>>`, that lets you combine two or more functions into one bigger function. By using said operator, you can it instead right the above code like so:

```fsharp
let addAndMultiply = add2 >> multiply3
addAndMultiply 2 // 12
```

What happens is that the combined function `addAndMultiply()` applies the functions it consists of from left to right, so first `add2()` happens and lastly `multiply3()`.

### Pipeline

Composing is about combining functions and have them applied, one after the other, in a certain order. The composition operator takes two functions and returns a new function. A pipeline operator `|>` takes a function and an argument and returns a value. Let's see how the pipeline differs from composition with this example:

```fsharp
let list = [4; 3; 1]
let sort (list: int list) = List.sort list
let print (list: int list)= List.iter(fun x-> printfn "item %i" x) list

list |> sort |> print // item 1 item 3 item 3
```

In the last row you start off with a list of integers, `list`, and then it serves as input to the first function `sort()` and the result of that operation is fed into `print()`. The big difference from composition is that you start with some data, a list of integers in this case, and then you lead it through a set of functions.

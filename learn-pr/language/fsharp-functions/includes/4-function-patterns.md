So you've taken repetitious statements and put those statements in functions. Great, your code looks a lot better, easier to read. As you get used to using functions more, it's worth starting to look at some powerful patterns that exist in this space. "This space", refers to functional programming, and is a paradigm in computer science. 

## Declarative versus imperative

When you start out coding, you most like write a statement, then another statement and then another, one after another. Your focus is on solving the problem and you are being specific on how you solve the problem, this approach is referred to as an imperative approach. There's nothing wrong with it, it solves the problem at hand. However, there's another route to take, the declarative approach. You can see an example of a declarative approach when you query a database using SQL. Here's an example statement:

```sql
SELECT * 
FROM Students s
WHERE s.Location = "Ohio" 
```

What makes this code declarative is that you ask for _what_ you want, but you don't specify _how_ you want the problem solved, you leave the _how_ to SQL.

You can apply this approach to F# as well, the following code takes on a declarative approach:

```fsharp
let studentsFromOhio = 
  allStudents |>
  filterLocation "Ohio"
```

Above you're able to operate on data, asks for what you want, but without being specific on how you want it done, just like with SQL. When your code looks like the above, it's easy to read, and to reason about. But to get to this point, let's look at some useful patterns that's supported in F#.

## Functional patterns

There are some useful patterns in F# that allows you to take on a more _functional_ approach. We will cover the following patterns:

- **Higher order function**. A higher-order function is a function that takes a function as a parameter.
- **Composition**, is how you connect several functions together into one function.
- **Pipeline**. A pipeline starts with a value and then sequentially calls many functions using the output from one function as the input for the next function.
- **Partial application**, is when you call a function but doesn't provide all the parameter values that the function wants, the result is then a function. You can then call the returned function with the missing parameter value. This pattern is referred to as _currying_ and is popular and definitely has its uses.

### Higher-order functions

F# treats functions as values, thereby they can be passed as parameters to other functions. Here's an example of such a function:

```fsharp
let apply fn arg = fn arg

let add2 a = a + 2

printfn "%i" (apply add2 3)
```

`fn` is a function and `arg` is the parameter that's meant to be passed on to `fn`. On the second row, you have a function `add()` that takes a parameter. On the last line, you invoke `apply()` that takes `add2` and `3` as arguments.

### Composition

Composition is about combining functions to create a new function as the result. Imagine you have the following code:

```fsharp
let add2 a = a + 2
let multiply3 a = a * 3  
```

To combine these two functions, you can use the composition operator `>>` like so:

```fsharp
let addAndMultiply = add2 >> multiply3
addAndMultiply 2 // 12
```

What happens is that the combined function `addAndMultiply()` applies the functions it consists of from left to right, so first `add2()` happens and lastly `multiply3()`.

However, there's another composition operator `<<` the difference is that the functions are instead applied from right to left. Given the below code, the order of which the functions are called, is reversed:

```fsharp
let multiplyAdd = add2 << multiply3
printfn "%i" (multiplyAdd 2) // 8
``` 

The reversed calling order means that `multiply3()` is called first and lastly `add2()` is called.

Imagine you might have a more realistic scenario where you try to sort a list and then take the top three items, like so:

```fsharp
let sortAndTake = sort >> take
sortAndTake list 3
```

Intuitively you understand that were you to switch the order of how the functions are applied, you might end up with a different result, so beware of the order of which the functions are applied, when composing.

### Pipeline

Composing is about combining functions and have them applied, one after the other, in a certain order. The composition operator takes two functions and returns a new function. A pipeline operator `|>` takes a function and an argument and returns a value. Let's see how the pipeline differs from composition with this example:

```fsharp
let list = [4; 3; 1]
let sort (list: int list) = List.sort list
let print (list: int list)= List.iter(fun x-> printfn "item %i" x) list

list |> sort |> print // item 1 item 3 item 3
```

In the last row you start off with a list of integers, `list`, and then it serves as input to the first function `sort()` and the result of that operation is fed into `print()`.

### Partial application

The idea of partial application is that you don't send all the arguments to the function that it needs. When you do that, instead of the value of the function, what you get back is another function. Let's look at some code:

```fsharp
let curry a b = a + b
let partialFn = curry 1
printfn "%i" (partialFn 2) // 3
```

In the code above, the function `curry` is a function expecting two arguments. On the second line, it gets one argument instead of the required two arguments. Therefore `partialFn` is a function, rather than the finished computed value. In the last row `partialFn` is given `2` as argument and thereby the original `a + b` can be computed, which results in `3`. Why would you write these constructs like these? Well, there are situations when these partial applications make sense, or _currying_ as it's also called. Here's a more realistic example, a URL builder:

```fsharp
let urlBuilder (url:string) (route:string): string = url + route
let baseUrl = urlBuilder "http://localhost:8000/"
printfn "%s" (baseUrl "products") // http://localhost:8000/products
printfn "%s" (baseUrl "users") // http://localhost:8000/users
```  

The idea is to not having to type the same `http://loalhost:8000` over and over as soon as you want to refer to the URL. By using _currying_, we can create `baseUrl()`, which is partially applied function. By invoking `baseUrl()` with different arguments, you can create the URL you need for different routes like in the last two code lines above. Applications such as these might come in handy dealing with web applications.

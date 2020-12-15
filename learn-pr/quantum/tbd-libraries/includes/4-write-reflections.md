You are in desperate need of a book on how to save your spaceship, but the intergalactic online library only lets you search for books by their International Standard Book Number, or ISBN, a sequence of numbers which uniquely identify every book. 
You had written it down on a sticky note, but after spilling your coffee during liftoff one of the digits is now illegible.
The online library only allows three attempts when searching for a book, so you need to somehow determine the missing digit without guessing.
In the next few units you will write a Q# program to do just that using Grover's algorithm.

## ISBN check digits

Fortunately, ISBNs are not simply a random sequence of numbers. 
Instead, they utilize check digits, a type of redundancy check historically used to detect simple errors when digits are input manually.
In the ISBN 10 system, each ISBN is a ten-digit sequence and the last digit serves as the check---specifically such that the full sequence $(x_0, x_1, ..., x_9)$ satisfies the weighted sum 

$$
\left ( \sum_{i=0}^{9} (10-i) x_i \right ) \text{ mod }11 = 0.
$$

That is, the sum of the digits weighted by their position from the right must be equal to zero modulo 11.
The last term of the sum is simply $1\cdot x_9$, and thus we see why this is referred to as the check digit---if any of the digits are incorrect, then the equation will not be satisfied.
Beyond merely detecting errors, if any of the digits are entirely missing, this property can also be leveraged to determine it. 

Now, the digits you see on your sticky note are ISBN 0-306-$x$0615-2, where $x$ is just a coffee smudge where the fifth digit used to be. Since it *was* a valid ISBN, we have the equation

$$
\begin{align}
0 &= (10\cdot 0 + 9\cdot 3 + 8\cdot 0 + 7\cdot 6 + 6\cdot x + 5\cdot 0 + 4\cdot 6 + 3\cdot 1 + 2\cdot 5 + 1\cdot 2) \text{ mod } 11 \\
0 &= (9 + 6\cdot x) \text{ mod } 11
\end{align}
$$

which can only be true for the proper value of $x$. 
While this can be easily solved by a classical computer (not to mention by hand), let's assume that it cannot be. 

To find the value of $x$ with a quantum computer, Grover's algorithm can be used with an oracle that checks whether the above equation is satisfied.
In the rest of this unit, you will create and document this oracle in a new Q# project using the Standard and Numerics libraries.
Then, in the next unit, you will put it all together into Grover's algorithm and finally find that book you need. 
The instructions here are specifically for Q# via the command line in VS Code , but easily extended to other environments. 

## Grover's oracle

We need an oracle that checks whether a given $x$ satisfies the equation $0 = (9 + 6\cdot x) \text{ mod } 11$.
To do this, we need to implement the operation $(9 + 6\cdot x) \text{ mod } 11$ on a quantum register. 

### Setup

First things first, create a new Q# project. 
Some of the operations we will implement require the Numerics library, so go ahead and add that by entering in the command line
```dotnet
dotnet add package Microsoft.Quantum.Numerics
```

Next, at the beginning of the namespace in our Q# file, open the namespaces we will need for our program:
```qsharp
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Preparation;
    open Microsoft.Quantum.Diagnostics;
```

> [!NOTE]
> To do: define and explain the oracle; rename files accordingly; document oracle with API stuff
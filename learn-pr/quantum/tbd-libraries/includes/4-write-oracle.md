> [!NOTE]
> To-do: clean up some of the strucure

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

Fortunately, the operation [MultiplyAndAddByModularInteger](xref:fill) from the Artithmetic namespace of the Standard Library can be used to do just that. 
It implements the map
$$
\ket{x}\ket{b} \mapsto \ket{x}\ket{(b + a \cdot x) \text{mod} N}
$$
for a given modulus $N$ and constant integer multiplier $a$. 

To implement our map specifically then, we will need to set the $\ket{b}$ register to the number state $\ket{9}$. 
Note that each register will need consist of four qubits to accurately represent the digits 0 through 9.

Properly using this mapping as an oracle on the four-qubit data register $\ket{x}$  proceeds by first creating a four-qubit scratch register ($\ket{b}$) and preparing it in the number state $\ket{9}$ (this can be done using [ApplyXorInPlace](xref:fill)), and then performing the mapping above by providing $N=11$ and $a=6$, so
$$
\ket{x}\ket{9} \mapsto \ket{x}\ket{(9 + 6 \cdot x) \text{mod} 11}.
$$

In the remainder of this unit you will learn how to explicitly implement this operation as an oracle while defining the corresponding Q# operations. 
In the next unit, you will put it all together and finally find the book you've been needing!

### Flag the correct state by applying the oracle

Recall from the (FILL) module on Grover's algorithm that the primary function of the oracle is to flip the sign of, or *flag*, the "good" states—i.e. those which are a solution to the search problem.
This can be done using the "*phase kickback*" trick, which makes use of the fact that when a controlled `X` gate is applied to the $\ket{-}$ state, the $\ket{-}$ state remains unchanged and the corresponding states of the control register receive a factor of -1.

Supposing we have in hand the search register `missingDigitReg` and a `flagQubit` initialized to $\ket{-}$, how would we go about getting that phase factor on strictly the state $\ket{x}$ in `missingDigitReg` which satisfies $(9 + 6 \cdot x) \text{mod} 11 = 0$?
Well, we can add a secondary target register, leaving the full state of the form
$$
\ket{x}\ket{\text{target}}\ket{-},
$$
then, after first initializing $\ket{\text{target}}$ to $\ket{9}$, we apply the mapping, yielding
$$
\ket{x}\ket{(9 + 6 \cdot x) \text{mod} 11}\ket{-}.
$$

Finally, we can apply a controlled `X` gate on the $\ket{-}$ flag qubit, controlled by the target register's being in the $\ket{0}$ number state (for four qubits, technically this is $\ket{0000}$).
Thus the state of `missingDigitReg` which satisfies the equation acquires the phase factor as
$$
-1*\ket{x_{good}} \ket{0} \ket{-}
$$
and the non-solution states do not:
$$
\ket{x_{bad}} \ket{\neq 0} \ket{-}.
$$

After this, the target register can be uncomputed (handled by our `apply-within` statements) and de-allocated, having served its purpose. 

The following code defines the operation `ApplyIsbnOracle`, where `flagQubit` is our qubit in $\ket{-}$, and `ComputeIsbnCheck` is the operation which performs the arithmetic mapping to the target register.

```qsharp
    operation ApplyIsbnOracle(missingDigitReg : LittleEndian, flagQubit : Qubit) : Unit is Adj + Ctl {
        // Allocate an additional register for the target regsiter
        using (rawTarget = Qubit[Length(missingDigitReg!)]) {
            let targetReg = LittleEndian(rawTarget);
            
            within {
                ComputeIsbnCheck(missingDigitReg, targetReg);
            } apply {
                // The flag qubit will be already initialized in |-> when this is applied.
                // Thus those states where targetReg is in |0> number state (the good solutions)
                // will be flagged with a -1 phase due to the controlled X they apply to the |-> state.  
                ApplyControlledOnInt(0, X, targetReg!, flagQubit);
            }
        }
    }
```

As a part of the full Grover operation, this operation will be nested inside an operation which allocates the ancilla `flagQubit`. This is handled by the following `ReflectAboutCorrectDigit` operation. It takes only the data register as input, allocates `flagQubit` and puts it in the $\ket{-}$, and then provides both as arguments to `ApplyIsbnOracle`.

```qsharp
    operation ReflectAboutCorrectDigit(missingDigitReg : LittleEndian) : Unit is Adj + Ctl {
        using (flagQubit = Qubit()) {
            within {
                // put flagQubit in |->
                X(flagQubit);
                H(flagQubit);
            } apply {
                // uses phase kickback to flag the good solutions with a -1 phase
                ApplyIsbnOracle(missingDigitReg, flagQubit);
            }
        }
    }
```


### Apply the arithmetic to target state

We just described how the oracle itself is implemented by using the `ComputeIsbnCheck` operation, which itself performs the mapping
$$
\ket{x}\ket{\text{target}} \mapsto \ket{x}\ket{(9 + 6 \cdot x) \text{mod} 11}.
$$
So, what exactly does that operation consist of?
As mentioned above, we can take a register in $\ket{0}$, initialize it to the number state $\ket{9}$, and then perform the mapping using `MultiplyAndAddByModularInteger`.
But instead of doing this directly to the target register, we make use of another scratch register, performing the work on it before transferring it's state to the target register and de-allocating it.

The code to do this is shown below. After allocating the scratch register, it is initialized to $\ket{9}$ using `ApplyXorInPlace, and the mapping leaves it in the state $\ket{(9 + 6 \cdot x) \text{mod} 11}$. Then, it's state is transferred to the target register `targetReg` via the `CNOT` gates.

```qsharp
    operation ComputeIsbnCheck(missingDigitReg : LittleEndian, targetReg : LittleEndian) : Unit is Adj + Ctl {
        using (rawScratch = Qubit[Length(missingDigitReg!)]) {
            let scratchReg = LittleEndian(rawScratch);
            
            within {
                ApplyXorInPlace(9, scratchReg);
                MultiplyAndAddByModularInteger(6, 11, missingDigitReg, scratchReg);
            } apply {
                ApplyToEachCA(CNOT, Zipped(scratchReg!, targetReg!));
            }
            
        }
    }
```

## What's next?

In the next unit, you will put all this together and run Grover's algorithm to find the missing digit.

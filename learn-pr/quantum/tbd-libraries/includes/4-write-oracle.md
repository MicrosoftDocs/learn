You are in desperate need of a book on how to grow potatoes in outer space, but the intergalactic online library only lets you search for books by their International Standard Book Number, or ISBN, a sequence of numbers which uniquely identify every book. 
You had written it down on a sticky note, but after spilling your coffee while the spaceship went through an asteriod field,  one of the digits is now illegible.
The online library only allows three attempts when searching for a book, so you need to somehow determine the missing digit without guessing.

In the next few units you will write a Q# program to do just that using Grover's algorithm.

## ISBN check digits

Fortunately, ISBNs are not simply a random sequence of numbers. 
Instead, they utilize check digits, a type of redundancy check historically used to detect simple errors when digits are input manually.
In the ISBN 10 system, each ISBN is a ten-digit sequence and the last digit serves as the check---specifically such that the full sequence $(x_0, x_1, \ldots, x_9)$ satisfies the weighted sum 

$$
\left ( \sum_{i=0}^{9} (10-i) x_i \right ) \bmod 11 = 0.
$$

That is, the sum of the digits weighted by their position from the right must be equal to zero modulo 11.
The last term of the sum is simply $1\cdot x_9$, and thus we see why this is referred to as the check digit---if any of the digits are incorrect, then the equation will not be satisfied.
Beyond merely detecting errors, if any of the digits are entirely missing, this property can also be leveraged to determine it. 

Now, the digits you see on your sticky note are ISBN 0-306-$x$0615-2, where $x$ is just a coffee smudge where the fifth digit used to be. Since it *was* a valid ISBN, we have the equation

$$
\begin{split}
0 &= (10\cdot 0 + 9\cdot 3 + 8\cdot 0 + 7\cdot 6 + 6\cdot x + 5\cdot 0 + 4\cdot 6 + 3\cdot 1 + 2\cdot 5 + 1\cdot 2) \bmod 11 \\
0 &= (9 + 6\cdot x) \bmod 11
\end{split}
$$

which can only be true for the proper value of $x$. 

Clearly this can be easily solved by a classical computer (not to mention by hand), but let's assume that it cannot be and consider how we might solve it with a quantum computer.
Toy problems such as these, while clearly not demonstrating a scenario where quantum computing would be beneficial, are often useful in developing our understanding of various problems and approaches that may be taken. 
Then, when such a problem is at too large a scale to handle classically, you will already have the knowledge and tools to begin tackling it with a quantum computer.

To find the value of $x$ with a quantum computer, Grover's algorithm can be used with an oracle that checks whether the above equation is satisfied.
In the rest of this unit, you will create and document this oracle in a new Q# project using the Standard and Numerics libraries.
Then, in the next unit, you will put it all together into Grover's algorithm and finally find that book you need. 
The instructions here are specifically for Q# via the command line in VS Code, but easily extend to other environments. 

## Grover oracle

We need an oracle that checks whether a given $x$ satisfies the equation $0 = (9 + 6\cdot x) \bmod 11$.
To do this, we need to implement the operation $(9 + 6\cdot x) \bmod 11$ on a quantum register. 

Fortunately, the operation [MultiplyAndAddByModularInteger](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.arithmetic.multiplyandaddbymodularinteger) from the `Microsoft.Quantum.Artithmetic` namespace of the Standard Library can be used to do just that. 
It implements the mapping
$$
\ket{x}\ket{b} \mapsto \ket{x}\ket{(b + a \cdot x) \bmod N}
$$
for a given modulus $N$ and constant integer multiplier $a$. 

To implement our mapping specifically then, we will need to set the $\ket{b}$ register to the number state $\ket{9}$. 
Note that each register will need consist of four qubits to accurately represent the digits 0 through 9.

Properly using this mapping as an oracle on the four-qubit data register $\ket{x}$  proceeds by first creating a four-qubit target register (i.e. $\ket{b}$ above) and preparing it in the number state $\ket{9}$ (this can be done using the [`ApplyXorInPlace` operation](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.arithmetic.applyxorinplace)), and then performing the mapping above by providing $N=11$ and $a=6$, so
$$
\ket{x}\ket{9} \mapsto \ket{x}\ket{(9 + 6 \cdot x) \bmod 11}.
$$

In the remainder of this unit you will learn how to explicitly implement this operation as an oracle while defining the corresponding Q# operations. 
In the next unit, you will put it all together and finally find the book you've been needing!

### Flag the correct state by applying the oracle

Recall from the [module on Grover's algorithm](https://docs.microsoft.com/learn/modules/solve-graph-coloring-problems-grovers-search/5-grovers-algorithm) that the primary function of the oracle is to flip the sign of, or *flag*, the "good" states, i.e. those which are a solution to the search problem.
This can be done using the "*phase kickback*" trick, which makes use of the fact that when a controlled `X` operation is applied to the $\ket{-}$ state, the $\ket{-}$ state remains unchanged and the corresponding states of the control register receive a factor of -1.

Supposing we have in hand the search register `digitReg` and a `flagQubit` initialized to $\ket{-}$, how would we go about getting that phase factor on strictly the state $\ket{x}$ in `digitReg` which satisfies $(9 + 6 \cdot x) \bmod 11 = 0$?

Well, we can add a secondary target register initialized to $\ket{9}$, leaving the full state of the form
$$
\ket{x}\ket{9}_{\text{target}}\ket{-},
$$
and then apply the mapping, yielding
$$
\ket{x}\ket{(9 + 6 \cdot x) \bmod 11}\ket{-}.
$$

Finally, we can apply a controlled `X` operation on the $\ket{-}$ flag qubit, controlled by the target register's being in the $\ket{0}$ number state (for four qubits, technically this is $\ket{0000}$).
Thus the state of `digitReg` which satisfies the equation acquires the phase factor as
$$
-1*\ket{x_{good}} \ket{0}_{\text{target}} \ket{-}
$$
and the non-solution states do not:
$$
\ket{x_{bad}} \ket{\neq 0}_{\text{target}} \ket{-}.
$$

After this, the target register and the flag qubit can be uncomputed (handled by our `apply`/`within` statements) and de-allocated, having both served their purpose. 

The following code defines the operation `isbnOracle`, which implements the full oracle on `digitReg`. To perform the arithmetic mapping to the target register it uses the operation `ComputeIsbnCheck`, which we define further below.

```qsharp
    operation isbnOracle(digitReg : Qubit[]) : Unit is Adj + Ctl {
        // Allocate target register for oracle mapping, flag qubit for phase kickback
        using ((targetReg, flagQubit) = (Qubit[Length(digitReg)], Qubit()) ) {
            within {
                // Initialize flag qubit to |-⟩ 
                X(flagQubit);
                H(flagQubit);
                // Map targetReg to |(9 + 6x) mod 11 ⟩, where |x⟩ is the state of digitReg
                ComputeIsbnCheck(digitReg, targetReg);
            } apply {
                // States where targetReg is in |0⟩ number state will be flagged with a -1
                // phase due to controlled X they apply to the flag qubit in the |-⟩ state.  
                ApplyControlledOnInt(0, X, targetReg, flagQubit);
            }
        }
    }
```

Note that upon allocation, `targetReg` will be in the state $\ket{0}$. Therefore, `ComputeIsbnCheck` will need to first initialize


### Apply the arithmetic mapping to target state

We just described how the oracle itself is implemented using the `ComputeIsbnCheck` operation, which itself performs the mapping
$$
\ket{x}\ket{0}_{\text{target}} \mapsto \ket{x}\ket{(9 + 6 \cdot x) \bmod 11}.
$$
So, what exactly does that operation consist of?
As mentioned above, we can straightforwardly bring the target register from $\ket{0}$ to the number state $\ket{9}$ using `ApplyXorInPlace`. 
Then, the only step left to perform the mapping using `MultiplyAndAddByModularInteger`.
The code to do this is shown below.

```qsharp
    operation ComputeIsbnCheck(digitReg : Qubit[], targetReg : Qubit[]) : Unit is Adj + Ctl {
        // Being freshly allocated, targetReg will be in |0⟩ when this operation is called.
        // We first intialize it to |9⟩:
        ApplyXorInPlace(9, LittleEndian(targetReg));

        // Apply the mapping |x⟩|9⟩ -> |x⟩ |(9 + 6x) mod 11 ⟩ where |x⟩ is the state of digitReg
        MultiplyAndAddByModularInteger(6, 11, LittleEndian(digitReg), LittleEndian(targetReg));
    }
```

## What's next?

In the next unit, you will put all this together and run Grover's algorithm to find the missing digit.

You're still looking for the ISBN of a book on how to grow potatoes in outer space so that you can find it in the intergalactic online library. You're missing just one number in the sequence. The online library allows only three attempts in searching for a book, so you need to somehow determine the missing digit without guessing.

In the next few units, you'll write a Q# program to do just that by using Grover's algorithm.

## ISBN check digits

Fortunately, an ISBN isn't simply a random sequence of digits. Instead, the system uses check digits, a type of redundancy check historically used to detect simple errors when digits are entered manually.

In the ISBN 10 system, each ISBN is a 10-digit sequence, and the last digit serves as the check. The full sequence $(x_0, x_1, \ldots, x_9)$ should satisfy the following condition:

$$
\left ( \sum_{i=0}^{9} (10-i) x_i \right ) \bmod 11 = 0
$$

That is, the sum of the digits weighted by their position from the right must be divisible by 11.

The last term of the sum is simply $1\cdot x_9$, so we see why this is called the check digit. If any of the digits are incorrect, the equation won't be satisfied. The check digit goes beyond merely detecting errors. If any one digit is entirely missing, you can use this property to determine it.

The digits that you see on your sticky note are ISBN 0-306-$x$0615-2, where $x$ is just a coffee smudge where the fifth digit used to be. Because the sequence *was* a valid ISBN, we have the following equation:

$$
0 = (10\cdot 0 + 9\cdot 3 + 8\cdot 0 + 7\cdot 6 + 6\cdot x + 5\cdot 0 + 4\cdot 6 + 3\cdot 1 + 2\cdot 5 + 1\cdot 2) \bmod 11
$$
$$
0 = (9 + 6\cdot x) \bmod 11
$$

The equation can be true only for the proper value of $x$.

This problem could be easily solved by a classical computer (not to mention by hand), but let's assume that it couldn't be. Instead, consider how we might solve it with a quantum computer.

Toy problems such as these clearly don't demonstrate a scenario where quantum computing would be beneficial, but they're often useful in developing our understanding of various problems and approaches. Then, when such a problem is at too large a scale to handle classically, you'll already have the knowledge and tools to begin tackling it with a quantum computer.

To find the value of $x$ with a quantum computer, you can use Grover's algorithm with an oracle that checks whether the equation is satisfied.

In the rest of this unit, you'll create and document this oracle in a new Q# project by using the standard and numerics libraries. Then, in the next unit, you'll put it all together into Grover's algorithm and finally find that book you need.

The instructions here are specifically for Q# via the command line in Visual Studio Code, but they easily extend to other environments.

## Implementing the oracle

We need an oracle that checks whether a given $x$ satisfies the equation $0 = (9 + 6\cdot x) \bmod 11$. To do this, we need to implement the operation $(9 + 6\cdot x) \bmod 11$ on a quantum register.

Fortunately, we can use the operation [MultiplyAndAddByModularInteger](/qsharp/api/qsharp/microsoft.quantum.arithmetic.multiplyandaddbymodularinteger?azure-portal=true) from the `Microsoft.Quantum.Arithmetic` namespace of the standard library to do just that. It implements the mapping
$$
|x\rangle |b\rangle \mapsto |x\rangle|(b + a \cdot x) \bmod N\rangle
$$
for a given modulus $N$ and constant integer multiplier $a$.

To implement our mapping specifically, we need to set the $|b\rangle$ register to the number state $|9\rangle$. Note that each register will need to consist of four qubits to accurately represent the digits 0 through 9.

Properly using this mapping as an oracle on the four-qubit data register $|x\rangle$ proceeds by first creating a four-qubit target register (that is, $|b\rangle$) and preparing it in the number state $|9\rangle$. You can do this by using the [`ApplyXorInPlace` operation](/qsharp/api/qsharp/microsoft.quantum.arithmetic.applyxorinplace?azure-portal=true) and then performing the mapping by providing $N=11$ and $a=6$, like this:
$$
|x\rangle|9\rangle \mapsto |x\rangle|(9 + 6 \cdot x) \bmod 11\rangle
$$

In the remainder of this unit, you'll learn how to explicitly implement this mapping as a Q# operation.

### Step 1. Flag the correct state by applying the oracle

Recall from the [module on Grover's algorithm](/training/modules/solve-graph-coloring-problems-grovers-search/5-grovers-algorithm?azure-portal=true) that the primary function of the oracle is to flip the sign of, or *flag*, the "good" states. The good states provide a solution to the search problem.

You can do this by using the *phase kickback* trick. This trick makes use of the fact that when a controlled `X` operation is applied to the $|-\rangle$ state, the $|-\rangle$ state remains unchanged and the corresponding states of the control register receive a factor of -1.

Suppose we have the search register `digitReg` and a `flagQubit` initialized to $|-\rangle$. How would we go about getting that phase factor on strictly the state $|x\rangle$ in `digitReg` that satisfies $(9 + 6 \cdot x) \bmod 11 = 0$?

Well, we can add a secondary target register initialized to $|9\rangle$, leaving the full state of the form:
$$
|x\rangle|9\rangle\_{\text{target}}|-\rangle
$$
Then we can apply the mapping to yield:
$$
|x\rangle|(9 + 6 \cdot x) \bmod 11\rangle_{\text{target}}|-\rangle
$$

Finally, we can apply a controlled `X` operation on the $|-\rangle$ flag qubit, controlled by the target register that's in the $|0\rangle$ number state. (For four qubits, this is represented as $|0000\rangle$.) So the state of `digitReg` that satisfies the equation acquires the phase factor as:
$$
-1*|x\_{good}\rangle |0\rangle\_{\text{target}} |-\rangle
$$
The non-solution states don't:
$$
|x\_{bad}\rangle |\neq 0\rangle\_{\text{target}} |-\rangle
$$

After this, we can uncompute the target register and the flag qubit (handled by Q# `apply`/`within` statements) and deallocated them. They've both served their purpose.

The following code defines the operation `IsbnOracle`, which implements the full oracle on `digitReg`. To perform the arithmetic mapping to the target register, it uses the operation `ComputeIsbnCheck`. We can further define that operation:

:::code language="qsharp" source="../code/4-program-1.qs":::

Note that upon allocation, `targetReg` will be in the state $|0\rangle$. Therefore, `ComputeIsbnCheck` will need to first initialize.

### Step 2. Apply the arithmetic mapping to the target state

We just described how you implement the oracle by using the `ComputeIsbnCheck` operation, which performs the mapping:
$$
|x\rangle|0\rangle\_{\text{target}} \mapsto |x\rangle|(9 + 6 \cdot x) \bmod 11\rangle\_{\text{target}}
$$
So, of what exactly does that operation consist?

As mentioned earlier, we can straightforwardly bring the target register from $|0\rangle$ to the number state $|9\rangle$ by using `ApplyXorInPlace`. Then, the only step left is to perform the mapping by using `MultiplyAndAddByModularInteger`.
Here's the code to do this:

:::code language="qsharp" source="../code/4-program-2.qs":::

## Step 3. Generalize to arbitrary ISBNs

We simplified the discussion in this unit by considering only the specific ISBN check of 
$$
0 = (9 + 6\cdot x) \bmod 11
$$
that resulted from the incomplete ISBN of 0-306-$x$0615-2.

But what about any future space explorers who also forget to properly secure their coffee cups around their notes from the librarian? Surely they would appreciate a program that would let them find any one missing digit from an arbitrary ISBN.

With them in mind, we can write a function `GetIsbnCheckConstants` to return the constants $a$ and $b$ of the corresponding check equation:
$$
0 = (b + a\cdot x) \bmod 11
$$
Assuming we'll represent the incomplete ISBN as a 10-integer array with the missing digit indicated by `-1`, we define this function as:

:::code language="qsharp" source="../code/4-program-3.qs":::

As expected, this constant returns a tuple `(6, 9)` if it's given our example as `[0, 3, 0, 6, -1, 0, 6, 1, 5, 2]`.

Now, we redefine `ComputeIsbnCheck` and `IsbnOracle` to take these constants as inputs:

:::code language="qsharp" source="../code/4-program-4.qs":::

## What's next?

In the next unit, you'll run Grover's algorithm to find the missing digit.

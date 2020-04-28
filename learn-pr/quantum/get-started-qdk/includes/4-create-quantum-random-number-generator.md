This unit provides a hands-on example of writing a quantum program in Q#. The quantum random number generator uses a Hadamard gate to put a qubit into superposition. The measurement results are random 0s or 1s. We've introduced H gate and superposition in the previous module. To read more about them, visit the QDK documentation page [here](https://docs.microsoft.com/en-us/quantum/concepts/glossary).  

## Create the Q# application

One of the cornerstones of the Quantum Development Kit is the quantum
programming language Q#. In this unit you are going to learn how to create a
quantum application in Q# with Visual Studio Code. This application consists of
a quantum random bit generator and it will be the base for our quantum random
number generator.

### 1. Create a folder

First things first, anytime you create a quantum project it's recommendable to
create a folder to store the files. In our case we will creat a new folder, anywhere on your computer, called
`MyQRNG`.

### 2. Open the folder with Visual Studio Code

To do so, in Windows you can do right click on the folder and select "Open with
Code". (try not to call out Windows specific shortcuts) Alternatively you can use the following command in the terminal:

 ```bash
 code MyQRNG
 ```

### 3. Create a Q# file

The Q# programming language uses its own file format `*.qs`. This file is
where the Q# code is written to express the instructions for the quantum
computer. Let's create a `*.qs` file to write the instructions. In our case we
will call it: `my-random-bit.qs`

You can do right click in the VS Code file explorer and select "New
File" or click on the interactive "New File" icon. Alternatively, you can invoke
the VS Code command palette by pressing `Ctrl`+`Shift`+`P`, type "new file" and
press `Enter`. 

### 4. Set a namespace

Now let's write in our `my-random-bit.qs` file the quantum program to generate a
random bit. First, we need to create a `namespace`. In the namespaces we can add
quantum operations that will be invoked from external programs. In our case we
will call this namespace `Qrng`. 

```qsharp
namespace Qrng {

}
```

### 5. Open the libraries

Q# is a modular programming language that makes extensive
use of libraries. For example, there's a Quantum Chemistry library to do quantum
chemistry calculations or a Quantum Numerics library to exploit quantum
computing to perform numerical calculations. There are several standard
libraries that include all sorts of basic operations. 

In the case of a quantum random number generator, we only need the Intrinsic library that includes the most basic quantum operations. We can open the library using the `open` directive:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
}
```

### 6. Write a Q# operation and save

To declare a Q# operation we need to specify a name for the operation and the input and output format. We will call
the operation `GenerateRandomBit`. It has no input and it outputs a `Result`. A
`Result` in Q# is a type that represents the result of a measurement and can
have two possible values: `One` and `Zero`. 

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    operation GenerateRandomBit() : Result {
    }
}
```

Now that we have declared the operation we can write its content:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Intrinsic
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  { // Allocate a qubit.
            H(q);             // Put the qubit to superposition using a Hadamard gate. It now has a 50% chance of being 0 or 1.
            let r = M(q);     // Measure the qubit value.
            Reset(q);         // Reset the qubit to the zero state.
            return r;
        }
    }
}
```

Save the file with `Ctrl` + `S`. Alternatively,
right click on the `my-random-bit.qs` file in the explorer and click on 
"Save" in the contextual menu.

Don't worry if you don't fully understand the content of the operation, we will
explain it in more detail in the next unit.(Need to split the following into the next unit.) But let's comment here what each
command is doing:

1. In Q#, to obtain a qubit we need to "ask" the computer for
   them with the block `using` in which we specify how many qubits we need and
   its name. In our case we just need one qubit. Every qubit we borrow with the
   command `using` starts by default in the `0` state.
2. We can put our qubit in a quantum superposition by applying the `H` operation
   from the Intrinsic library. We only need to specify the target
   qubit inside the brackets.
3. After throwing our qubit in a quantum superposition we can measure the state
   using the `M` operation from the Intrinsic library and store the `Result` in
   the variable `r`.
4. In Q#, at the end of every operation, we need to make sure that any used qubit
   is initialized back to the state `0`. We
   use the `Reset(q)` operation from the Intrinsic library.
5. We return the result of our measurement, which is a random bit.

That's it! We have now a quantum program that takes a qubit, throws it into a
superposition, measures it and returns a random bit whose value depends on the
measurement result.

## Understand the Q# operation with the Bloch sphere (put this little section in the previous .md as a theoretical explanation of H and superposition)

In the Bloch sphere, the north pole represents the classical value **0** and the
south pole represents the classical value **1**. Any superposition can be
represented by a point on the sphere (represented by an arrow). The closer the
end of the arrow to a pole the higher the probability the qubit collapses into
the classical value assigned to that pole when measured. For example, the qubit
state represented by the red arrow below has a higher probability of giving the
value **0** if we measure it.

![A qubit state with a high probability of measuring zero](../media/qrng-Bloch.png)
<!--img src="../media/qrng-Bloch.png" width="175" alt="A qubit state with a high
probability of measuring zero"-->

We can use this representation to visualize what the code is doing:

* First we start with a qubit initialized in the state **0** and apply `H` to
  create a superposition in which the probabilities for **0** and **1** are the
  same.

![Preparing a qubit in superposition](../media/qrng-H.png)
<!--img src="../media/qrng-H.png" width="450" alt="Preparing a qubit in
superposition"-->


* Then we measure the qubit and save the output:

![Measuring a qubit and saving the output](../media/qrng-meas.png)
<!--img src="../media/qrng-meas.png" width="450" alt="Measuring a qubit and saving
the output"-->

Since the outcome of the measurement is completely random, we have obtained a
random bit. We can call this operation several times to create integers. For
example, if we call the operation three times to obtain three random bits, we
can build random 3-bit numbers (that is, a random number between 0 and 7).

## Creating the host program (create a separate .md called 5-executing-Q#-program, change the summary to number 6)

Ok, you have created a Q# quantum program, how do we execute it? The Q# program
allows us to communicate bidirectionally (what does this mean in this case?) with the quantum computer. However, we
don't want to use the quantum computer for everything, since for most things
classical computers work just fine. We want to call the quantum computer only
when we need it, for example to make some specific type of calculations, or
in this case, to extract pure randomness. This is why Q# works together with
a host program, typically C# or Python (how will it do it in a standalone executable? Need to update this here then.). This allows us to call the quantum 
operations from inside a classical program. (Still doesn't clarify why we need a classical program. Is it a driver for VS Code?) In this tutorial we are going to 
build a quantum radom number generator with Python.

First let's outline the algorithm to create a random integer from 0 to a maxium 
value:

1. Select maximum number `max`.
2. Calculate number of bits `N` needed to represent `max` in binary.
3. Generate a string of random bits of length `N`.
4. Check if the number represented by the string is lower than `max`. If yes,
go to 5. If not, go back to 3 and try again.
5. Return the random number.

Our host program is going to make use of the quantum application we just created
to create the string of random bits in step 3. We are going to invoke `N`
times our quantum operation to extract a random bit with the quantum computer.
Let's see how to do it in Python.

### 1. Create a Python file

Like we did with the Q# operation, we need to create a file for the Python
program in our folder. To do so we create a python file with VS Code (extension
`*.py`). In our case, we call it `host.py`.

### 2. Import Q# and the operations

When writing a Python host program we first need to import the `qsharp` module
and all the Q# operations we are going to use. We treat the Q#
namespaces as if they where Python modules. Let's import the Q# operation we just
created.

```python
import qsharp
from Qrng import GenerateRandomBit
```

### 3. Print the random bit

We write the code as if it were a normal Python code. When we want to call
any Q# operation, we treat them as normal Python functions by adding the
extension `*.simulate()` at the end. For example the following code invokes our
operation, activates a simulator of a quantum computer, runs our Q# code, and
prints the random bit.

```
import qsharp
from Qrng import GenerateRandomBit
print(GenerateRandomBit.simulate())
```

Now that we know how to use Q# operations with Python, we just need to write the
algorithm as we would do normally.

```python
import qsharp
from Qrng import SampleQuantumRandomNumberGenerator 
max = 50
output = max + 1
while output > max:
    bit_string = []
    for i in range(0, max.bit_length()):
        bit_string.append(SampleQuantumRandomNumberGenerator.simulate()) 
    output = int("".join(str(x) for x in bit_string), 2) 
print("The random number generated is " + str(output))
```
And save the file.

## 4. Execute the code

To execute the program you just need to execute it as if it were a normal
Python script. You can go to the command line and type:

```bash
$ python host.py
```

You should obtain something like this:

```bash
Preparing Q# environment...
..The random number generated is 42
```

Congratulations! Now you know how to combine Q# with a host program and ran a Q# program.

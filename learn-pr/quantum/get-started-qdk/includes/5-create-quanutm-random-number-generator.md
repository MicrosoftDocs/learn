In this unit you are going to learn how to build a complete quantum random number
generator using the quantum random bit generator you created in the last unit.

## Use Q# to write classical logic

In general, we don't want to use the quantum computer for everything, since for
many things classical computers work just fine. We want to call the quantum
computer only when we need to, for example to make some specific typo of
calculations, or in this case, to extract pure randomness. This is why Q# also
can implement classical code just like a normal programming language.

Let's see how can we use Q# features to build a random number generator.

## Logic of a random number generator

First let's outline what the logic of an random number generator should
be, provided we have a random bit generator:

        - We set a maximum number that can be generated: `max`
        - We calculate how many bits ('nBits') we need to express integers up to 
        `max`. This will be the number of random bits that we 
        need to generate.
        - We generate the random bit-string of `nBits` we need to represent up 
        to `max`.
        - Since there can be numbers of size `nBits` grater than `max` we need 
        to check if that's the case. If the generated number is greater than 
        `max` we try again.
        - Once we obtain a bit-string of `nBits` smaller than `max` we 
        transform it to a decimal base and print out the generated random number.

## Create the Q# operation

We don't need to create a new project. Since we are going to use the same
operation we defined in the last unit we can just modify the `my-random-bit.qs`
file to include the new code. If you want you can rename the file to
`my-random-number.qs`.

### Add the libraries

For the complete random number generator we will need two additional libraries:
´Microsoft.Quantum.Math´ and ´Microsoft.Quantum.Convert´. You can include them
at the beginning of the namespace like you did in the last unit.

### Add a new operation

We want to use the operation `GenerateRandomBit` that you created in the last
unit, so instead of overwriting it, we are going to add a new operation named
`GenerateRandomNumber`. We also move the `@EntryPoint()` to just above our new
operation, since this will be the operation we want the compiler to execute.
You should have something like this:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            H(q);               // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            return MResetZ(q);  // Measure the qubit value.
        }
    }
    
    @EntryPoint()
    operation GenerateRandomNumber() : Int {
    }
}
```

### Write the new operation

Now we are going to use the Q# tools to create a quantum random number generator
using the same logic we described above:

```qsharp
namespace Qrng {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            H(q);               // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            return MResetZ(q);  // Measure the qubit value.
        }
    }
    
    @EntryPoint()
    operation GenerateRandomNumber() : Int {
        let max = 50;
        Message($"Sampling a random number between 0 and {max}: "); // Print informative message.
        let nBits = Floor(Log(IntAsDouble(max)) / LogOf2() + 1.); // Calculate `nBits`.
    
        mutable bits = new Result[0]; // Initiate a mutable variable to store the bit-string.
        mutable output = 0; // Initiate a mutable variable to store the output.
        repeat {
            set bits = new Result[0]; // Restart the bit-string to 0.
            for (bit in 1 .. nBits) { // Loop to generate `nBits` random bits.
                set bits += [GenerateRandomBit()]; // We call our operation to extract a random bit and add it to the bit-string.
            }
            set output = ResultArrayAsInt(bits); // Transform the bit-string into a integer
        }
        until (output <= max) // Condition to stop the loop.
        fixup {
            Message($"{output} > {max}, trying again."); // Print this text when the condition is not met.
        }

        return output;
    }
}
```
Don't worry if you don't understand all the parts of the code above. We have
introduced many new things! Let's take a look at the most important ones:

- In the  `GenerateRandomNumber` operation we have implemented a type of loop
  specific from Q# that is called *Repeat Until Success (RUS)*. This kind of
  loop is specially designed to work well with quantum computers and avoid
  incompatibilities with some properties that quantum operations need to
  fulfill. It has three parts pointed by the three keywords: `repeat`, `until`
  and `fixup`.
    - The argument of `until{}` is a boolean expression (`True` or `False`) that is the condition
    that needs to be fulfilled in order to succeed and stop the loop.
    - The argument of `repeat{}` is the set of actions that need to be taken until the condition
    of `until` is fulfilled.
    - The argument of `fixup{}` is a set of actions that are taken each time the
      condition of `until` is not fulfilled and the loop starts a new iteration.

    In this case we us a RUS loop to run generate random strings of size `nBits`
    until we obtain one smaller than `max`.
- The loop `for` inside `repeat{}` works exactly as you would expect a loop for
works.
- The `let` directive is used to declare variables that won't change during the
  computation. The `mutable` directive is used to declare variables that can
  change during the computation. The `mutable` variables can be modified with 
  the directive `set`.
- `let nBits = Floor(Log(IntAsDouble(max)) / LogOf2() + 1.);` uses the
  `Microsoft.Quantum.Math` library to calculate `nBits`.
- `set output = ResultArrayAsInt(bits)` uses the function `ResultArrayAsInt`
  from the `Microsoft.Quantum.Convert` library to transform the bit-string of 
  `Result` into an integer (`Int`).

## Execute the Q# program

Exactly like we did in the previous unit we can run now our quantum random
number generator. 

In VS Code terminal, build the `my-random-number.qs` the first time by typing the
below in the terminal: 
```
dotnet build
```
For subsequent runs, no need to build it again:
```
dotnet run --no-build
```
Pressing enter you should obtain something like this:
```
Sampling a random number between 0 and 50:
60 > 50, trying again.
42
```
In this case the random number generated was 42. You can see how the program
tried to generate the random number twice. The first time it got 60, which was
greater than the `max` set to 50, so it tried again.

Congratulations! Now you know how to use classical logic with Q# to create a
quantum random number generator.

**Extra exercise:** How would you modify the code above to also include
in the generation range a minimum number `min` instead of 0?

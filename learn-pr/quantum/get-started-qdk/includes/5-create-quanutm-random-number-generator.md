In this part, you implement the second phase of your quantum random number generator (RNG): combining multiple random bits to form a larger number. This phase builds on the random bit generator that you already created.

## Can I combine quantum code with classical code?

Yes, you can. Quantum computers perform specialized tasks. You don't  use a quantum computer for everything because, for many tasks, classical computers work just fine.

Just like a graphics processing unit (GPU) or other specialized hardware, you want to use a quantum computer for tasks they're best suited for; in this case, you want to produce purely random bits.

This is why Q# also enables you to write classical code, just programming languages you use every day.

Let's see how can we use Q# features to build a random number generator.

## Define the random number generator logic

Before we proceed, let's first outline what the logic of a random number generator should be, provided we have a random bit generator:

1. Define `max` as the maximum number we want to generate.
1. Define the number of random bits that we need to generate.
    This is done by calculating how many bits, `nBits`, we need to express integers up to `max`.
1. Generate a random bit string of `nBits`.
1. If the bit string represents a number greater than `max`, go back to step three.
1. Otherwise, the process is complete. Return the generated number as an integer to the calling process.

As an example, let's set `max` to 12.

You need ${floor(ln(12) / ln(2) + 1)}$, or four bits to represent a number between zero and 12.

Let's say you generate the bit string ${1101_{\ binary}}$, which is equivalent to 13 in decimal. Because 13 is greater than 12, you repeat the process.

Next, you generate the bit string ${0110_{\ binary}}$, which is equivalent to six in decimal. Because six is less than 12, the process is complete.

With our logic in place, you're now ready to build the complete random number generator.

## Create the Q# operation

Here, you build on `GenerateRandomBit` operation from your *quantum-rng* project to build complete random numbers.

### Add the required libraries

For the complete random number generator, you need to include two additional libraries: `Microsoft.Quantum.Math` and `Microsoft.Quantum.Convert`. Add the following `open` directives to *Program.qs*, like this:

TODO:

### Define the GenerateRandomNumber operation

Here, you define the `GenerateRandomNumber` operation. Because this becomes the new entry point to your program, you also move the `EntryPoint` attribute to the new operation.

Modify *Program.qs* like this:

TODO:

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

### Implement the GenerateRandomNumber operation

Here, you use the logic we defined earlier to implement the `GenerateRandomNumber` operation.

Modify *Program.qs* like this:

TODO:

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

Take a moment to review the new code.

The `GenerateRandomNumber` operation uses a type of loop that's specific to Q# called *Repeat-Until-Success* (RUS). This kind of loop works well with quantum computers and avoids incompatibilities with some properties that quantum operations need to fulfill. A RUS loop has three parts: `repeat`, `until`, and `fixup`.

- `until` takes a Boolean expression (one that evaluates to `True` or `False`) as its argument. This is the condition that needs to be fulfilled in order to succeed and stop the loop.
- `repeat` contains the set of actions that need to be taken until the condition of `until` is fulfilled.
- `fixup` contains the set of actions that are taken each time the condition of `until` is not fulfilled and the loop starts a new iteration.

Here, we use a RUS loop to generate random bit strings of size `nBits` until we obtain a number that's less than `max`.

The `for` loop inside `repeat` works exactly the same as a `for` loop in other programming languages.

The `let` directive declares variables that don't change during the computation. The `mutable` directive declares variables that can change during the computation. You use the `set` directive to change the value of a `mutable` variable.

The `Floor`, `Log`, and `LogOf2` functions come from the `Microsoft.Quantum.Math` library.

The `IntAsDouble` and `ResultArrayAsInt` functions come from the `Microsoft.Quantum.Convert` library.

The `ResultArrayAsInt` function transforms the resulting bit string to an integer (`Int`) value.

## Run the program

Let's try out our new random number generator!

1. In Visual Studio Code, run `dotnet build` from the integrated terminal:

```bash
dotnet run
```

Here's sample output:

```bash
Sampling a random number between 0 and 50:
60 > 50, trying again.
42
```

For simplicity, `max` is set to 50 in the program. In this example, the RUS loop runs two times. The first iteration produces a value that's greater than 50. The second iteration produces 42, which fits our range.

As before, you can run the program again like this:

```bash
dotnet run --no-build
```

(If you make changes to the code, you need to omit the `--no-build` argument to rebuild your program.)

Congratulations! Now you know how to combine classical logic with Q# to create a quantum random number generator.

## Bonus exercise

Modify the program to also require the generated random number to be greater than some minimum number, `min`, instead of zero.
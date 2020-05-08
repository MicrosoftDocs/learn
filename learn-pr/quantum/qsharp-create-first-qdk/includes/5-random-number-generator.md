In this part, you implement the second phase of your quantum random number generator: combining multiple random bits to form a larger number. This phase builds on the random bit generator that you already created. You will need to write some classical code to do this. 

First, let's see how classical code fits in with Q#.

## Can I write classical code in Q#?

Yes, you can. Quantum computers perform specialized tasks. You don't use a quantum computer for everything because, for many tasks, classical computers work just fine.

Just like a graphics processing unit (GPU) or other specialized hardware, you want to use a quantum computer for tasks they're best suited for; in this case, you want to produce purely random bits.

This is why Q# also enables you to write classical code that resembles programming languages you already know.

Let's see how we can use Q# features to build a complete random number generator.

## Define the random number generator logic

Before we proceed, let's outline what the logic of a random number generator should be, provided we have a random bit generator:

1. Define `max` as the maximum number we want to generate.
1. Define the number of random bits that we need to generate.
    This is done by calculating how many bits, `nBits`, we need to express integers up to `max`.
1. Generate a random bit string that's `nBits` in length.
1. If the bit string represents a number greater than `max`, go back to step three.
1. Otherwise, the process is complete. Return the generated number as an integer.

As an example, let's set `max` to 12.

You need ${\lfloor ln(12) / ln(2) + 1 \rfloor}$, or four bits to represent a number between zero and 12. (For brevity, we'll skip how to derive this equation.)

Let's say you generate the bit string ${1101_{\ binary}}$, which is equivalent to ${13_{\ decimal}}$. Because 13 is greater than 12, you repeat the process.

Next, you generate the bit string ${0110_{\ binary}}$, which is equivalent to ${6_{\ decimal}}$. Because six is less than 12, the process is complete.

With our logic in place, you're now ready to build the complete random number generator.

## Create the GenerateRandomNumber operation

Here, you build on the *QuantumRNG* project to build larger random numbers.

### Add the required libraries

For the complete random number generator, you need to include two additional libraries: `Microsoft.Quantum.Math` and `Microsoft.Quantum.Convert`. Add the following `open` directives to *Program.qs*, like this:

[!code-qsharp[](code/5-Program-1.qs?highlight=6-7)]

### Define the GenerateRandomNumber operation

Here, you define the `GenerateRandomNumber` operation. Because this becomes the new entry point to your program, you also move the `EntryPoint` attribute to the new operation.

Modify *Program.qs* like this:

[!code-qsharp[](code/5-Program-2.qs?highlight=9-21)]

### Implement the GenerateRandomNumber operation

Here, you use the logic we defined earlier to implement the `GenerateRandomNumber` operation.

Modify *Program.qs* like this:

[!code-qsharp[](code/5-Program-3.qs?highlight=21-47)]

Let's take a moment to review the new code.

The `GenerateRandomNumber` operation uses a type of loop that's specific to Q# called *Repeat-Until-Success* (RUS). This kind of loop works well with quantum computers and avoids incompatibilities with some properties that quantum operations need to fulfill. A RUS loop has three parts: `repeat`, `until`, and `fixup`.

- `until` takes a Boolean expression (one that evaluates to `True` or `False`) as its argument. This is the condition that needs to be fulfilled in order to succeed and stop the loop.
- `repeat` contains the set of actions that need to be taken until the condition of `until` is fulfilled.
- `fixup` contains the set of actions that are taken each time the condition of `until` is not fulfilled and the loop starts a new iteration.

Here, we use a RUS loop to generate random bit strings of length `nBits` until we obtain a number that's less than `max`.

The `for` loop inside `repeat` works exactly the same as a `for` loop in other programming languages.

The `let` directive declares variables that don't change during the computation. The `mutable` directive declares variables that can change during the computation. You use the `set` directive to change the value of a `mutable` variable.

The [`Floor`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.math.floor), [`Log`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.math.log), and [`LogOf2`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.math.logof2) functions come from the `Microsoft.Quantum.Math` library.

The [`IntAsDouble`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.convert.intasdouble) and [`ResultArrayAsInt`](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.convert.resultarrayasint) functions come from the `Microsoft.Quantum.Convert` library.

The `ResultArrayAsInt` function transforms the resulting bit string to an integer (`Int`) value.

## Run the program

Let's try out our new random number generator!

1. In Visual Studio Code, run `dotnet run` from the integrated terminal:

    ```bash
    dotnet run
    ```

    Here's sample output:

    ```output
    Sampling a random number between 0 and 50:
    60 > 50, trying again.
    42
    ```

    For simplicity, `max` is set to 50 in the program. In this example, the RUS loop runs two times. The first iteration produces a value that's greater than 50. The second iteration produces 42, which fits our range.

1. As an optional step, run the program again like this:

    ```bash
    dotnet run --no-build
    ```

    (If you make changes to the code, you need to omit the `--no-build` argument to rebuild your program.)

    Here's sample output:

    ```output
    Sampling a random number between 0 and 50: 
    10
    ```

Congratulations! Now you know how to combine classical logic with Q# to create a quantum random number generator.

## Bonus exercise

Modify the program to also require the generated random number to be greater than some minimum number, `min`, instead of zero.

In this part, you implement the second part of your quantum random number generator: combining multiple random bits to form a larger number to use as a valid and secure password. This phase builds on the random bit generator that you already created. You will need to write some classical code for this part.

First, let's see how classical code fits in with Q#.

## Can I write classical code in Q#?

Yes, you can. Quantum computers perform specialized tasks. You don't use a quantum computer for everything because, for many tasks, classical computers work just fine.

Just like a graphics processing unit (GPU) or other specialized hardware, you want to use a quantum computer for tasks they're best suited for; in this case, you want to produce purely random bits.

This is why Q# also enables you to write classical code that resembles programming languages you already know.

Let's see how we can use Q# features to build a complete random number generator.

## Define the random number generator logic

Before we proceed, let's outline what the logic of a random number generator should be, provided we have a random bit generator:

1. Define `max` as the maximum number you want to generate.
1. Define the number of random bits that you need to generate.
    This is done by calculating how many bits, `nBits`, we need to express integers up to `max`.
1. Generate a random bit string that's `nBits` in length.
1. If the bit string represents a number greater than `max`, go back to step three.
1. Otherwise, the process is complete. Return the generated number as an integer.

As an example, let's set `max` to 12. That is, 12 is the largest number you want to use as a secure password.

You need ${\lfloor ln(12) / ln(2) + 1 \rfloor}$, or four bits to represent a number between zero and 12. (For brevity, we'll skip how to derive this equation.)

Let's say you generate the bit string ${1101_{\ binary}}$, which is equivalent to ${13_{\ decimal}}$. Because 13 is greater than 12, you repeat the process.

Next, you generate the bit string ${0110_{\ binary}}$, which is equivalent to ${6_{\ decimal}}$. Because 6 is less than 12, the process is complete.

The QRNG will return number 6 as your password. In practice, you want to set a larger number as maximum since lower numbers are easy to crack. In fact, as a way to increase the difficulty of guessing or cracking your password, you could use ASCII code to convert binary to text and to generate a password with numbers, symbols and mixed-case letters. 

Now you can be sure that your passwords are truly random. Space fleet data and their facilities are protected with the highest security standards.

With our logic in place, you're now ready to build a complete random number generator.

## Create the SampleRandomNumberInRange operation

Here, you expand on the *QuantumRNG* project to build larger random numbers.

### Add the required libraries

For the complete random number generator, you need to include two additional libraries: `Microsoft.Quantum.Math` and `Microsoft.Quantum.Convert`. Add the following `open` directives to *Program.qs*, like this:

[!code-qsharp[](code/5-program-1.qs?highlight=6-7)]

### Define the operation

Here, you define the `SampleRandomNumberInRange` operation. This operation repeatedly calls the `GenerateRandomBit` operation to build a string of bits.

Modify *Program.qs* like this:

[!code-qsharp[](code/5-program-2.qs?highlight=20-30)]

Let's take a moment to review the new code.

Recall that we need to calculate the number of bits we need to express integers up to `max`. The `Microsoft.Quantum.Math` library provides the [BitSizeI](/qsharp/api/qsharp/microsoft.quantum.math.bitsizei?azure-portal=true) function to accomplish this.

The `SampleRandomNumberInRange` operation uses a `repeat` loop to generate random numbers until it generates one that's equal to or less than `max`.

The `for` loop inside `repeat` works exactly the same as a `for` loop in other programming languages.

In this example, `output` and `bits` are mutable variables. A mutable variable is one that can change during the computation. You use the `set` directive to change a mutable variable's value.

The [ResultArrayAsInt](/qsharp/api/qsharp/microsoft.quantum.convert.resultarrayasint?azure-portal=true) function comes from the `Microsoft.Quantum.Convert` library. This function converts the bit string to a positive integer.

## Define the entry point

Your program can now generate random numbers. Here, you define the entry point for your program.

Modify *Program.qs* like this:

[!code-qsharp[](code/5-program-3.qs?highlight=32-37)]

The `let` directive declares variables that don't change during the computation. For learning purposes, here we define the maximum value as 50.

## Run the program

Let's try out our new random number generator!

1. In Visual Studio Code, run `dotnet run` from the integrated terminal:

    ```bash
    dotnet run
    ```

    Here's sample output:

    ```output
    Sampling a random number between 0 and 50:
    42
    ```

    The computation might produce numbers that are greater than 50. But the `repeat` loop retries the operation until it produces a number that's 50 or less.

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

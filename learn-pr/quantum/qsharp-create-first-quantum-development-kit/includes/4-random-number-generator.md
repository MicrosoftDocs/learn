In this unit, you implement the second phase of your quantum random number generator: combining multiple random bits to form a larger random number. This phase builds on the random bit generator you already created in the previous unit.

## Combine multiple random bits to form a larger number

In the previous unit, you created a random bit generator that generates a random bit by putting a qubit into superposition and measuring it.

When you measure the qubit, you get a random bit, either 0 or 1, with equal 50% probability. The value of this bit is truly random, there's no way of knowing what you get after the measurement. But how can you use this behavior to generate larger random numbers?

Let's say you repeat the process four times, generating this sequence of binary digits:

$${0, 1, 1, 0}$$

If you concatenate, or combine, these bits into a bit string, you can form a larger number. In this example, the bit sequence ${0110}$ is equivalent to six in decimal.

$${0110_{\ binary} \equiv 6_{\ decimal}}$$

If you repeat this process many times, you can combine multiple bits to form any large number.

## Define the random number generator logic

Let's outline what the logic of a random number generator should be, provided the random bit generator built in the previous unit:

1. Define `max` as the maximum number you want to generate.
1. Define the number of random bits you need to generate by calculating how many bits, `nBits`, you need to express integers up to `max`.
1. Generate a random bit string that's `nBits` in length.
1. If the bit string represents a number greater than `max`, go back to step three.
1. Otherwise, the process is complete. Return the generated number as an integer.

As an example, let's set `max` to 12. That is, 12 is the largest number you want to get from the random number generator. 

You need ${\lfloor ln(12) / ln(2) + 1 \rfloor}$, or 4 bits to represent a number between 0 and 12. (For brevity, we skip how to derive this equation.)

Let's say you generate the bit string ${1101_{\ binary}}$, which is equivalent to ${13_{\ decimal}}$. Because 13 is greater than 12, you repeat the process.

Next, you generate the bit string ${0110_{\ binary}}$, which is equivalent to ${6_{\ decimal}}$. Because 6 is less than 12, the process is complete.

The quantum random number generator returns the number 6.

## Create a complete random number generator

Here, you expand on the `Main.qs` file to build larger random numbers. 

### Import the required libraries

First, you need to import the required namespaces from the Q# Standard library to the program. The Q# compiler loads many common functions and operations automatically, however for the complete quantum random number generator, you need some more functions and operations from two Q# namespaces: `Microsoft.Quantum.Math`and `Microsoft.Quantum.Convert`.

Copy and paste the following `import` directives to the top of your `Main.qs` file:

```qsharp
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Math.*;
```

### Rename the `Main` operation to `GenerateRandomBit`

For the complete random number generator, you're going to reuse the operation defined in the previous unit. However, the operation name `Main` is the entry point of the program and should be unique. To avoid confusion, you need to rename the `Main` operation to `GenerateRandomBit`.

The `GenerateRandomBit` operation should look like this:

```qsharp
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
    
        // Set the qubit into superposition of 0 and 1 using the Hadamard 
        H(q);
    
        // Measure the qubit and store the result.    
        let result = M(q);
    
        // Reset qubit to the |0〉 state.
        Reset(q);
    
        // Return the result of the measurement.
        return result;
    }
```

### Define the quantum random number operation

Here, you define the `GenerateRandomNumberInRange` operation. This operation repeatedly calls the `GenerateRandomBit` operation to build a string of bits.

Copy the following code and paste it before the `GenerateRandomBit` operation into your `Main.qs` file:

```qsharp
    /// Generates a random number between 0 and `max`.
    operation GenerateRandomNumberInRange(max : Int) : Int {
        // Determine the number of bits needed to represent `max` and store it
        // in the `nBits` variable. Then generate `nBits` random bits which will
        // represent the generated random number.
        mutable bits = [];
        let nBits = BitSizeI(max);
        for idxBit in 1..nBits {
            set bits += [GenerateRandomBit()];
        }
        let sample = ResultArrayAsInt(bits);
    
        // Return random number if it is within the requested range.
        // Generate it again if it is outside the range.
        return sample > max ? GenerateRandomNumberInRange(max) | sample;
    }
```

Let's take a moment to review the new code.

* You need to calculate the number of bits needed to express integers up to `max`. The `BitSizeI` function from the `Microsoft.Quantum.Math` library converts an integer to the number of bits needed to represent it.
* The `GenerateRandomNumberInRange` operation uses a `for` loop to generate random numbers until it generates one that's equal to or less than `max`. The `for` loop works exactly the same as a `for` loop in other programming languages.
* The variable `bits` is a mutable variable. A mutable variable is one that can change during the computation. You use the `set` directive to change a mutable variable's value.
* The `ResultArrayAsInt` function comes from the `Microsoft.Quantum.Convert` library. This function converts the bit string to a positive integer.

### Add an entry point

Finally, you add an entry point to the program. By default, the Q# compiler looks for a `Main` operation and starts processing there, no matter where the operation is located. The `Main` operation calls the `GenerateRandomNumberInRange` operation to generate a random number between 0 and a `max` number. In this example, you define the maximum value as 100.

Copy and paste the following code to your `Main.qs` file:

```qsharp
operation Main() : Int {
    let max = 100;
    Message($"Sampling a random number between 0 and {max}: ");
    // Generate random number in the 0..max range.
    return GenerateRandomNumberInRange(max);
}
```

### Final program

Your `Main.qs` file should look like this:

```qsharp
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Math.*;

    operation Main() : Int {
        let max = 100;
        Message($"Sampling a random number between 0 and {max}: ");
    
        // Generate random number in the 0..max range.
        return GenerateRandomNumberInRange(max);
    }
    
    /// Generates a random number between 0 and `max`.
    operation GenerateRandomNumberInRange(max : Int) : Int {
        // Determine the number of bits needed to represent `max` and store it
        // in the `nBits` variable. Then generate `nBits` random bits which will
        // represent the generated random number.
        mutable bits = [];
        let nBits = BitSizeI(max);
        for idxBit in 1..nBits {
            set bits += [GenerateRandomBit()];
        }
        let sample = ResultArrayAsInt(bits);
    
        // Return random number if it is within the requested range.
        // Generate it again if it is outside the range.
        return sample > max ? GenerateRandomNumberInRange(max) | sample;
    }
    
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
    
        // Set the qubit into superposition of 0 and 1 using the Hadamard operation
        H(q);
    
        // Measure the qubit value using the `M` operation, and store the
        // measurement value in the `result` variable.
        let result = M(q);
    
        // Reset qubit to the |0〉 state.
        Reset(q);
    
        // Return the result of the measurement.
        return result;
    }
```

## Run the program

Let's try out our new random number generator!

1. Before running the program, you need to set the target profile to **Unrestricted**. Select **View** > **Command Palette**, search for *QIR*, select **Q#: Set the Azure Quantum QIR target profile**, and then select **Q#: unrestricted**.
1. To run your program, select **Run** from the list of commands above the `Main` operation or press **Ctrl+F5**. Your output displays in the debug console.
1. Run the program again to see a different result.

> [!NOTE]
> If the target profile isn't set to **Unrestricted**, you get an error when you run the program.

Congratulations! Now you know how to combine classical logic with Q# to create a quantum random number generator.

## Bonus exercise

Try to modify the program to also require the generated random number to be greater than some minimum number, `min`, instead of zero.

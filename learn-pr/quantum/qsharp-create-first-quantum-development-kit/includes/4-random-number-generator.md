In this unit, you implement the second part of your quantum random number generator. You combine multiple random bits to form a larger random number. This part builds on the random bit generator that you already created in the previous unit.

## Combine multiple random bits to form a larger number

In the previous unit, you created a random bit generator that puts a qubit into a superposition state and then measures that qubit to generate random bit value of either 0 or 1, each with 50% probability. The value of this bit is truly random, there's no way to know ahead of time what the measurement result will be. But how can you use this behavior to generate larger random numbers?

If you repeat the process four times, then you might generate this sequence of binary digits:

$${0, 1, 1, 0}$$

If you combine these bits into a bit string, then you can form a larger number. In this example, the bit sequence ${0110}$ in binary is equivalent to the number 6 in decimal.

$${0110_{\ binary} \equiv 6_{\ decimal}}$$

To generate an arbitrarily large random number, just repeat this process many times. Then, combine all of the bits into a binary number and convert that binary number to a decimal number.

## Define the random number generator logic

Before you write your Q# code, let's outline the logic to generate a random number:

1. Define `max` as the maximum decimal number that you want to generate.
1. Determine the number of random bits, `nBits`, that are required to generate `max`.
1. Generate a random bit string that's `nBits` in length.
1. If the bit string represents a number greater than `max`, then go back to the previous step.
1. Otherwise, the process is complete. Return the generated number as a decimal integer.

For example, let's define `max` to be 12. That is, 12 is the largest number that your random number generator should output.

Use the following equation to determine the number of bits required to represent the number 12 in binary:

$${\lfloor ln(12) / ln(2) + 1 \rfloor}$$

According to this equation, you need 4 bits to represent a number between 0 and 12.

For example, suppose you generate a random bit four times and get the bit string ${1101_{\ binary}}$. This value in binary is equal to 13 in decimal. Because 13 is greater than 12, you repeat the process.

Next, you generate the bit string ${0110_{\ binary}}$, which equals ${6_{\ decimal}}$. Because 6 is less than 12, the process is complete.

The quantum random number generator returns the number 6.

## Create a complete random number generator in Q#

Here, you expand on the `Main.qs` file from the previous lesson to build your random number generator.

### Import the required libraries

First, import the namespaces from the Q# standard library that contain the functions and operations that you need to write your program. The Q# compiler loads many common functions and operations automatically. But for the quantum random number generator, you need some additional functions and operations from two Q# namespaces: `Std.Math` and `Std.Convert`.

Copy and paste the following `import` directives at the beginning of your `Main.qs` file:

```qsharp
import Std.Convert.*;
import Std.Math.*;
```

### Rename the `Main` operation to `GenerateRandomBit`

The random number generator program uses the `Main` operation that you wrote in the previous unit to generate a random bit. Rename the `Main` operation to `GenerateRandomBit` so that this operation has a more descriptive name and isn't the entry point to the program.

Copy and paste the following code into `Main.qs`:

```qsharp
import Std.Convert.*;
import Std.Math.*;

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

### Define the random number generator operation

Create a new operation called `GenerateRandomNumberInRange`. This operation repeatedly calls the `GenerateRandomBit` operation to build a string of bits.

Copy the following code and place it directly before the `GenerateRandomBit` operation in your `Main.qs` file:

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
    
    // Return random number if it's within the requested range.
    // Generate it again if it's outside the range.
    return sample > max ? GenerateRandomNumberInRange(max) | sample;
}
```

Here's an overview of the code in `GenerateRandomNumberInRange`:

- Call the `BitSizeI` function from the `Std.Math` library to calculate the number of bits needed to represent the integer that's stored in `max`.
- Use a `for` loop to generate a number of random bits equal to `nBits`. Call your `GenerateRandomBit` operation to generate the random bits.
- Inside the `for` loop, use the `set` statement to update the `bits` variable with each new random bit. The variable `bits` is a mutable variable, which means that the value of `bits` can change during the computation.
- Call the `ResultArrayAsInt` function from the `Std.Convert` library to convert the array of bits in `bits` to a positive integer stored in `sample`.
- In the `return` statement, check whether `sample` is greater than `max`. If `sample` is greater than `max`, then call `GenerateRandomNumberInRange` again and start over. Otherwise, return the random number stored in `sample`.

### Add an entry point

Finally, add an entry point operation to your code so that the compiler can run your program. By default, the Q# compiler looks for a `Main` operation and uses `Main` as the entry point, no matter where `Main` is located in your file. Here, the `Main` operation sets a value for `max` and calls the `GenerateRandomNumberInRange` operation to generate a random number between 0 and `max`.

For example, to generate a random number between 0 and 100, copy the following code to your `Main.qs` file:

```qsharp
operation Main() : Int {
    let max = 100;
    Message($"Generating a random number between 0 and {max}: ");

    // Generate random number in the 0..max range.
    return GenerateRandomNumberInRange(max);
}
```

### Final program

Here's the complete Q# code for your program in `Main.qs`:

```qsharp
import Std.Convert.*;
import Std.Math.*;

operation Main() : Int {
    let max = 100;
    Message($"Generating a random number between 0 and {max}: ");
    
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
    
    // Return random number if it's within the requested range.
    // Generate it again if it's outside the range.
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

Try out your new quantum random number generator!

To run your program, choose the **Run** code lens from the list of commands above the `Main` operation. Or, press **Ctrl + F5**. Your output displays in the debug console. Run the program multiple times and notice how the result changes.

Congratulations! You created a truly random quantum number generator in Q#.

## Bonus exercise

Try to modify the program so that it also requires the generated random number to be greater than some minimum positive number, `min`, instead of zero.

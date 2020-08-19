In this unit we will introduce to you the Numerics library and the arithmetic 
capabilities of the Quantum Development Kit. The library is an API, written in 
Q#, that gives you the ability to perform arithmetic operations with quantum 
computers and qubit registers.

## Introduction to the Numerics library

Q# is a language that offers high and low level capabilities. For example,
you can use Q# to select individually what gates to apply directly at the qubit
level (`H`, `CNOT`, etc), but you can also use the already built-in operations

to perform high-level operations without worrying about the specific gates. An
example of this high-level functionality would be the quantum Fourier transform
operation,
[`QFT`](https://docs.microsoft.com/qsharp/api/qsharp/microsoft.quantum.canon.qft), which is used in Shor's algorithm, for example, as you might have learned in module []().


The Numerics library provides you a set of arithmetic operations and fixed-point
arithmetic operations for integers encoded in qubit registers. You can leverage
this low-level optimized implementations of basic arithmetic operations to
implement sophisticated algorithms.

This library is especially useful for researchers and developers who 
want to translate algorithms and circuits to Q# without having to deal with the 
low-level implementation of basic arithmetic operations.

The Standard library also offers some important arithmetic functionality.
Fortunately, everything related with arithmetic operations, both from the
Standard and the Numerics library, is covered under the
`Microsoft.Quantum.Arithmetic` namespace. You can find all the documentation
under the [official API
reference](https://docs.microsoft.com/en-us/qsharp/api/qsharp/microsoft.quantum.arithmetic?view=qsharp-preview).

### Content of the Numerics library

The library provides a set of arithmetic operations signed and unsigned integers
in the LittleEndian representation, and a new type to store fixed-point
LittleEndian integers. We have three types:

-  `LittleEndian`: A qubit array that represents an integer where the index 0-th
     index denotes the least significant bit.
-  `SingedLittleEndian`: Same as `LittleEndian` but with a sign stored in [two's complement](https://en.wikipedia.org/wiki/Two%27s_complement).
-  `FixedPoint`: Represents a real number consisting of a qubit array representing
   number of binary digits to the left of the binary point.

For each of the types, several operations are available, for example: addition,
comparison, multiplication, squaring, polynomial evaluation, among others. You
can obtain more information about the available operations in the [official
documentation for the Numerics
library](https://docs.microsoft.com/en-us/quantum/user-guide/libraries/numerics/numerics).

## Use the Numerics library  

It's not rare that quantum computing algorithms require to compute arithmetic
operations such as the evaluation of oracles or the application of mathematical
functions to quantities encoded in the qubit registers. The numerics library
provides you with functionality to perform these operations.


For example, in Shor's factoring algorithm, a part of the algorithm consists in
finding the *order* (period) of a periodic function $f(x)=a^x mod N$, where $N$
is the number to factorize and $a$ is a random number used previously in the
algorithm. To find the periodicity of $f(x)$, we need to compute the operation
$\ket{x}\rightarrow\ket{xa \text{mod} N$.


Fortunately, the `Microsoft.Quantum.Arithmetic` namespace provides a function to
perform modular multiplications on qubit registers with `LittleEndian` encoding.
We just need to use the operation `MultiplyByModularInteger(a,N,x)`.

We won't detail the implementation in this module, but if you are interested in
how the Numerics library is used to implement Shor's algorithm you can explore
the [integer factorization
sample](https://github.com/microsoft/Quantum/tree/master/samples/algorithms/integer-factorization).

## Explore the samples

If you want to learn more about the Numerics library, we invite you to explore
the [Q# samples for the Numerics
library](https://github.com/microsoft/Quantum/tree/master/samples/numerics).
There you can get hands on experience on how the library is used to implement
custom modular additions, evaluation of polynomials using fixed-point
arithmetic or counting the resources needed for each operation.

## Stay tuned and contribute

The Q# community is constantly developing and adding new features to the
existing libraries. For example, we plan to add more high-level functionality to
the Numerics library like factorizing operations or operations useful for
cryptography. Stay tuned to the [Q#
Blog](https://devblogs.microsoft.com/qsharp) to be the first one to try the
newest features.

Also remember that Q# is an open source project, so you can participate. For
example, if you plan to adapt your latest quantum computing project into Q#
don't hesitate and share it with the community. To learn more about how you can
contribute to the Quantum Development Kit, check out our [contribution
guide](https://docs.microsoft.com/en-us/quantum/resources/contributing/?view=qsharp-preview).

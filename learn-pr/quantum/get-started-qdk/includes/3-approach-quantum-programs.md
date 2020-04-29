In this unit you are going to learn how to build a quantum random number
generator theoretically, which happens to be a perfect example to introduce the Quantum
Development Kit to combine quantum and classical programs. We will used the concept of Bloch sphere, H gate and superposition to introduce explain the example. If these terms are not familiar to you yet, you can read more about them in the QDK documentation page [here](https://docs.microsoft.com/quantum/concepts/glossary).  

One of the most direct applications of quantum devices is the generation of
verified random numbers. We can perform measurements on quantum systems to
obtain pure random values.

![A conceptual image of Schrodinger's cat](../media/cat.png) 

In Schrödinger's cat thought experiment, if we open the box to check if the cat
is dead or alive, the quantum state of the cat randomly collapses into one of
the two classical states. Since the state of the cat can be encoded with a
single bit (0 -> Alive, 1 -> Dead), when we open the box we're generating a
random bit.

We can encode any random integer or float into a bit-string, depending on the
number of decimals and size of our number. Therefore, to generate pure random
numbers we just need to generate many pure random bits.

In real life, cats can't be put in a quantum superposition (and of course we
don't want to possibly kill many cats to generate a random number). However, the
basic elements of quantum computers, the qubits, can be driven to a quantum
superposition and measured like when we open the cat's box.

## Understand the Q# operation with the Bloch sphere

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

We can use this representation to visualize the operations:

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

In the next unit, we will put all these together into code.
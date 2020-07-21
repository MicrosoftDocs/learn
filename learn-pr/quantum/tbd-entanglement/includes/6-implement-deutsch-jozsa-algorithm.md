In this unit you will use superposition, interference and entanglement to
implement in Q# the Deutsch-Jozsa algorithm.
This quantum algorithm is famous for being one of the earliest examples of
quantum computing solving a problem exponentially faster than any classical
algorithm. It has very limited real-life applications, but its relative simplicity
makes it a fantastic example to show how quantum computers can improve classical
results using superposition, interference and entanglement.

## Deutsch's problem

First let's introduce the problem we are going to solve. Suppose you're given a
function $f(x):\{0,1\}^n\rightarrow\{0,1\}$, this is, a binary function that takes a string
of bits and outputs a single bit. You're guaranteed that the function is:

- either *constant*, this is, outputs the same value for all inputs.
- or *balanced*, this is, for exactly half of the inputs it outputs $1$ and
  for the other half it outputs $0$.

For example, the function $f(x)=1$ for all $x$ is a constant function. On the
other hand, the
function $f(x)= x_{n-1}$, where $x_{n-1}$ is the last bit of $x$ is balanced.

The task is to find out wether if a given black-box function $f(x)$ is constant
or balanced with the least amount of calls possible.

## Classical algorithm

If we solve this problem classically, how many calls to the given function will we need?

The first call will give us no information - regardless of whether it returns 0
or 1, the function could still be constant or balanced. In the best case
scenario the second call will return a different value and we'll be able to
conclude that the function is balanced in just 2 calls. However, if we get the
same value for the first two calls, we'll have to keep querying the function
until either we get a different value or until we do $\frac{2^{n}}{2}+1$ queries that
will return the same value - in this case we'll know for certain that the
function will be constant.

This is, if the function is balanced we need to use the function on half plus
one of the possible inputs to be completely sure that the function is balanced.

## Quantum algorithm

Now let's see how we can exploit superposition, entanglement and interference to
find out if a function is balanced or constant with just one call.

### Quantum Oracles

First, we need to introduce the concept of *quantum oracle*. A quantum oracle is
a quantum operation that is used to implement a black-box function. This
operation is implemented in a way that allows to evaluate the black-box
function not only on individual inputs, but also on superposition of qubits.

>[!NOTE] This is not the same as being able to calculate the function on all
>inputs at once, since you'll be able to extract the evaluation of the qubit you
>decide to measure!

The oracle has to act on quantum states instead of classical bits. To enable
this, the integer input $x$ with binary representation $x=(x_0,x_1,...,x_{n-1})$
can be encoded into an n-qubit register: $\ket{x}=\ket{x_0x_1...x_{n-1}}$.

In this tutorial we are going to implement the function $f$ using *phase
oracles*. A phase oracle $U_f$ encodes the value of $f$ by modifying the phase the qubit register's state as follows:

$$U_f\ket{x}=(-1)^{f(x)}\ket{x}$$

In our case, since $f$ is binary it can either no change the phase if f(x)=0, or
add a $-1$ phase if f(x)=1. These phase shifts applied to superposition states will be
crucial for our algorithm.

[!NOTE] Remember that multiplying a complex number $z$ by another complex number
$u$ of
module $1$ means to modify the phase of $z$ without affecting its magnitude. To
see this we just need to represent the multiplication in polar coordinates. The
number $z$ in polar coordinates is $z=|z|e^i\phi_z$, where $\phi_z$ is the phase
of $z$. The number $y$ is just $y=e^{i\phi_y}$ since it has module one. Then the
multiplication is $zu=|z|e^{i\phi_z}e^{i\phi_y}=|z|e^{i(\phi_z+\phi_y)}$. This
is, a phase shift.

### Algorithm for n=1

Let's introduce the algorithm for the simplest case in which we have a function
$f:\{0,1\}\rightarrow\{0,1\}$, this is, a binary function that maps bits to bits.
This function can be constant if $f(x)=0$ or $f(x)=1$ and balanced if $f(x)=x$
(identity) or $f(x)=x+1$ (inversion). Classically, we need to evaluate $f$ two
times to determine if the function is constant or balanced. With quantum
computing, we can find it out with just one use of $f$. The algorithm would be:

1. Start with a qubit in the state $\ket{0}$.
1. Apply `\hat H` to create the superposition $\frac1{\sqrt2}\ket({0}+\ket{1})$.
1. Apply the phase oracle $U_f$ implementing $f$ to the superposition.
1. Measure the qubit: if the measurement yields $0$ then $f$ is constant. If the
   measurement is $1$ then $f$ is balanced.

#### How does the algorithm work?

When we apply the phase oracle to the initial superposition we obtain the
following state:

$$U_f \left( \frac{1}{\sqrt2} \big( \ket{0} + \ket{1} \big) \right)
= \frac{1}{\sqrt2} \big( U_f \ket{0} + U_f \ket{1} \big)
= \frac{1}{\sqrt2} \big( (-1)^{f(0)} \ket{0} + (-1)^{f(1)} \ket{1} \big)$$

Note that we used the linear properties of $U_f$. The resulted superposition is
conditioned on the properties of $f$. If $f(0)=f(1)$, i.e. if $f$ is constant,
then $\ket{0}$ and $\ket{1}$ will have the same phase. This means that if we
apply $\hat H$ again, the quantum interference will vanish the probability
amplitude of the state $\ket{1}$ as we saw in a previous unit. On the other
hand, if $f(0)\neq f(1)$, i.e. if $f$ is balanced, then $\ket{0}$ and $\ket{1}$
will have the same phase. If we apply $\hat H$ in this case it will occur the
opposite, the amplitude probability of obtaining $0$ will vanish.

**Exercise:** Check that if you apply $\hat H$ to the state
$\frac{1}{\sqrt2} \big( \ket{0} - \ket{1} \big)$ the resulting state has zero
probability of yielding $0$ when measured.

*Unit under construction*
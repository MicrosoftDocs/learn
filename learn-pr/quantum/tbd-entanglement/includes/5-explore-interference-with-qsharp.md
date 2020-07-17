In this unit we are going to explore quantum interfernce with Q# and see how we
can create quantum entanglement with Q#. We will also present the tool
`ResourcesEstimator` of the Quantum Development Kit, that will help us to know
what kind of resources do we need in order tu run our algorithms.

## An example of interference with Q#

In a previous unit we saw how if we superpose the states $\ket{\psi_1}=
\frac1{\sqrt2}\ket{0}+\frac1{\sqrt2}\ket{1}$ and $\ket{\psi_2}=
\frac1{\sqrt2}\ket{0}-\frac1{\sqrt2}\ket{1}$ the probability amplitudes of
$\ket{1}$ vanish and for $\ket{0}$ double.

How can we see this effect with Q#? Well, we can implement it with the help of
the `H` operation. We already know that $\hat H \ket{0} = \ket{\psi_1}$, we used
it for the quantum random bit generator. But what happens if we apply $\hat H$
to the state $\ket{0}$? What happens is that we obtain $\ket{\psi_2}$.
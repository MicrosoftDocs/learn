The word "qubit" means "quantum bit". A qubit is a quantum particle that has two possible positions, or *states*. As analog to the classical bit, we can call these states $0$ and $1$.

A qubit can be in the state $0$, in the state $1$, and in any superposition of both states.

## How can we represent the superposition in a qubit?

Imagine that we draw a circle and a vertical and horizontal axis such that the middle point is the center of the circle. We place the state $0$ at the upper point of the vertical axis and the state $1$ at the lower point.

How could we describe this representation? We could say that the state $0$ is an arrow, or a *vector*, pointing up and the state $1$ is a vector pointing down. Therefore a classical bit would be a vector pointing either up or down, but never in another direction.

:::image type="content" source="../media/superposition-bloch-sphere.png" alt-text="Diagram of a circle with two arrows pointing up and down from the center of the circle. The arrows represent the states 0 and 1 respectively. Any other state is an arrow pointing at other directions.":::

What about any other point of the circle? How can we represent that state? Just as coordinates in a plane, we could try to represent it as a combination of the two states $0$ and $1$. For example, we could take how close the vector is from the state $0$ and call this angle $\alpha$, and how close is from the state $1$ and call this angle $\beta$. We could represent the state as $\alpha 0 + \beta 1 $. Thus, the state is a *superposition* of the states $0$ and $1$.

Just like the example of the cat and the box, the global state of a qubit is the sum of the individual states, $0$ and $1$, weighted by the probability of finding the qubit in that state, $\alpha$ and $\beta $.

:::image type="content" source="../media/bloch-sphere.png" alt-text="Diagram of the Bloch sphere with states 0 and 1 in the z axis, and other vector representing the infinite combinations of superpositions.":::

This representation of a qubit is actually accurate, and it's known as the *Bloch sphere*.

> [!TIP]
> The Bloch sphere is a powerful tool as the operations that we can perform on a qubit can be represented as rotations about one of the cardinal axes. While thinking about a quantum computation as a sequence of rotations is a powerful intuition, it is challenging to use this intuition to design and describe algorithms. Q# alleviates this issue by providing a language for describing such rotations.

## What is the probability of finding a qubit in a state?

Just like the example of the cat and the box, the global state of a qubit is the sum of the individual states, $0$ and $1$, weighted by the probability of finding the qubit in that state, $\alpha$ and $\beta $. The numbers $\alpha$ and $\beta$ represent how "close" the qubit state is to the states $0$ and $1$, respectively. So, are $\alpha$ and $\beta$ the probability of finding the qubit in the state $0$ or $1$? Not exactly.

The numbers $\alpha$ and $\beta$ are *probability amplitudes* for each state. Their absolute values, for example $|\alpha|^2$ give the corresponding probabilities. For example, the probability for observing state $0$ is $|\alpha|^2$, and the probability of observing state $1$ is $|\beta|^2$.

The numbers $\alpha$ and $\beta$ can be positive, negative, or even complex numbers. However, in a valid quantum superposition, all probabilities must sum to one: $|\alpha|^2+|\beta|^2=1$. This constraint is known as the *normalization condition*. You can think of the normalization condition as the fact that you always obtain an outcome when you measure, so the probabilities of measuring every possible outcome must sum to one.

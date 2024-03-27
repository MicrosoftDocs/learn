
Before getting into qubits and operations, let's start with a simple example.

## How can we describe superposition?

You have a cat and a box, and you want to describe the possible configurations of the "cat and box" system. For example, "the cat inside the box", "the cat next to the box", and so on. Let's say that there are six possible configurations: "the cat on top of the box", "the cat inside the box", "the cat under the box", "the cat next to the box", "the cat in front of the box", and "the cat behind the box". Note that the configuration "the box inside the cat" isn't physically possible, so it's not included in the list.

These six positions are the individual possible configurations of the system "cat and box". How could you describe the global system? You could sum up the individual positions, like this:

:::image type="content" source="../media/cat-and-box-system.png" alt-text="Picture of a cat and a box and the representation of six different positions of the cat respect of the box.":::

However, just the sum of the individual positions doesn't capture the full picture. You also need to consider the **probability** of finding the cat in each of the individual positions. For example, the cat is more likely to be next to the box than on under of it. So, you need to weight each individual position by its probability.

The global system is the sum of the six different positions of the cat respect of the box, weighted by the probability of finding the cat in that position:

:::image type="content" source="../media/cat-and-box-system-probabilities.png" alt-text="Picture showing the state of the global system, which is the sum of the six different positions of the cat respect of the box, weighted by the probability of finding the cat in that position.":::

The cat and the box are classical objects, so you can only observe them in one of the six possible configurations at a time. This is the classical world, where objects can only be in one state at a time.

However, in the quantum world, things are different. A quantum cat and a quantum box could also be in all six states at the same time! This phenomenon is called **superposition**.

Quantum cats don't exist, - as far as we know - but quantum particles do. Let's say a quantum particle can be in 2 possible positions. Then, the quantum particle can be in the first positions, the second position, and also in a superposition of both at the same time. This is the case of qubits.
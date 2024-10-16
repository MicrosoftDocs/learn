
Understanding the fundamental concepts of quantum computing is the first step on your journey to a career in quantum. You can learn more in other courses to describe what happens within the underlying physics, engineering, and mathematical principles. For now, we focus on what you need to understand why working with this emerging technology is so exciting.

## Qubit

A qubit is a quantum bit. It's the basic unit of information, the same way a bit is in classical computing. We must understand a few key concepts to understand how a qubit differs from a classical bit and how we can process data in a quantum computer.  

However, before we do, it’s worth noting that we don’t experience quantum phenomena in our everyday lives. When matter behaves according to the rules of quantum mechanics, we must discard our intuitive understanding of the universe. And so, it is with qubits. The following descriptions likely seem unintuitive, but they're well-understood and tested. We don't have time to dig deeply into them here, but if you wish to learn more, there's a wealth of information.

## Superposition

Superposition is the principle that allows qubits to exist in a quantum state. Specifically, the qubit can exist simultaneously in various combinations of 0 and 1. This doesn’t mean that when we measure our qubit, we measure a nonbinary value like 0.5 or 0.2. Instead, it means there's more or less probability that we measure 0 or 1, with the probability depending on the superposition the qubit was in before we measured it. For example, we could put our qubit into a superposition such that when we measure the qubit, 80% of the time, we measure 0, and 20%, we measure 1. Until we perform the measurement, we can't know the outcome, only the probability.

## Entanglement

Entanglement in a quantum computer is a phenomenon that interconnects two or more qubits. This means that one qubit's state influences the second qubit instantly, no matter how far apart they are.

For example, if two qubits are entangled, measuring the state of one qubit will instantly determine the state of the other qubit. This perfect correlation means the state of one qubit is entirely dependent on the state of the other. This property allows quantum computers to share and process information between qubits in a way that classical computers can't.

## Interference

Interference describes how multiple waves interact with each other. In the ocean, when two wave peaks meet, they constructively interfere, becoming larger. Conversely, when a peak and a trough meet, they destructively interfere, becoming smaller.

Interference in a quantum computer relates to the interaction between multiple quantum states. We already learned that we're dealing with probabilities. When multiple qubit states interfere during the computation, some of the probabilities interfere constructively, amplifying each other, and some interfere destructively, canceling each other out. The aim of the computation is to manipulate probabilities using interference. This amplifies the probabilities of the correct answers while reducing those of the incorrect ones.

## Measurement

Measurement in quantum computing has a specific meaning. Unlike everyday measurements, such as measuring the length of a room, in quantum computing, measurement refers to the process of extracting classical information (1s and 0s) from a quantum system. The measurement is an action performed on the quantum computer that collapses the quantum state of a qubit into a definite classical state. This process destroys the original quantum state, making the timing and strategy of measurement crucial in the design of quantum algorithms.

To summarize, we use superposition to put our qubits into a combination of states and entanglement to make them behave as a single system rather than separate objects. Then, we use interference to amplify the probability of obtaining the correct answer while reducing the probability of incorrect answers. Therefore, when we perform our measurement, collapsing the quantum states and obtaining a classical result, we're more likely to measure the correct answer. By repeating this process multiple times, we can increase our confidence in the accuracy of the result.

You can see now that processing information on a quantum computer radically differs from a classical computer, relying on the concepts of superposition, entanglement, interference, and measurement. We only scratched the surface here, but hopefully you now have a better understanding of what’s involved in building a quantum algorithm.

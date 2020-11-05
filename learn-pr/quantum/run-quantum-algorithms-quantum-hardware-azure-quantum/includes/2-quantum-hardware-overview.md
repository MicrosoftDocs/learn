While modern classical computers are based on transistor technologies made up 
from semiconductors to implement classical logic operations, quantum computers
take radically different approaches to exploit the properties of quantum system
to implement qubits and quantum operations.

## Harnessing quantum systems to make computations

In order to build quantum computers, we need to have full access to the
controllable quantum systems that represent the qubits that we use to store the
quantum information. In general, it's agreed that a quantum computer should
fulfill the following criteria in order to be functional:

- **Scalability of qubits:** since quantum computers are based in the
  manipulation of quantum information by using qubits, we need a system that
  conceives an scalable number of many qubits. A qubit can be represented by any
  physical system with **two** *states* or *levels* that can be prepared in
  superposition.
- **Ability to initialize the qubits in a fiducial state:** having many qubits
  isn't useful if we can't trust their initial state. A fundamental
  characteristic of a quantum computer is its ability to initialize the qubits
  reliably to a specific state (usually the state $|0\rangle$).
- **Long lasting qubits:** quantum states are very delicate. The smallest
  interaction with the environment can "contaminate" the state of the qubits and
  ruin our computations. A quantum computer's qubit registers needs to be able
  to remain in a consistent quantum state long enough for us to perform the
  computations. The time a qubit can remain in a specific quantum state is often
  called *coherence time*.
- **Ability to perform an universal set of operations:** like in classical
  computing, any quantum algorithm can be decomposed as the application of a
  sequences of operations from a universal set of basic operations. This set is
  not unique, but a quantum computer should be able to reliably perform all the
  operations of a specific universal set.
- **Qubit specific reliable measurements:** to obtain the results of quantum
  computations we need the ability to measure with high precision of each qubit
  of the register. Note that the measurement process in quantum computers is
  different from classical computers. As the measurement affects the state
  of the register, it's often performed only at the end of the computation.

Building devices that meet these five criteria is one of the most demanding
engineering challenges ever faced by humankind. However, in the recent years
astounding advances in condense matter physics and quantum optics are allowing
companies and universities to build the first working version of quantum
computers. Microsoft is partnering with some of the top-class quantum computers
manufacturers around the world to give you access to the latest quantum
computing solutions through Azure Quantum. Let's see an overview of the
different technologies used to create quantum computers.

### Trapped ion quantum computers

Trapped ion quantum computers use *ions* (electrically charged atoms) suspended
in a electromagnetic field in the vacuum as the basic element to represent
qubits.

![alt_text=todo](../media/2-trapped-ion-quantum-computer.png)

In particular, these computers use chains of trapped ions, and each ion
represents a qubit. They use the transversal motion of the chain to induce
operations in the qubit states. The qubit states are stored in the internal
states of each ion. In particular, the qubit states are generally stored in two
hyperfine levels of the ion.

> [!NOTE]
> The hyperfine levels of an atom arise from the different possible
> configurations of the spins of the electron and the nucleus. Generally, the
> state with the lower energy, the ground state, is associated with the state
> $|0\rangle$, and the first excited state is associated with the qubit state
> $|1\rangle$.

These computers use advanced lasers and electromagnetic pulses to cause
transitions in the internal states of the ions and to modify the
vibrational motion of the ion chain. By combining very carefully
transformations of the vibrational motion of the ion chain and individual ion
transitions, it's possible to get qubits entangled and apply a universal set of
quantum operations.

Azure Quantum provides access to trapped ion quantum devices through our
partners IonQ and Honeywell. In this module you'll submit quantum
operations to this kind of devices.

### Superconducting quantum computers

Superconducting quantum computers are based in superconducting electronic
circuits. While classical computers use circuits of transistors to represent
bits and perform classical computations, superconducting qubits use *transmons*
to represent qubits and perform quantum operations.

If certain materials are cooled below a critical temperature, their electric
resistance drops to zero. These materials are called **superconductors**. By
linking two superconductors with a thin insulating barrier, you can build
*transmons*, an electronic device that can exist in a superposition of two
states. Transmons can be considered analogous to transistors. While in
transistors you use junctions of semiconductors to represent controllable bits,
in transmons you use junctions of superconductors to represent controllable
qubits.

[FIGURE TRANSISTOR VS TRANSMON: I want to put a figure here comparing a transitor
representing a bit, and a transmon representing a qubit]

There are other variants of superconducting circuits that don't use transmons
but similar technologies. However, transmons are the key component in most cloud
available superconducting quantum computers.

Since superconducting properties appear at very low temperatures and higher
temperatures imply more noise, these quantum computers work at very low
temperatures, near absolute zero. This is why these chips are usually contained
in big cryostates.

[FIGURE OF CRYOSTATE OF A QUANTUM COMPUTER]

### Other types of quantum computers

Trapped ion and superconducting quantum computers aren't the only options for
quantum computing, although are the most advanced so far. In general, any
controllable quantum system with two levels can be used to represent qubits. For
example:

- **Quantum dot computers:** quantum dots are small cumulous of semiconductor
  atoms that behave like macroscopic atoms that can be place in superposed
  states. They can be used to represent qubits.
- **Photonic quantum computers:** they use polarized photons to represent qubits
  and light guides to implement quantum operations.
- **Topological quantum computers:** a theoretical proposal for quantum
  computers that use a new type of material called *anyons* to create qubits
  very resilient to noise.

There many other proposals for quantum computers since it's a field still under
development. With Azure Quantum you have access to an ever-increasing collection
of quantum computers to run your own quantum algorithms.

### Azure Quantum for cloud quantum computing

Azure Quantum is a cloud computing hub where you can connect to different
industry leader providers to use their most advanced quantum computers.

![Alt_text=Diagram of the Azure Quantum service](azure-quantum-flow-diagram.png).

You just need an Azure subscription to start submitting quantum computing jobs
to Azure Quantum. These jobs will be queued by the provider to be run in the
target device you selected. Through Azure Quantum you can manage your jobs and
monitor their states.

In the next unit, you'll use Azure Quantum to submit your first quantum
computing job.
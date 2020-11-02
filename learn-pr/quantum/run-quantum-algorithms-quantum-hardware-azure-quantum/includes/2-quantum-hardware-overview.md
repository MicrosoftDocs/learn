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
  reliably to a specific state (usually the state $\ket{0}$).
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
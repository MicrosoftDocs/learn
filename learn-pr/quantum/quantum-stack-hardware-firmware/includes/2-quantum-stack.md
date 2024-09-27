
The quantum stack refers to the technology required not only to build a quantum computer but also to connect this device to the existing computing infrastructure and enables users around the world to access this technology. This stack is sketched out below. Let's dig into each layer of the stack, covering what technology is required, what skills are required, and the career paths available.

Let’s start from the bottom, the QPU, where quantum bits (qubits), not bits, are used to process information.

:::image type="content" source="../media/quantum-stack.png" alt-text="Diagram showing the different parts of the quantum stack.":::

## Quantum Processor Unit (QPU)

The QPU is the core that enables us to harness the power of quantum information processing, utilising the laws of quantum mechanics to perform calculations in a way impossible on traditional computers.  

There are various methods for creating a QPU, but several requirements must be met when choosing how to build one.

- First, our QPU must be well isolated from the environment, meaning it must be very cold and very dark. A single stray photon of light can spoil our data. Next, and somewhat contradictory, we need to be able to manipulate it with extremely high precision – so only we can interact with our qubits.

- Next, we must be able to scale the number of qubits. A useful quantum computer is expected to require at least 100k qubits, so there must be a clear technological path to building large QPUs of millions of qubits.  

- Last, the QPU must be able to hold its quantum state for a long time. This means it won't lose its data too quickly. If it loses this data quickly, we won't be able to perform the necessary calculations before errors creep in and spoil our data.

These are challenging requirements, and no matter what substrate you choose, there are always trade-offs. Today, there are no perfect qubits, and different companies and research groups pursue numerous different approaches to building qubits. The most well-known is superconducting qubit technology, which is being used by IBM and Google, but there are also systems based on trapped atoms and ions, photonics, and electrons trapped in quantum dots – spin qubit QPUs. The qubit of the future may not have even been invented yet.

If you want to learn more about the requirements for building a QPU, you can search for DiVincenzo’s criteria, which outlines five requirements for a quantum computer QPU in more detail than we can share here.

Let's now explore two leading technologies, superconducting and trapped atom QPUs.

:::image type="content" source="../media/superconducting-fridge.png" alt-text="Image of a superconducting circuit for quantum computing featuring a cylindrical structure.":::

### Superconducting QPU

A superconducting QPU uses a microfabricated chip with superconducting wires and elements that are cooled to temperatures near absolute zero (millikelvin range) using dilution refrigerators. At these extremely low temperatures, the circuits exhibit quantum mechanical behavior, enabling the formation of qubits from these circuit elements, typically using something called a Josephson junction. The QPU is controlled through precise microwave pulses that manipulate the state of the qubits.

The advantage of superconducting QPUs is that they leverage mature solid-state fabrication techniques, making them relatively straightforward to manufacture and integrate into existing infrastructure. Additionally, due to the high-speed nature of microwave control, they allow for fast gate operations, which means they can process our quantum programs quickly.

However, since these qubits are physically connected to their surroundings and require extensive wiring for control and readout, they are susceptible to environmental noise. This noise causes the rapid loss of quantum information and necessitates using sophisticated and fast error correction algorithms to ensure the output is useful.  

Despite these challenges, superconducting quantum computers are very popular, with IBM and Google building large, sophisticated machines.

### Neutral Atom QPU

Neutral Atom QPUs use a cloud of atoms held in place with lasers inside a vacuum chamber. These atoms are chosen from particular metals, exhibiting the right characteristics that allow them to be trapped and used as qubits. Some common metals used are rubidium and caesium, and more recent developments are exploring the suitability of ytterbium and strontium.  

Atoms are trapped in a grid of intersecting lasers called an optical lattice. These lasers allow each atom to be moved around and positioned where we want it, giving the QPU very high levels of flexibility.  

Yet more lasers manipulate the atom's internal state, changing their energy levels, and through this process, the atoms form qubits. Since the atoms are held in a vacuum, the qubits are well shielded from the environment and can hold their quantum information for several seconds. However, they require complex optical setups, expensive lasers, and the qubits generally operate much more slowly than superconducting qubits.  

Companies such as Infleqtion, QuEra and Atom Computing are all pursuing this technology to build QPUs, as it offers a clear path to quickly reaching large numbers of qubits.

:::image type="content" source="../media/Lasers.png" alt-text="Image of a bright blue laser beam passing through optical components on an optical table.":::

In labs worldwide, scientists work tirelessly to understand how to build bigger and better QPUs for quantum computation. The challenge has been creating high-fidelity qubits that would allow us to build a large enough QPU to run a useful computation that can be applied in a commercial setting. Today, quantum computers that offer a real advantage over classical ones are still a way off. However, the good news is that significant progress has been made over the last few years, leaving the scientific community with a few puzzle pieces to solve and significantly more input needed for engineering and programming challenges ahead.

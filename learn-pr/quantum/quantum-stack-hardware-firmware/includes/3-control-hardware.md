
:::image type="content" source="../media/fpga.png" alt-text="Image of circuit boards with various electronic components, including cooling fans, heatsinks, and connectors.":::

Now, we move one step up the quantum stack and look at the electronics used to control the QPUs we’ve just learnt about.  

The control hardware layer is fundamental to the quantum computer. This layer converts the quantum applications into electronic signals, producing microwaves, laser pulses, and other signals that interact with our qubit and QPU.  

This layer involves designing and implementing the electronic hardware that generates and manages the millions of signals going to and from the QPU. As you can see, this involves complex PCB design with the latest FPGAs and RF electronics.  

While this electronic layer controls the QPU, it borrows from traditional networking technologies. These technologies are used to build highly complex and sophisticated electronic systems that power quantum computers today. In the future, as the technology matures this layer becomes smaller and more powerful. Just as today, we don’t think about the electronics that control our computers' CPU, RAM and storage, so this layer becomes a black box controlling and managing the QPU.  

The challenge of today's control hardware is that it's large and bulky. It's derived from test equipment and hasn’t had the long development journey of other computing technologies. This is compounded by the problem that the QPU must be isolated from the environment, either at the bottom of a dilution fridge or in a vacuum system only controlled with lasers.  

### Challenges for superconducting & spin quantum computers

As quantum computers grow in size and move out of the lab, using conventional signal generation and cabling quickly becomes prohibitively complex and costly. Superconducting and silicon spin QPUs of sufficient scale would require tens of thousands, if not millions, of cables fed into a dilution fridge and to the QPU.  

The future of control hardware for these devices lies in cryo-ASICs. This control hardware, which performs logical operations and generates millions of analog signals, is situated inside the fridge next to the QPU, in an extreme form of edge computing. However, conventional electronics aren't designed to operate at such cold temperatures, only a few degrees above absolute zero, where the properties of transistors and materials change.

Building these cryo-ASICs is an active area of research. Learning how to construct and program these devices are crucial if superconducting or spin QPUs are to become practical and useful quantum computers.

### Challenges for atomic QPUs

Ion trap and neutral atom quantum computers face different challenges. While the atoms are trapped in a vacuum, the electronics that control them sit at room temperature in 19” racks. These systems operate at lower frequencies, making the generation and control of electronic pulses easier.

However, there are significant challenges. Lasers control the atoms, and not just any lasers; they must be well-controlled, with incredibly low noise, and sufficient power. Additionally, the lasers that can be used are dictated by the specific atom the QPU uses, as determined by underlying atomic physics. This constraint often means that commercial telecom lasers aren't an option.

Fortunately, it's possible to buy lasers that can generate all the necessary wavelengths of light to trap and control atoms. However, these scientific instruments are delicate and prone to failure, requiring significant maintenance and upkeep.

Therefore, the future of atom-based QPUs requires the development of commercial-grade lasers and optical systems—systems that can operate reliably day and night with minimal supervision.

In conclusion, we can see that no matter the type of QPU, building the control electronics, optics, and laser systems needed to drive these devices still poses significant challenges – and opportunities.

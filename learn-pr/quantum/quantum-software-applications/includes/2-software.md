
## Software

:::image type="content" source="../media/qiskit.png" alt-text="Screenshot of the Qiskit GitHub repository.":::

In earlier modules, we touched upon how quantum computers process information in a fundamentally different way from classical computers. Since everyday programming languages, such as Python and C++, were designed to store and process data in classical computers, they don't have the inherent tools to describe and manipulate quantum computing data accurately. To address this challenge, new software tools and frameworks are being developed specifically for building and running applications on QPUs.  

These tools, often based on Python, incorporate specialized constructs and functionalities that cater to the unique requirements of quantum computing. They bridge the gap between high-level algorithm design and low-level hardware implementation. This bridge provides algorithm developers with the syntax and abstractions to describe and manipulate quantum systems accurately. Today, several exist, such as Q#, Qiskit, and PennyLane, to name a few.  

### Q#

Q# is a domain specific language developed by Microsoft for writing quantum algorithms. It's integrated with the Microsoft Quantum Development Kit and designed to work seamlessly with classical programming environments, particularly within the Python ecosystem.

Through the Microsoft Azure Quantum platform, users can access a wide range of different QPU backends, all programmable through their Q# language.

### Qiskit

Qiskit is an open-source quantum computing framework developed by IBM. It's currently the most popular language used. Qiskit provides a comprehensive set of tools for creating and running quantum algorithms on IBM’s dedicated hardware.

### PennyLane

PennyLane is a platform for Quantum Computing and Machine Learning (ML). It integrates with ML libraries such as PyTorch and TensorFlow, allowing researchers to create and optimize circuits and algorithms. It also offers a range of hardware backends from different QPU providers.

As machines develop and evolve, so do these software tools. This high abstract level is important to maximize the utility of the QPUs available and enable as many users as possible to access them.

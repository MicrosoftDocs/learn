There are many models of quantum computing. In [Write your first program by using the Quantum Development Kit](/learn/modules/get-started-qdk?azure-portal=true), you learned about the Gate Model. With that model, you perform operations that use quantum gates to create quantum programs.

**TODO:** The QDK module doesn't cover the Gate Model. I'm adding a TODO on that end as well to add it.

Quantum-inspired algorithms are based on a different computational model called *adiabatic quantum computing*. This approach uses a concept from quantum physics known as the adiabatic theorem. When you apply that theorem to solve a problem, you:

- First prepare a system and initialize it to its lowest energy state. For a simple system, one which we completely understand, this is easy to do.
- Next, slowly transform that system into a more complex one that describes the problem we are trying to solve. The adiabatic theorem states that, as long as this transformation happens slowly enough, the system has time to adapt and will stay in that lowest energy configuration. When we're done with our transformations, we've solved our problem.

A good analogy of this is to imagine you have a glass of water. If you move that glass slowly across a table, the contents won't spill because the system has time to adapt to its new configuration. If you were to move the glass quickly however, the system has been forced to change too quickly, and we have water everywhere.

Adiabatic quantum computation is well understood and, as a result, a number of techniques have been developed to simulate this type of physics. These classical algorithms, which we can run on classical computers today, are also known as quantum-inspired approaches.
Congratulations! You saved the day and completed all the repair tasks before disaster occurred.

![Image showing a cross-section of the spaceship, with rooms such as life support, the reactor and the cockpit.](../media/spaceship-core.png)

In this module, you have learned:

- What the job shop scheduling problem is and why it matters
- How to represent constraints in the form of penalty functions
- How to define an objective function
- How to combine these penalty and objective functions and assign weights to form a cost function
- How to submit the cost function to Azure Quantum
- How to understand & parse the results
- How to validate the results
- How to tune the problem parameters

### Next steps

Now that you understand the problem scenario and how to define the cost function, there are a number of experiments you can perform to deepen your understanding and improve the solution defined above:

- Modify the problem definition:
  - Change the number of jobs, operations, and/or machines
    - Vary the number of operations in each job
    - Change operation runtimes
    - Change machine assignments
    - Add/remove machines
- Rewrite the penalty functions to improve their efficiency
- Tune the parameters
- Try using a different solver (such as `ParallelTempering`)

You can find this tutorial in Jupyter notebook format in our samples repo - this will allow you to modify and experiment with the code.

### Learn more about Azure Quantum & the Quantum Development Kit

If this has piqued your interest, be sure to check out our other Azure Quantum Learn Modules.

If you're curious to learn more about quantum computing, be sure to check out the [Microsoft Quantum Documentation](https://docs.microsoft.com/en-us/quantum/?azure-portal=true).

There you'll find comprehensive reference material, including:

- Fundamental concepts around quantum computing.
- Quickstarts and tutorials.
- Q# language and API reference.
- How to use Q# with C#, Python, and Jupyter notebooks.

Once you're ready to dive deeper, you can [browse code samples](https://docs.microsoft.com/en-us/samples/browse/?WT.mc_id=launchblog-blog-QA&products=qdk) or [learn quantum computing with the Quantum Katas](https://docs.microsoft.com/en-us/quantum/tutorials/intro-to-katas/?azure-portal=true).

To learn about real-world usage of the QDK, check out this blog post on Microsoft Quantum's collaboration with Pacific Northwest National Laboratory (PNNL), [Simulating nature with the new Microsoft Quantum Development Kit chemistry library](https://cloudblogs.microsoft.com/quantum/2018/12/04/simulating-nature-with-the-new-microsoft-quantum-development-kit-chemistry-library/?azure-portal=true).

Be sure to [join the quantum community](https://docs.microsoft.com/quantum/overview/understanding-quantum-computing/?azure-portal=true) if you have questions or want to contribute to Microsoft's many open-source projects.

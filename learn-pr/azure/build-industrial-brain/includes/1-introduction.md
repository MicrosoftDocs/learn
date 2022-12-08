Suppose you're the head of the chemical engineering team at the chemical manufacturing company and manage the process of chemical reactions to be used in several applications, including chemical production, food and beverage manufacturing. 

You use a Continuous Stirred Tank Reactor (CSTR), which is essentially a tank that has a stirring apparatus to continuously mix reactants inside. The inlet to the reactor has a specific concentration. This fluid reacts exothermically, and the output concentration will depend on the temperature of a cooling fluid that keeps the concentration steady.

The reactor operates continuously, so during steady-state operation, you continuously feed the reacting fluid as an inlet while extracting the resulting reacting fluid at a similar or lower concentration with a fixed conversion rate.

It is an exothermic reaction that generates heat. The system is nonlinear and can be challenging to control residual concentration and temperature. The objective of this step of your chemical process is to control the coolant temperature to transform the input fluid characteristics into your needed output fluids. Your engineers currently supervise the process, which consists of a PI controller that performs under different operating conditions: steady-state and transient. The residual concentration and reactor temperature over time can be evaluated for any desired control. Your team has a simulation which was used to test the PI controller initially. At each time step of the simulation, the PI controller receives the required simulated states and then it outputs the delta temperature of the coolant to be applied to transition into the new desired concentration. The current system has the following limitations:

- Ability to control well across scenarios
- Operating under changing conditions
- Optimizing for multiple and competing goals
- Supervisory limitations by human operator / engineer
- Sensory noise makes the process difficult to control or optimize
- Time to develop a control or optimization system is prohibitive

Now you want to generalize the chemical process across different scenarios and eliminate the limitations.  You’ll build an Autonomous AI brain to control chemical processes in the reactor by practicing on a simulation.

In this module, we explore the following themes:

- Machine Teaching decomposition of the problem
- Modular brain design
- Bonsai brain definition and training in the Bonsai platform

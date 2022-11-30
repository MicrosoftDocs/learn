Continuous stirred tank reactor (CSTR) transitions from low to high conversion rate (high to low residual concentration). The chemical reaction is exothermic and the reactor temperature is controlled with a cooling jacket filled with coolant.

An exothermic reaction produces heat, thus the reactor temperature must be controlled to prevent thermal runaway, when the reactor becomes so hot it would practically melt.

> [!NOTE]
> In chemistry (and chemical engineering), thermal runaway is associated with strongly 	exothermic reactions that are accelerated by temperature rise.

The objective is to train a brain(s) to control the reactor temperature for the CSTR to prevent thermal runaway during transition of residual concentration to new target values.

The CSTR needs to operate under transient and steady state conditions:

- When the reactor is running in continuous production, it is in continuous **steady-state** operation and there is not much change. The CSTR produces a specified product.
- When the CSTR is starting up or transitioning to produce different output concentrations, it is in a **transient state**. The transient state is difficult to control to reach the target concentration of the product while preventing thermal runaway.

## Decompose problem

Let's take a look at how this brain is designed. First, we start by defining input/states.  (You can see the full AI specification document here).  

- The inputs are Cr, Tr, Cref, Tref and Tc.
    - Cr: This is the actual residual concentration of the reactor's output fluid.
    - Tr : This is the actual temperature of the reactor's output fluid
    - Cref : The reference residual concentration is the desired concentration at every timestep 
    - Tref : The reference reactor temperature is the desired reactor temperature at every timestep
    - Tc: The coolant temperature of the reactor cooling jacket. The coolant is the controlling agent of the reaction’s concentration and temperature.

Next, we define the concepts/skills we want to teach Autonomous AI brain.

- **Learned Concept 1**: **Steady State** - The reactor operates under continuous steady-state condition
- **Learned Concept 2**: **ModifyConcentration** - The reactor operates under transient conditions when modifying the concentration
- **Selector Concept**: **SelectStrategy** - We also define a selector concept where the AI must learn under which conditions to apply each skill. This concept decides which strategy to deploy.  

Finally, we define the output of our brain to change the coolant temperature.

- The output is dT.
    - dTc : The change of coolant temperature from initial coolant temperature (at the beginning of simulation).

## Understand modular brain

Complex tasks often require multiple skills and strategies, and those skills and strategies are likely dictated by the dynamics of the task itself.

In this example we leverage two operation conditions (steady state and transient) and those can be considered two separate skills that the brain must learn. Rather than focusing on the single-objective, we add a second objective. The brain reports which strategy it is deploying in addition to the control actions.  We call this architecture the modular brain.

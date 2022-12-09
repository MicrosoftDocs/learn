Bonsai provides prepackaged simulators and sample codes.

To build a new brain for the continuous stirred-tank reactor (CSTR) problem:

1. Click the Chemical Reactor icon in the Getting started panel.
2. Name your new brain (for example, "CSTR sample").
3. Click Create.

The sample CSTR brain and simulator will be loaded.

## Navigate to the Visual Authoring

To turn on Visual Authoring, toggle the switch at the top right of the Bonsai UI on the Teach tab.

## Translating CSTR AI Spec into the Bonsai brain

The trained AI for the Chemical Reactor will adjust the coolant temperature to prevent thermal runaway. Here's the link for CSTR AI Specification document.

### Concept

This problem consists of the three concepts we defined earlier during our overview of the AI Specification document. The concepts are defined as "**Steady State**", "**Modify Concentration**", "**Selector Strategy**". The concepts will receive environment states and respond with control actions.

**Concept 1**: Steady State

- This concept learns to maintain reactor temperature while the reactor produces a constant residual concentration of 8.57 kmol/m3.

**Concept 2**: Modify Concentration

- This concept learns to regulate the reactor temperature during transition.

**Selector Concept**: Select Strategy

- This concept chooses which strategy to apply based on the conditions of the environment.

### Environment State

The environment state defines the current situation of the simulation. This includes the measured status of the reactor, the residual concentration (Cr) and the reactor temperature (Tr); the references desired, the concentration reference (Cref) and the temperature reference (Tref); as well as the absolute temperature of the coolant (Tc).

The steady-state conditions in the reactor can be uniquely identified by either concentration or temperature. In other words, the steady state reference temperature is unique for a given reference concentration, and vice versa. That is the reason why we only have the reference value for concentration on our ObservableState (without the need for a temperature reference value).

### Control Actions
Control action is what the brain outputs after observing a new environment state. Given the environment state (Cr Tr, Cref, Tc), the brain will change the coolant temperature to meet the defined goals.

During machine teaching experimentation, our brain trainer realized that the system learns better when asked to provide the adjustment of temperature from previous absolute value. Thus, our brain action won't be dTc, but Tc_adjust.

- Transformation on simulation at each timestep: dTc = previous_dTc + Tc_adjust

The brain action can be accessed by clicking on the box at the bottom of our graph. As shown below, the control action is an output from the brain and input to the simulation.

### Goals/Rewards

Goals consist of the learning objectives that any successful control strategy must meet. Goals are found in the CSTR AI Specification document and summarized as.

The goal is expressed with two goal objectives, same for both concepts.

1. Keep the concentration as close to the target as possible: **minimize** the difference between the current concentration (Cr) and the target concentration (Cref).
2. Don't let the reactor temperature exceed 400 K: **avoid** the current temperature of the reactor (Tr) exceed 400 K.

You can see in the figures below the goals for the three concepts we have in our modular brain: each one of the two concepts, and the selector. Additionally, we've highlighted the lessons (scenarios) each concept is presented with.

You can see the ranges defined for each goal by clicking on the EDIT (pencil) button on any of the concepts.

Note that available goal objectives in Inkling include:

- [avoid](/bonsai/inkling/keywords/goal?tabs=avoid): Avoid a defined region.
- [drive](/bonsai/inkling/keywords/goal?tabs=drive): Get to a target as quickly as possible and stay near the target.
- [maximize](/bonsai/inkling/keywords/goal?tabs=max): Push a target value as high as possible within a given range.
- [minimize](/bonsai/inkling/keywords/goal?tabs=min): Push a target value as low as possible within a given range.
- [reach](/bonsai/inkling/keywords/goal?tabs=reach): Get to a target as quickly as possible.

### Simulation

The simulation models the real-world process and updates the environment states as the brain applies the control actions. Our simulation needs to have an initializer method to instance the simulation, a stepping method where the actions of the brain are applied to the system, and an episode reset method to allow the sim to stop the current episode and start a new one.

Episodes may end naturally once they reach the max episode length. Others might have to be abruptly interrupted after hitting a terminal condition such as thermal runaway. In both cases, we need to be able to reset into new episodes based on the scenario that the brain is being trained in. Thus, the simulation reset method must allow us to define the set of desired initial conditions for the concept being trained.

In Bonsai, the parameters that allow a brain to perform custom initialization of the conditions of the system are called configuration variables. The CSTR simulation has the following config parameters that can be used to customize the reset of the simulation for each concept.

Bonsai provides prepackaged simulators and sample codes.

To build a new brain for the continuous stirred-tank reactor (CSTR) problem:

1. Click the Chemical Reactor icon in the Getting started panel.
2. Name your new brain (e.g., "CSTR sample").
3. Click Create.

The sample CSTR brain and simulator will be loaded.

## Navigate to the Visual Authoring

To turn on Visual Authoring, toggle the switch at the top right of the Bonsai UI on the Teach tab.

## Translating CSTR AI Spec into the Bonsai brain

The trained AI for the Chemical Reactor will adjust the coolant temperature to prevent thermal runaway. Here is the link for CSTR AI Specification document.<link>

### Concept

We first define the concepts whose definition can be found in the extract of the AI Specification document. The concepts are defined as "**Steady State**", "**Modify Concentration**", "**Selector Strategy**". The concepts will receive environment states and respond with control actions.

**Concept 1**: Steady State

- This concept learns to maintain reactor temperature while the reactor produces a constant residual concentration of 8.57 kmol/m3

**Concept 2**: Modify Concentration

- This concept learns to regulate the reactor temperature during transition

**Selector Concept**: Select Strategy

- This concept decides which strategy to deploy.

### Environment State

The environment state defines the current situation of the brain. After every iteration a decision is made to the coolant temperature, the residual concentration (Cr) and the reactor temperature (Tr) change.

Note that the reaction steady-state conditions are unique for reference concentration and temperature. In other words, the steady state reference temperature is unique for a given reference concentration, and vice versa. For that reason, it is good to only focus on reference concentration for our ObservableState (without the need to have the reference temperature as an additional.

### Control Actions
Control action is what the brain outputs after observing a new environment state. Given the environment state (i.e Cr Tr, Cref, Tc), the brain will change the coolant temperature to meet the defined goals.

During MT experimentation, our brain trainer realized that the system learns better when asked to provide the adjustment of temperature from previous absolute value. Thus, our brain action will not be dTc, but Tc_adjust.

### Goals/Rewards
Goals are what the learning process of the module wants to reach. Goals are found in the CSTR AI Specification document.

As shown below, the goal is expressed with the two goals for each concept:

1. Keep the concentration as close to the target as possible. You will minimize the difference between the current concentration (Cr) and the target concentration (Cref) 
2. Do not let the reactor temperature exceed 400K. You will avoid the current temperature of the reactor (Tr) exceed 400K

You can see the ranges defined for each goal by clicking on the EDIT (pencil) button on any of the concepts.

Note that available goal objectives in Inkling include:

- avoid: Avoid a defined region.
- drive: Get to a target as quickly as possible and stay near the target.
- maximize: Push a target value as high as possible within a given range.
- minimize: Push a target value as low as possible within a given range.
reach: Get to a target as quickly as possible.

### Simulation

The simulation models the real-world process and updates the environment states as the brain applies the control actions. Therefore, our simulation needs to have an episode initializer method, a stepping method where the actions of the Brain are applied, and an episode restart method to allow for stopping the sim once the episode is finished.

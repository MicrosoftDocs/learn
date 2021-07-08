In this unit, you'll learn how the Project Bonsai components work together. If you're a user of automation systems, you'll learn how Bonsai can streamline the process of automation development. As we've discussed, Bonsai consists of the components that the following table describes and the subsequent graphic displays: 

| Component                                  | Description                                                  |
| ------------------------------------------ | ------------------------------------------------------------ |
| Simulation connector                       | Connects a simulator to Bonsai.                              |
| AI training engine                         | Manages AI learning.                                         |
| Training curriculum (goals and objectives) | Defines what the AI should learn using user-friendly terms.  |
| Brain exporter                             | Packages the trained AI in a container for deployment in production. |
| Inkling                                    | Is a customer programming language.                             |

> [!NOTE]
> A Bonsai brain (trained AI) is a nascent AI that's in the process of learning.

:::image type="content" source="../media/introduction.png" alt-text="Simulator flows into circular graph connecting training engine and curriculum and integrated simulation. Outgoing arrow indicates an exported brain.":::

## How do these components work together?

In a typical scenario, you start by identifying a problem you want to solve by using AI. You can then take the following steps:

1. Create a simulation that models the real-world environment in which the AI will operate.
1. Test and verify the simulation locally.
1. Use a connector to import the simulation as a managed simulation package in Bonsai.
1. Design a teaching plan in Inkling using goals and objectives.
1. Iteratively train and assess the Bonsai brain's performance.
1. Export the fully trained AI as a Docker container. This occurs only after you determine the brain is trained appropriately.
1. Run verification against the exported AI.
1. Deploy the Docker container and integrate it with your real-world control system. This occurs only when you're satisfied with the AI performance.

## Work with simulations

Simulations replicate your real-world systems. This enables you to provide a valid training context in which your Bonsai brains can learn. When planning simulations, consider that they'll work well with Bonsai if they have the following characteristics:

- A suitable level of fidelity. This helps ensure that strategies you develop against the simulation are likely to work well in the real world.
- Useful visualization and data output. This helps ensure meaningful real-time assessment during training.
- A well-defined environment state. This must be accessible at each step of the simulation.
- A customizable start state. This helps ensure that the brain learns from various conditions.
- A set of discrete actions the brain can take to affect the state. For example:

  - Move a cart one step on a production line.
  - Adjust a temperature in a manufacturing process by 1° Celsius.

- The ability to identify system failure. An example is when the system gets into a state where further progress is impossible, such as:

  - A cart stops on the production line.
  - The temperature exceeds a manufacturing threshold.

- The ability to determine when the system reaches a success state. For example:

  - A cart moves down the line over a defined distance.
  - The temperature is maintained at a constant value for a defined period.

When considering your simulation approach, it might be helpful to enlist people in your organization who've worked with simulation software before.

> [!TIP]
>
> You can often repurpose and enhance existing simulations so they work with the
> Bonsai training engine. Try to locate simulations that:
> 
> - Are used to train human operators.
> - Are used in conjunction with production systems.
> - Have well-defined benchmarks for accuracy and desired outcomes.

## Work with the training engine

As discussed, the training engine manages AI learning. It has four components:

- Architect
- Instructor
- Learner
- Predictor

### Architect

Based on the training curriculum that you define using Inkling code, the Architect:

- Creates and optimizes learning topologies (neural networks).
- Proposes the configuration of learning algorithms and topologies that have the best chance at learning the model's concepts.

> [!TIP]
> Essentially, the Architect does what a data scientist would do when evaluating a neural network's effectiveness.

The Architect supports the following learning algorithms:

- Distributed Deep Q Network (APEX).
- Proximal Policy Optimization (PPO).
- Soft Actor Critic (SAC).

> [!NOTE]
> The set of heuristics that the Architect uses is based on the heuristics that data-science and machine-learning experts use when they work on the Architect codebase.

### Instructor

Based on training curriculum, the Instructor:

- Carries out the training plan by configuring:

  - The Learner.
  - Any required data sources.

- Works interactively, and responds in real time as the Learner proceeds through:

  - Receiving data.
  - Computing a response.
  - Being assessed.
  - Learning from the result.

### Learner

The Learner carries out the underlying AI algorithms that the Architect selects. During training, the Learner coordinates with the Instructor to set the learning algorithm's starting parameters, determines a response, and grades its performance.

In a deployed brain, the Learner must instantiate the trained system and execute its computation when needed.

### Predictor

The Predictor is essentially a trained brain. After the brain is trained, Bonsai hosts the AI algorithm in prediction mode.

> [!NOTE]
> Prediction mode holds a brain for use as an HTTP API endpoint. This enables programmers to send input data to the brain to receive a prediction.

## Work with the training curriculum

The training engine uses your training curriculum (your goals) to:

- Select the best learning algorithm for your brain.
- Report on training progress based on the goals you specify.

Available goal objectives include:

- Avoid. Avoid a defined region.
- Drive. Get to a target as quickly as possible and stay near it.
- Maximize. Push a target value as high as possible within a given range.
- Minimize. Push a target value as low as possible within a given range.
- Reach. Get to a target as quickly as possible.

> [!TIP]
> You can define any number of goals. The training engine attempts to satisfy them all.

Project Bonsai is a low-code AI platform that works with machine-teaching simulations. These simulations are built on software you might already use. By understanding what Bonsai is, and what it can do, you can better determine whether it might benefit your organization.

## What is low-code AI-powered automation?

Low-code AI solutions are great for engineers and data scientists with varying levels of development experience. These solutions enable them to successfully build AI-powered control systems. Low-code solutions typically use visual development environments and a more traditional coding environment. Visual editors let developers focus on creating the right solution rather than the tools they're using.

## Project Bonsai definition

Bonsai enables you to codify what an AI should learn by using human-friendly statements such as "avoid" and "maximize." This means you don't have to explicitly define detailed reward and terminal functions.

Bonsai includes integrated support for popular simulation software packages such as Simulink, MATLAB, and AnyLogic. Your simulation developers can therefore build machine-teaching simulations by using familiar software.

AI training with Bonsai has several components that work together, including:

- Training simulation
- Training engine
- Training curriculum
- Brains

### What is a training simulation?

Training simulations replicate your real-world systems to create a realistic training context for Bonsai brains. Add simulations from a range of Bonsai simulation partners or use the Simulator API to integrate custom simulators.

:::image type="content" source="../media/training-simulation.png" alt-text="Simulator flows into circular graph. Outgoing arrow indicates an exported brain. The Training simulator section is highlighted.":::

Training simulations model real-world processes and change state as the Bonsai brain applies actions. Training tasks can be fairly basic, such as "stand up," or more challenging, such as "learn to dance."

All of the following domains use simulations to model the behavior of complex systems:

- Robotics
- Industrial automation
- Supply-chain logistics
- Structural engineering

> [!NOTE]
> Bonsai uses simulations and Deep Reinforcement Learning to train brains.

You can use almost any simulation with Bonsai that:

- Has a defined start state.
- Iterates over time.
- Responds to external actions.

### What is the Bonsai training engine?

The following table describes the four training-engine components in Bonsai:

| Component  | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| Architect  | Generates learning models based on the training curriculum.  |
| Instructor | Coordinates training for a Learner based on curriculum and training data that the simulation provides. |
| Learner    | Gains experience at solving the problem based on direction that an Instructor provides. |
| Predictor  | Reports how the trained Learner behaves when presented with new data. The Predictor represents the trained brain that will be exported. |

:::image type="content" source="../media/training-engine.png" alt-text="Simulator flows into circular graph. Outgoing arrow indicates an exported brain. The training engine section is highlighted.":::

### What is the Bonsai training curriculum?

*Goals* and *objectives* comprise the training curriculum. They allow you to use your subject-matter expertise to break complex problems into key objectives that the AI can learn.

Goals are a high-level specification of what you want the system to learn. They encapsulate your intentions for the AI. But you don't have to craft explicit reward functions or early termination definitions. Objectives are directives such as "avoid" and "minimize" that the training engine uses to direct and judge how well the AI is learning.

:::image type="content" source="../media/training-curriculum.png" alt-text="Simulator flows into circular graph. Outgoing arrow indicates an exported brain. The training curriculum section is highlighted.":::

Bonsai uses a proprietary language called Inkling to encode goals and objectives. Inkling code defines what (and how) you want to teach your AI. An expression in Inkling code is any syntactic entity that can be evaluated to
determine its value. These entities can include comments, identifies, keywords, literals, and operators.

### What are Bonsai brains?

A Bonsai brain is an AI model that's learning on the Bonsai platform. The training engine guides brains as they learn the provided curriculum. You can save new brain versions and revisit previous versions as you develop your curriculum. The final, trained brain that you export can control and optimize your real-world systems.

When you make significant changes to your training curriculum, Bonsai creates a new version of your brain. You can then compare your new brain with previous versions in the following areas:

- Training results.
- Inkling code.
- The predictions of your latest version.

When you're happy with the brain, you can export any version of it for use outside the platform.

:::image type="content" source="../media/brains.png" alt-text="Simulator flows into circular graph. Outgoing arrow indicates an exported brain. The Trained AI, or brain section is highlighted.":::

## How to use Bonsai to deliver AI-powered automation

The Bonsai platform helps simplify machine teaching so you can train and deploy smarter autonomous systems. Bonsai enables you to:

- Integrate training simulations that implement real-world problems.
- Provide realistic feedback during training.
- Train adaptive brains with:

  - Intuitive goals and learning objectives.
  - Real-time success assessments.
  - Automatic versioning control.

- Export the optimized brain and deploy it:

  - In the cloud.
  - At the edge.
  - On-premises.

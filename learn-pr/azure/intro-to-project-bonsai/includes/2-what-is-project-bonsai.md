Microsoft Project Bonsai is a low-code AI platform that works with machine
teaching simulations built on simulation software you may already use.
By understanding what Bonsai is, and what it can do, you can better determine
whether it might benefit your organization.

## What is low-code AI-powered automation?

Low-code AI solutions let Engineers and Data Scientists with varying levels of
development experience successfully build AI-powered control systems. Low-code
solutions typically use visual development environments in addition to a more
traditional coding environment. Visual editors let developers focus on creating
the right solution rather than focusing on the tools used to create the
solution.

## Project Bonsai definition

With Bonsai, your developers can codify what the AI should learn using human-friendly statements like “avoid” and “maximize”. They don't need to explicitly define reward and terminal functions. 

Bonsai includes integrated simulation software support. This software integrates with common simulation software, which means that your developers can build Machine Teaching simulations using familiar software. 

AI training with Bonsai consists of the following components which work together: 

- Training simulation
- Training engine
- Training curriculum
- Brains

### What is a training simulation?

With Bonsai, you can use training simulations to replicate your real-world systems to create a realistic training context for Bonsai brains. Add simulations from a range of Bonsai simulation partners or use the Simulator API to integrate custom simulators.

:::image type="content" source="../media/training-simulation.png" alt-text="Graphic displays a simulator icon flowing into a circular graph that connects the training engine, training curriculum, and integrated simulation. Another arrow flows away from the circular graph to indicate an exported brain. The Training simulator section is highlighted.":::

Training simulations model real-world processes and change state as the Bonsai brain applies actions. Training tasks can be fairly basic, like "stand up", or more challenging, like "learn to dance". 

The following are all domains that use simulations to model the behavior of complex systems:

- Robotics
- Industrial automation
- Supply chain logistics
- Structural engineering

> [!NOTE]
> Bonsai uses simulations and Deep Reinforcement Learning (DRL) to train brains. 

You can use almost any simulation with Bonsai that:

- Has a defined start state.
- Iterates over time.
- Responds to external actions.


### What is the Bonsai training engine?

The training engine in Bonsai has four components. These are described in the following table. 

| Component  | Description                                                  |
| ---------- | ------------------------------------------------------------ |
| Architect  | Generates learning models based on the training curriculum.  |
| Instructor | Coordinates training for the Learner based on the curriculum and training data provided by the simulation. |
| Learner    | Gains experience at solving the problem based on direction provided by the Instructor. |
| Predictor  | Reports how the trained Learner behaves when presented with new data. The Predictor represents the trained brain that will be exported. |

:::image type="content" source="../media/training-engine.png" alt-text="The same graphic is displayed that highlights the training engine section..":::

### What is the Bonsai training curriculum?

The training curriculum is made up of **goals** and **objectives**. Goals and
objectives let you use your subject matter expertise to break complex problems
into key objectives for the AI to learn. 

Goals are a high-level specification of what you want the system to
learn. They encapsulate your intentions for the AI without having to craft
explicit reward functions or early termination definitions. Objectives are 
directives like "avoid" and "minimize" that the training engine uses to direct
and judge how well the AI is learning. 

:::image type="content" source="../media/training-curriculum.png" alt-text="The same graphic is displayed that highlights the training curriculum section..":::

Bonsai uses a proprietary language called Inkling to encode goals and
objectives. Inkling code defines what (and how) you want to teach your AI. An
expression in Inkling code is any syntactic entity that can be evaluated to
determine its value including comments, identifies, keywords, literals, and
operators.



### What are Bonsai brains?

A Bonsai brain is an AI model in the process of learning on the Bonsai platform.
Brains are guided by the training engine as they learn the provided curriculum.
You can save new brain versions and revisit previous versions as you develop
your curriculum. The final, trained brain that you export has the ability to
control and optimize your real-world systems.

When you make significant changes to your training curriculum, Bonsai creates a new version of your brain. 

You can then compare your new brain with previous versions in the following areas: 

- Training results
- Inkling code
- The predictions of your latest version  

When you're happy with the brain, you can export any version of the brain for use outside the platform.

:::image type="content" source="../media/brains.png" alt-text="The same graphic is displayed that highlights the Trained AI (or brain) section.":::



## How to use Bonsai to deliver AI-powered automation

Using the Bonsai platform helps simplify machine teaching so you can train and deploy smarter autonomous systems. Bonsai enables you to:

- Integrate training simulations that implement real-world problems.
- Provide realistic feedback during training.
- Train adaptive brains with:

   - Intuitive goals and learning objectives
   - Real-time success assessments
   - Automatic versioning control

- Export the optimized brain and deploy it:

   - In the cloud
   - At the edge
   - On-premises

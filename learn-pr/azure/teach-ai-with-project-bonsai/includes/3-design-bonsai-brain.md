In this module, you'll train an AI brain to balance a ball in the center of a plate with Project Bonsai. You'll teach AI to learn how to adjust the plate pitch and roll to balance a ball.

You'll use the following in creating the solution:

- **AI Spec document**: It includes the definition of the concept, environment states, control actions, goals, and simulator configurations for your machine teaching problem.

- **Project Bonsai**: Low-code AI development platform for intelligent control systems.

- **Bonsai workspace**: It's a resource group that is provisioned on Azure to store exported brains and upload the simulators. The workspace links to the Bonsai site where brain training and evaluation happen.

- **Moab sample**: It's a prepackaged sample code for the ball balancing problem provided by Project Bonsai.

- **Visual Authoring**: Included in the Bonsai platform, it allows engineers who don't have developer skills to easily transfer the knowledge of the AI-Spec document into the Bonsai platform. A brain diagram is used to represent the inputs/outputs of the model, as well as any machine teaching strategies introduced as part of the training paradigm.

- **Inkling editor**: The inkling editor represents the code-only version of Visual Authoring. It also allows you to define the problem inputs/outputs and machine teaching strategies such as a lesson or problem decomposition. Inkling is a proprietary machine teaching language that lets you focus on what you want to teach without worrying about the underlying RL training details. To define your training curriculum, you can switch between the Visual Authoring (brain diagram) and the Inkling Editor (brain specification).

- **Bonsai brain**: High-level AI model built by combining techniques in deep reinforcement learning (DRL), simulations, and machine teaching. It can easily be trained, assessed, and exported for industrial deployment.

Here are the general steps to create a Bonsai brain. Implementation of the steps will be explained in the subsequent units.

1. Set up your account for Bonsai
    1. Sign in to Bonsai
    1. Provision of a Bonsai workspace
2. Create a Bonsai brain
    1. Select a Moab sample that will create a new brain and upload its corresponding simulator
    1. Explore the Bonsai UI
    1. Explore Visual Authoring
    1. Translate Moab AI Spec into the Bonsai brain
        1. Define environment states
        1. Define control actions
        1. Define concept
        1. Define goals and simulator configuration

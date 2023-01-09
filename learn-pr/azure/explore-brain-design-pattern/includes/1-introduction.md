There are several reasons why you may need to break down Autonomous AI into modular pieces:

- Modular systems are easier to test and certify.
- Modular systems are easier to maintain. If one module malfunctions or needs to be updated, you don’t have to rework the entire system.
- Different skills and even different decision-making techniques may be required in different scenarios for effective autonomy. 
- Learning systems (both human and AI) learn better when they master individual skills separately. 
- Breaking down a sequence or concepts into smaller lessons enables better teaching.

In this module you’ll learn about three key brain design patterns to design modular intelligent systems for almost any application:

- **The Perception Pattern** uses a Machine Learning model (ML) to perform advance perception (computer vision, auditory classification, prediction, or any other type of classification) and pass the results to a decision-making concept, normally a Deep Reinforcement Learning (DRL) module.

- **The Function Pattern** is used when the control actions of the different modules are functionally independent (in practice it means that you have **independent** control knobs that control different parts of the process). For example, you may control the fingers and wrist on a robotic arm separately from the elbow and shoulder of the robotic arm during the task of staking pieces on a table. Another example is the control of three sections of a factory assembly line. Another example is the control of three different chemical reactors that, although connected sequentially, are functionally independent and are controlled using different knobs.

- **The Strategy Pattern** is used when the control actions of the different modules are the same (in practice it means that the same physical control knobs are used in different scenarios and strategies). For example, if you discover, in an interview with a machine operator, that there are three strategies to operate the machine: strategy one is used during startup; strategy two is used during continuous operation when product demand is high; strategy three is used during continuous operation when product demand is low. You design a brain with four modules: one for each of the three strategies, and a fourth one that decides which strategy should be used at any given time.

We explain these patterns in more detail in the next units.

## Learning objectives

After completing this module, you’ll be able to:

- Design Autonomous AI brains for an industrial application
- Describe the benefits and usage of brain design patterns
- Apply best practices of Machine Teaching to solve industrial business challenges

## Prerequisites

- Basic understanding of Automated Intelligence
- Basic understanding of Autonomous Intelligence
- Basic understanding of Machine Teaching


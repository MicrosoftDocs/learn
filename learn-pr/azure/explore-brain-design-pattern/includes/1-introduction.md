There are several reasons why you may need to break down Autonomous AI into modular pieces:

- Modular systems are easier to test and certify.
- Modular systems are easier to maintain. If one module malfunctions or needs to be updated, then you don't have to rework the entire system.
- Different skills and different decision-making techniques may be required in different scenarios for effective autonomy.
- Learning systems (both human and AI) learn better when they master individual skills separately.
- Breaking down a sequence or concepts into smaller lessons enables better teaching.

In this module you'll learn about three key brain design patterns to design modular intelligent systems for almost any application:

- **The Perception Pattern** uses a Machine Learning (ML) model to perform advanced perception such as computer vision, auditory classification, prediction, or any other type of classification. It passes the results to a decision-making concept, normally a Deep Reinforcement Learning (DRL) module.

- **The Function Pattern** is used when the control actions of the different modules are functionally independent. In practice, it means that you have **independent** control knobs that control different parts of the process. For example:
  - Controlling the fingers and wrist on a robotic arm separately from the elbow and shoulder during the task of stacking pieces on a table.

  - Controlling three sections of a factory assembly line.

  - Controlling three different chemical reactors, connected sequentially, that are functionally independent and controlled using knobs.

- **The Strategy Pattern** is used when the control actions of the different modules are the same. In practice, it means that the same physical control knobs are used in different scenarios and strategies. For example, in an interview with a machine operator you discover there are three strategies to operate the machine:
  - A strategy used during startup.

  - A strategy used during continuous operation when product demand is high.
  
  - A strategy used during continuous operation when product demand is low.

    You design a brain with four modules. One module for each of the three strategies, and a fourth that decides which strategy should be used at any given time.

We explain these patterns in more detail in the next units.

## Learning objectives

After completing this module, you'll be able to:

- Design Autonomous AI brains for an industrial application.
- Describe the benefits and usage of brain design patterns.
- Apply best practices of Machine Teaching to solve industrial business challenges.

## Prerequisites

- Basic understanding of Automated Intelligence
- Basic understanding of Autonomous Intelligence
- Basic understanding of Machine Teaching

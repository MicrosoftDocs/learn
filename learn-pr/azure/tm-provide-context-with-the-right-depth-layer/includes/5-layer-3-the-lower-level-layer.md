The lower-level layer is the last layer, and you should use it whenever you create a kernel-level or critical level system. Data-flow diagrams at this layer contain separate data-flow diagrams detailing each **low-level** system subpart. 

**Goal**: Represent **low-level system subparts** with enough context to help you understand how they work and interact with each other.

Similar to the process layer, data-flow diagrams in the lower-level layer should fit in a single page and contain all processes for their respective system subparts.

> [!IMPORTANT]
> Check with your team to make sure this level of depth is required.

## When to use the lower-level layer

Highly critical systems and kernel-level systems should be threat modeled at this layer. Data-flow diagrams should describe each subprocess in minute detail. Also, it's common to have multiple rounds of security reviews just for one subprocess.

Follow the steps from the previous layers to track each of your diagrams to their respective system parts.

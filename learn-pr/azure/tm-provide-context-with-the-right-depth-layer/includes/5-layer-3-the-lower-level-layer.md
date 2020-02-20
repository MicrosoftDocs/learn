The Lower-Level Layer focuses on data-flow diagrams for each low-level system subpart. The goal is to create data-flow diagrams that explain how each low-level system subpart works and interacts with each other in minute detail.

## When Should I Use This Layer?

Highly critical and kernel-level systems should be threat modeled at this layer. Data-flow diagrams at this level describe each subprocess in minute detail. Also, it's common to have multiple rounds of security reviews just for one subprocess.

Follow the steps from the previous layers to track each diagram to their respective system parts.

## Remember

Similar to the Process Layer, data-flow diagrams in the System Subprocess Layer should fit in a single page and contain all processes for their respective system subparts.

> [!IMPORTANT]
> Check with your team to make sure this level of depth is required.
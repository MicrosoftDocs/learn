The Lower-Level Layer is the last layer and should be used whenever you create a kernel or critical level system.

## What Does This Layer Contain

Data-flow diagrams at this layer contain separate data-flow diagrams detailing each **low-level** system subpart. The goal is to understand how each low-level system subpart works and interacts with each other.

## When Should I Use This Layer?

Highly critical and kernel-level systems should be threat modeled at this layer. Data-flow diagrams at this level describe each subprocess in minute detail. Also, it's common to have multiple rounds of security reviews just for one subprocess.

Follow the steps from the previous layers to track each diagram to their respective system parts.

## Remember

Similar to the Process Layer, data-flow diagrams in the System Subprocess Layer should fit in a single page and contain all processes for their respective system subparts.

> [!IMPORTANT]
> Check with your team to make sure this level of depth is required.
## Introduction

Most of the ThreadX resources use global memory, but each thread must have its own stack for saving the context of its last execution and compiler use. Most C compilers use the stack for making function calls and for temporarily allocating local variables. Where a thread stack is located in memory is up to the application. The stack area is specified during thread creation and can be located anywhere in the target’s address space. Specifying the stack location is an important feature because it allows applications to improve the performance of important threads by placing their stack in high-speed RAM.

How large a stack should be is one of the most frequently asked questions about threads. A thread’s stack area must be large enough to accommodate worst-case function call nesting, local variable allocation, and saving its last execution context.

ThreadX defines the minimum stack size, `TX_MINIMUM_STACK`. A stack of this size supports saving a thread’s context and the minimum amount of function calls and local variable allocation.

For most threads, however, the minimum stack size is too small, and you must ascertain the worst-case size requirement by examining function-call nesting and local variable allocation. It's always better to start with a larger stack area.

After the application has been debugged, it's possible to fine-tune the thread stack sizes if memory is scarce. A favorite trick is to preset all stack areas with an easily identifiable data pattern like (0xEFEF) prior to creating the threads. After the application has been thoroughly tested, the stack areas can be examined to see how much stack was used by finding the area of the stack where the data pattern is still intact.

This image shows a stack preset to 0xEFEF after thorough thread execution:

:::image type="content" alt-text="Diagram that shows a stack preset to 0xEFEF." source="../media/stack-preset.svg" loc-scope="Azure":::

The stack requirements for threads can be large. Therefore, it's important to design the application to have a reasonable number of threads. Furthermore, some care must be taken to avoid excessive stack usage within threads. Recursive algorithms and large local data structures should be avoided. In most cases, an overflowed stack causes thread execution to corrupt memory adjacent (usually before) its stack area. The results are unpredictable, but most often result in an unnatural change in the program counter. This change is often called “jumping into the weeds.” The only way to prevent this problem is to ensure that all thread stacks are large enough.

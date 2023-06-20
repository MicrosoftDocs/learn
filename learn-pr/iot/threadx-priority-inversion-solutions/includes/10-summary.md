## Key points

Priority inversion is a serious problem because it can cause nondeterministic behavior. This behavior can cause your system to crash. Thus, this problem must be avoided.

Priority inheritance and preemption-threshold are solutions to the priority inversion problem. Each solution has its strong points, but preemption-threshold reduces context switches and help guarantee schedulability (per academic research). Preemption-threshold is unique to ThreadX, and it has received considerable acclaim in published research papers.

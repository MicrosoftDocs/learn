Now that we understand the conditions for virtualizing ISAs and the two main classes of CPU virtualization, full virtualization and paravirtualization, we move to discussing emulation as a technique used to implement full virtualization and process VMs. Recall that emulation is the process of allowing the interfaces and functionalities of one system (the source) to be implemented on a system with different interfaces and functionalities (the target). Emulation is the only CPU virtualization mechanism available when the guest and host ISAs are different. If the guest and host ISAs are identical, direct native execution can (possibly) be applied.

Emulation is carried out via either **interpretation** or **binary translation**. With interpretation, source instructions are converted, one instruction at a time, to relevant target instructions. Interpretation is relatively slow because of the one-by-one emulation of instructions and the lack of any optimization <!-- SCG: precluding the interpretation? --> technique (e.g., precluding the interpretation of an already encountered and interpreted instruction). Binary translation optimizes interpretation via converting blocks of source instructions to target instructions and caching generated blocks for repeated use. Typically, blocks of instructions are more amenable to optimizations than single instructions are. Compared to interpretation, binary translation is much faster because of the application of block caching as well as code optimizations over blocks. In the following video, we discuss three major interpretation schemes: **decode and dispatch**, **indirect threaded**, and **direct threaded**.
<br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4pNd8]

As explained in the video, a basic interpreter should read through the source code instruction by instruction, analyze each instruction, and call relevant routines to generate the target code. An interpreter called decode and dispatch applies basic interpretation but results in a number of branch (or jump) instructions, both direct and indirect, which leads to poor execution times. As an optimization for decode and dispatch, an interpreter called indirect threaded attempts to release some of the decode-and-dispatch branches via appending (or threading) a portion of the dispatch code to the end of each interpreter routine. Last, a more advanced interpreter, called direct threaded, improves indirect threaded by attempting to interpret a repeated operation only once. Although the direct-threaded interpreter improves the indirect-threaded and decode-and-dispatch branches, it still suffers from major drawbacks, such as vast memory image and limited portability. In the next video, we discuss binary translation, which essentially targets the limitations of direct-threaded interpretation.
<br>

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4q0en]

As presented in this video, binary translation tries to amortize the fetch and analysis costs caused by the direct-threaded interpreter through: (1) translating a block of source instructions (rather than a single instruction) to a block of target instructions and (2) caching the translated code in an attempt to save interpreting source instructions more than once. The following table compares binary translation, decode-and-dispatch, indirect-threaded, and direct-threaded emulation techniques in terms of four metrics: memory requirements, startup performance, steady-state performance, and code portability. For instance, the decode-and-dispatch interpreter row reads as follows: first, with decode and dispatch, memory requirements remain low because of having only one interpreter routine for each instruction type in the target ISA. Furthermore, decode and dispatch avoids threading the dispatch code at the end of each routine. Second, startup performance is fast because neither predecoding nor translation of the source binary is applied. Third, steady-state performance (i.e., the performance after starting up the interpreter) is slow because of the high number of branches and the interpretation of every instruction for each appearance. Finally, code portability is good because predecoding with addresses of interpreter routines is not applied by decode-and-dispatch interpreters (in contrast to direct-threaded interpreters). 

||Memory requirements|Startup performance|Steady-state performance|Code portability|
|--|--|--|--|--|
|Decode-and-dispatch interpreter|Low|Fast|Slow|Good|
|Indirect-threaded interpreter|Low|Fast|Slow|Good|
|Direct-threaded interpreter|High|Slow|Medium|Medium|
|Binary translation|High|Very slow|Fast|Poor|


<!-- Code block question 1 in YAML is built from the following code block.
     Code fence set to "java" to get coloring shown in original course.

   1 - Remove comments from around code block.
   2 - Look at code block in Preview mode.
   3 - Screen capture code block as an image. 
   4 - Code block saved as "quiz-code-1.png" in media folder.
  
```java
While (!halt && !interrupt)
{ 
    inst = code[PC];
    opcode = extract(inst, 31, 6); 
    
    switch (opcode) 
        { 
            case LoadWordAndZero: LoadWordAndZeroRoutine(inst); 
            case ALU: ALURoutine(inst)
            case Branch: BranchRoutine(inst)
            ...
        }
}

LoadWordAndZeroRoutine(inst)
{ 
    RT = extract(inst, 25, 5);
    RA = extract(inst, 20, 5);
    displacement = extract(inst, 15, 16);
    
    if (RA == 0)
        Source = 0;
    else
        Source = reys[RA]; 
        
    address = source + displacement;
    reys[RT] = (data[address] << 32) >> 32;
    PC = PC + 4;
}
```
-->

<!-- Code block question 2 in YAML is built from the following code block.
     Code fence set to "java" to get coloring shown in original course.

   1 - Remove comments from around code block.
   2 - Look at code block in Preview mode.
   3 - Screen capture code block as an image. 
   4 - Code block saved as "quiz-code-2.png" in media folder.
  
```java
inst = code[PC];
opcode = extract(inst, 31, 6); 

switch(opcode)
    {
        case LoadWordAndZero: LoadWordAndZeroRoutine(inst);
        case ALU: ALURoutine(inst)
        case Branch: BranchRoutine(inst) 
        ...
    }

LoadWordAndZeroRoutine(inst)
{
    RT = extract(inst, 25, 5);
    RA = extract(inst, 20, 5);
    Displacement = extract(inst, 15, 16); 
    
    if (RA == 0)
        Source = 0;
    else
        Source = reys[RA];
    address = source + displacement;
    reys[RT] = (data[address] << 32) >> 32;
    PC = PC + 4;
    
    if (halt || interrupt)
        goto emit;
        
    inst = code[PC];
    opcode = extract(inst, 31, 6);
    extended_opcode = extract(inst, 10, 10);
    routine = displacement[opcode, extended_opcode]; 
    
    goto *routine 
}
...

```
-->



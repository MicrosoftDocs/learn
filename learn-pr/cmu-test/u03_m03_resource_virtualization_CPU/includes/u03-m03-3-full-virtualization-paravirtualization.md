<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u03_virtualizing_resources_for_cloud\_u03_m03_resource_virtualization_CPU\x-oli-workbook_page\_u03_m03_3_full_virtualization_paravirtualization.xml -->
##  Full Virtualization and Paravirtualization

A problem arises when an instruction that is both sensitive and unprivileged is issued by a process running on a VM in user mode. According to Popek and Goldberg (1974), sensitive instructions have to trap to the hypervisor if executed in user mode. However, as explained earlier, sensitive instructions can be privileged (e.g., LPSW) and unprivileged (e.g., POPF). Unprivileged instructions do not trap to the hypervisor. Instructions that are sensitive and unprivileged are called critical (see Fig. 3.21). ISAs that contain critical instructions do not satisfy Popek and Goldberg's theorem. Video 3.6 covers this concept and ways around it:
> [!VIDEO https://youtube.com/embed/ay0ZpkMbw_8]

_Video 3.6: ISA virtualization techniques._


The challenge is constructing a hypervisor in the presence of critical instructions. It can be done, but Smith and Nair distinguish between a hypervisor that complies with Popek and Goldberg's theorem and one that does not comply by referring to the former as a _true_ or an _efficient_ hypervisor and to the latter simply as a hypervisor.
![Figure 3.21: Instructions that do not satisfy Popek and Goldberg’' theorem. They are called critical instructions.](../media/critical_instruction.png)

_Figure 3.21: Instructions that do not satisfy Popek and Goldberg’' theorem. They are called critical instructions._


If a processor does not satisfy Popek and Goldberg's virtualization requirement, a hypervisor can be constructed by using _code patching_, _full virtualization_, and/or _paravirtualization_. As illustrated in Figure 3.22, code patching requires the hypervisor to scan the guest code before execution, discover all critical instructions, and replace them with traps (system calls) to the hypervisor. Full virtualization emulates all instructions in the ISA. Emulation degrades performance because it reproduces the behavior of every source instruction by first translating it to a target instruction, then running it on a target ISA (more on emulation shortly). Paravirtualization deals with critical instructions by modifying guest OSs. Specifically, it entails rewriting every critical instruction as a hypercall that traps to the Xen hypervisor. Accordingly, paravirtualization improves performance by avoiding emulation at the expense of modifying the guest OS. In reverse, full virtualization avoids modifying guest OSs at the expense of degrading system performance. As examples, VMware uses full virtualization, while Xen employs paravirtualization. Xen supports most major OSs, including Windows, Linux, Solaris, and NetBSD.
![Figure 3.22: Code scanning and patching to enforce critical instructions to trap to the hypervisor. The code is shown in a format close to a control flow diagram.](../media/critical_instructions_trap_hypervisor.png)

_Figure 3.22: Code scanning and patching to enforce critical instructions to trap to the hypervisor. The code is shown in a format close to a control flow diagram._

`../webcontent/didIGetThis.xml` `../webcontent/didIGetThis2.xml`
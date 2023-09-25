Azure Quantum offers a variety of quantum solutions. At this time, because of the early development stage of the field, these devices have some limitations and requirements for programs that run on them. The Quantum Development Kit and Azure Quantum keep track of these requirements in the background so that you can run your Q# programs on Azure Quantum targets.

## Target profiles

Quantum devices are still an emerging technology, and not all of them can run every Q# program. As such, you need to keep some restrictions in mind when you develop programs for different targets. Currently, we classify targets as having one of three profiles:

- **Full**: This profile can run any Q# program within the limits of memory for simulators or the number of qubits for physical quantum computers.
- **No Control Flow**: This profile can run any Q# program that doesn't require the use of the results from qubit measurements to control the program flow. Within a Q# program targeted for this kind of QPU, values of type `Result` don't support equality comparison.
- **Basic Measurement Feedback**: This profile has limited ability to use the results from qubit measurements to control the program flow. Within a Q# program targeted for this kind of QPU, you can only compare values of type `Result` as part of conditions within `if` statements in operations. The corresponding conditional blocks might not contain `return` or `set` statements.

For example, this operation can't be run on a No Control Flow target:

:::code language="qsharp" source="../code/4-program-1.qs":::

If you try to run this operation on a No Control Flow target (like `ionq.qpu`), it will fail because it evaluates a comparison between two results, `desired != M(q)`, to control the computation flow with an `if` statement. However, this statement can be used in a Basic Measurement Feedback target as long as you don't include any `return` or `set` statement within the `if` block.

For example, the preceding operation could be used in a Basic Measurement Feedback target, but the following operation can't:

:::code language="qsharp" source="../code/4-program-2.qs":::

In the next unit, you'll run Grover's algorithm in a No Control Flow target.

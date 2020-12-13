Azure Quantum offers a variety of quantum solutions. At this time, due to the
early development of the field, these devices have some limitations and
requirements for programs that run on them. The Quantum Development Kit (QDK)
and the Azure Quantum service take care of these requirements in the background
so that your Q# code can run seamlessly on all of the Azure Quantum targets.

Quantum devices, however, are still an emerging technology, and not all of them
can run every Q# program. As such, you need to keep some restrictions in mind
when developing programs for different targets. Currently, we classify targets
as having one of three profiles:

- **Full:** This profile can run any Q# program within the limits of memory for
  simulators or the number of qubits for physical quantum computers.
- **No Control Flow:** This profile can run any Q# program that doesn't require
  the use of the results from qubit measurements to control the program flow.
  Within a Q# program targeted for this kind of QPU, values of type `Result` do
  not support equality comparison.
- **Basic Measurement Feedback:** This profile has limited ability to use the
  results from qubit measurements to control the program flow. Within a Q#
  program targeted for this kind of QPU, you can only compare values of type
  `Result` as part of conditions within `if` statements in operations. The
  corresponding conditional blocks may not contain `return` or `set` statements.

For example, the following code:  

```qsharp

}
```

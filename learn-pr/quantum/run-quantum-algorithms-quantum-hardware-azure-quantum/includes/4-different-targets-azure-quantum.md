Azure Quantum offers a variety of quantum solutions. At this time, due to the
early development of the field, these devices have some limitations and
requirements for programs that run on them. The Quantum Development Kit and
Azure Quantum take care of these requirements in the background so that your Q#
code can run seamlessly on all of the Azure Quantum targets.

## Target profiles

Quantum devices, however, are still an emerging technology, and not all of them
can run every Q# program. As such, you need to keep some restrictions in mind
when developing programs for different targets. Currently, we classify targets
as having one of three profiles:

- **Full (F):** This profile can run any Q# program within the limits of memory for
  simulators or the number of qubits for physical quantum computers.
- **No Control Flow (NCF):** This profile can run any Q# program that doesn't require
  the use of the results from qubit measurements to control the program flow.
  Within a Q# program targeted for this kind of QPU, values of type `Result` do
  not support equality comparison.
- **Basic Measurement Feedback (BMF):** This profile has limited ability to use the
  results from qubit measurements to control the program flow. Within a Q#
  program targeted for this kind of QPU, you can only compare values of type
  `Result` as part of conditions within `if` statements in operations. The
  corresponding conditional blocks may not contain `return` or `set` statements.

For example, this operation cannot be run on a No Control Flow target:

```qsharp
    operation SetQubitState(desired : Result, q : Qubit) : Result {
        if (desired != M(q)) {
            X(q);
        }
    }
```

If you try to run this operation on a NCF target (like `ionq.qpu`) it will fail
because it evaluates a comparison between two results—`desired != M(q)`—to
control the computation flow with an `if` statement. However, this statement can
be used in a BMF target as long as you don't include any `return` or `set`
statement within the `if` block.

For example, the operation above could be used in a BMF target, but de following
cannot:

```qsharp
    operation SetQubitState(desired : Result, q : Qubit) : Result {
        if (desired != M(q)) {
            X(q);
            return M(q);
        }
    }
```

In the next unit you will write different examples of programs that can be run
in a NCF target.
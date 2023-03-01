
Azure Quantum has a resource estimation tool that computes and outputs the resources required for a quantum algorithm, assuming it is executed on a fault-tolerant error-corrected quantum computer. The Azure Quantum Resource Estimator allows you to assess architectural decisions, compare qubit technologies, and determine the resources needed to execute a given quantum algorithm. You can see the total number of physical qubits, wall clock time, the computational resources required, and the details of the formulas and values used for each estimate. 

> [!NOTE]
> To date, available quantum computers aren't fault-tolerant, error-correcting quantum computers. The current state of quantum computers is defined as noisy intermediate-scale quantum computers, or NISQ. The Azure Quantum Resource Estimator assumes execution on a fault-tolerant quantum computer, thus it doesn't work on NISQ machines.

The Azure Quantum Resource Estimator takes a [Quantum Intermediate Representation (QIR)](/azure/quantum/concepts-qir) program as input, so it supports any language that translates to QIR, such as Q# and Qiskit.

## How does the Azure Quantum Resource Estimator work? 

The Azure Quantum Resource Estimator takes a set of three inputs, with pre-defined values to easily get you started: 

- A physical qubit model, `qubitParams`.
- A Quantum Error Correction (QEC) scheme, `qecScheme`.
- An error budget, `errorBudget`.
 
### Physical qubit models 

The parameter `qubitParams` is used to specify qubit parameters. When modeling the physical qubit assumptions, there exist two different physical instruction sets that are used to operate the qubits. The physical instruction set can be either *gate-based* or *Majorana*. A gate-based instruction set provides single-qubit measurement, single-qubit gates (incl. T gates), and two-qubit gates. A Majorana instruction set provides a physical T gate, single-qubit measurement and two-qubit joint measurement operations.

You can choose from six pre-defined qubit parameters, four of which have gate-based instruction sets and two with a Majorana instruction set. These pre-defined qubit parameters represent different qubit architectures defined in published research articles, such as ions or superconductors. These qubit models cover a range of operation times and error rates, enabling sufficient exploration of the resource costs needed to enable practical quantum applications.

| Pre-defined qubit parameters | Instruction set | References                                                                                                 |
|------------------------------|-----------------|------------------------------------------------------------------------------------------------------------|
| `\"qubit_gate_ns_e3\"`         | gate-based      | [arXiv:2003.00024](https://arxiv.org/abs/2003.00024), [arXiv:2111.11937](https://arxiv.org/abs/2111.11937) |
| `\"qubit_gate_ns_e4\"`         | gate-based      | [arXiv:2003.00024](https://arxiv.org/abs/2003.00024), [arXiv:2111.11937](https://arxiv.org/abs/2111.11937) |
| `\"qubit_gate_us_e3\"`         | gate-based      | [arXiv:1701.04195](https://arxiv.org/abs/1701.04195)                                                       |
| `\"qubit_gate_us_e4\"`         | gate-based      | [arXiv:1701.04195](https://arxiv.org/abs/1701.04195)                                                       |
| `\"qubit_maj_ns_e4\"`          | Majorana        | [arXiv:1610.05289](https://arxiv.org/abs/1610.05289)                                                       |
| `\"qubit_maj_ns_e6\"`          | Majorana        | [arXiv:1610.05289](https://arxiv.org/abs/1610.05289)                                                       |

Pre-defined qubit parameters can be selected by specifying the `name` field in the `qubitParams`. Pre-defined qubit parameters can also be customized by specifying the name and then updating any of the other values. For example, to decrease the error rate of two-qubit joint measurement in `"qubit_maj_ns_e4"`, write:

```JSON
{
    "qubitParams": {
        "name": "qubit_maj_ns_e4",
        "twoQubitJointMeasurementErrorRate": 1e-5
    }
}
```
For more information, see [Qubit parameters of the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#physical-qubit-parameters).

### Quantum error correction schemes

Quantum Error Correction (QEC) is crucial for any quantum computing platform to achieve truly scalable quantum computation. The set of operations permitted by a particular quantum computing platform are limited by physical constraints and may not match the operations prescribed in the algorithm. Moreover, even if the operations offered by the quantum computer match the operations in the algorithm, the accuracy to which the quantum computer can perform each operation is likely to be limited. Fault-tolerant quantum computation bridges the accuracy gap by encoding many physical qubits into a smaller number of logical qubits. To guarantee accuracy, logical qubits must be always encoded. Operations of the quantum algorithm must be performed on the logical qubits while they are encoded. Each logical operation must both preserve the code structure and carefully limit the spread of errors. 

The error correction code distance (ECC distance) is a parameter that controls the error rate of logical qubits and the number of physical qubits required to encode them. The higher the ECC distance, the better the accuracy, but also the higher the number of physical qubits. The goal is to find the minimum ECC distance that can achieve the required error rate set for a particular application.

The Azure Quantum Resource Estimator provides three pre-defined QEC schemes: two *surface code* protocols for gate-based and Majorana physical instruction sets, and the *floquet code* protocol that can only be used with a Majorana physical instruction set. 


| QEC scheme     | Instruction set | References                                                                                                 |
|----------------|-----------------|------------------------------------------------------------------------------------------------------------|
| `surface_code` | gate-based      | [arXiv:1208.0928](https://arxiv.org/abs/1208.0928), [arXiv:1009.3686](https://arxiv.org/abs/1009.3686)     |
| `surface_code` | Majorana        | [arXiv:1909.03002](https://arxiv.org/abs/1909.03002), [arXiv:2007.00307](https://arxiv.org/abs/2007.00307) |
| `floquet_code` | Majorana        | [arXiv:2202.11829](https://arxiv.org/abs/2202.11829)                                                       |

Pre-defined QEC schemes can be selected by specifying the `name` field in the `qecScheme`. Pre-defined QEC schemes can also be customized by specifying the name and then updating any of the other values. For example, you can update the time to execute a single logical operation, which depends on the code distance and the physical operation time assumptions of the underlying physical qubits. To update `"logicalCycleTime"`, write:

to increase the crossing pre-factor in the floquet code, write:

```JSON
{
    "qecScheme": {
        "name": "floquet_code",
        "logicalCycleTime": "18 * oneQubitMeasurementTime * codeDistance"
    }
}
```

For more information, see [QEC in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#quantum-error-correction-schemes).

### Error budget 

The total error budget sets the overall allowed error for the algorithm, that is, the number of times it is allowed to fail. Its value must be between 0 and 1 and the default value is 0.001, which corresponds to 0.1%, and means that the algorithm is allowed to fail once in 1000 executions. This parameter is highly application specific. For example, if one is running Shor’s algorithm for factoring integers, a large value for the error budget may be tolerated as one can check that the output are indeed the prime factors of the input. On the other hand, a smaller error budget may be needed for an algorithm solving a problem with a solution, which cannot be efficiently verified. 

For more information, see [Error budget in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#error-budget).

## What is the result of a resource estimation job?

The Azure Quantum Resource Estimator takes the optional job parameters `{qubitParams, qecScheme, errorBudget}` and a QIR algorithm, and computes pre- and post-layout estimation of the logical resources required to run such an algorithm in such a computational scenario. 


The Resource Estimator computes logical and physical estimation of the algorithm. It calculates the QEC code distance, and from it, the number of physical qubits needed to encode one logical qubit. It calculates the number of logical qubits, T gates, rotation gates, control gates, measurements, T factory physical values, and total runtime, among others. 

The result of the resource estimation job is printed in groups of [output data](/azure/quantum/overview-resources-estimator#output-data): physical qubits, breakdown, logical qubit parameters, T factory parameters, pre-layout logical resources, and assumed error budget.


In the next part, you'll learn the basics to work with the Azure Quantum Resource Estimator and you'll submit a simple job.

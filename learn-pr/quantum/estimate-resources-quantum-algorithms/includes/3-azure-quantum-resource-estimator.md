
The Azure Quantum Resource Estimator in the Azure Quantum service is a resource-estimation tool that computes and displays the resources that are required for a quantum algorithm, assuming that it's executed on a fault-tolerant, error-corrected quantum computer. 

You can use the estimator to assess architectural decisions, compare qubit technologies, and determine the resources you need to execute a specific quantum algorithm. You can see the total number of physical qubits, wall clock time, the required computational resources, and the details of the formulas and values used for each estimate.

## How does the Azure Quantum Resource Estimator work?

The Azure Quantum Resource Estimator takes some inputs that are called *target parameters*, which have predefined values, to easily get you started. The main target parameters are:

- `qubitParams`: A physical qubit model.
- `qecScheme`: A QEC scheme.
- `errorBudget`: An error budget.

The Resource Estimator also takes some optional parameters:

- `constraints`: The constraints on the component-level.
- `distillationUnitSpecifications`: To specify T factories distillation algorithms.

### Physical qubit models

You can choose from six predefined qubit parameters. Four of the parameters have *gate-based* instruction sets, and two parameters have *Majorana* instruction sets. These predefined qubit parameters represent different qubit architectures like ions or superconductors, which are defined in published research articles. The qubit models cover a range of operation times and error rates, so you can use them to explore the required resource costs for practical quantum applications.

| Predefined qubit parameters | Instruction set type |
|------------------------------|-----------------|
| `"qubit_gate_ns_e3"`         | gate-based      |
| `"qubit_gate_ns_e4"`         | gate-based      |
| `"qubit_gate_us_e3"`         | gate-based      |
| `"qubit_gate_us_e4"`         | gate-based      |
| `"qubit_maj_ns_e4"`          | Majorana        |
| `"qubit_maj_ns_e6"`          | Majorana        |

For more information, see [Qubit parameters of the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#physical-qubit-parameters).

### QEC schemes

Quantum error correction (QEC) is crucial for any quantum-computing platform to achieve truly scalable quantum computation. The set of operations a quantum computing platform permits is limited by physical constraints and might not match the operations prescribed in the algorithm. Even if the operations that the quantum computer offers match the operations in the algorithm, the accuracy to which the quantum computer can perform each operation is likely to be limited.

The Azure Quantum Resource Estimator provides three predefined QEC schemes: two *surface code* protocols for gate-based and Majorana physical instruction sets, and the *Floquet code* protocol, which can be used only with a Majorana physical instruction set.

| QEC scheme     | Instruction set type |
|----------------|-----------------|
| `surface_code` | gate-based and Majorana   |
| `floquet_code` | Majorana        |

For more information, see [Quantum error correction schemes in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#quantum-error-correction-schemes).

### Error budget

The total error budget sets the overall allowed error for the algorithm. The allowed error is the number of times the algorithm is allowed to fail. The value of the error budget must be between 0 and 1, and the default value is 0.001. The default value corresponds to 0.1 percent, and means that the algorithm is allowed to fail once in 1,000 executions. This parameter is highly specific to the application. For example, if you're running Shor’s algorithm for factoring integers, a large value for the error budget can be tolerated because you can check that the output is indeed the prime factors of the input. On the other hand, a smaller error budget might be needed for an algorithm solving a problem with a solution that can't be efficiently verified.

For more information, see [Error budget in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#error-budget).

## What is the result of the Azure Quantum Resource Estimator?

The Azure Quantum Resource Estimator takes the target parameters `{qubitParams, qecScheme, errorBudget}` and your quantum algorithm. It computes a pre-layout and post-layout estimation of the logical resources required to run this type of algorithm in this type of computational scenario.

The resource estimator computes the logical and physical estimation of the algorithm. It calculates the QEC code distance, and from this value, the number of physical qubits needed to encode one logical qubit. It calculates the number of logical qubits, T gates, rotation gates, control gates, measurements, T factory physical values, and total runtime, among other values.

The result of the resource-estimation job is printed in groups: physical qubits, breakdown, logical qubit parameters, T factory parameters, pre-layout logical resources, and assumed error budget.

You can also inspect the distribution of physical qubits used for the algorithm and the T factories using the space-time diagrams. The space diagram shows the proportion of these two. Note that the number of T factory copies contributes to the number of physical qubits for T factories.

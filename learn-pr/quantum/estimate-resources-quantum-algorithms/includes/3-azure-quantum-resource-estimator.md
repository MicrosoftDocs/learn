
The Azure Quantum Resource Estimator is a resource-estimation tool that computes and displays the resources that are required to run a quantum algorithm. The Resource Estimator assumes that the algorithm is run on a fault-tolerant, large-scale quantum computer.

You can use the Resource Estimator to assess architectural decisions, compare qubit technologies, and determine the resources that you need to execute a specific quantum algorithm. You can see the total number of physical qubits, runtime, the required computational resources, and the details of the formulas and values used for each estimate.

In this unit, you learn how to customize the Azure Quantum Resource Estimator by setting different parameters.

## How does the Azure Quantum Resource Estimator work?

The Azure Quantum Resource Estimator takes some target parameters as inputs. The target parameters have predefined values to easily get you started, or you can customize their values to modify the output. The following table describes the main target parameters:

| Target parameter                       | Description                                                           |
|----------------------------------------|-----------------------------------------------------------------------|
| Physical qubit parameters              | The type of physical qubit and qubit architecture                     |
| Quantum error correction (QEC) scheme  | The type of error correction that you apply to your quantum algorithm |
| Error budget                           | The maximum acceptable error rate for your quantum calculations       |

### Choose the physical qubit model

The Azure Quantum Resource Estimator has six predefined qubit models. Four of the models have gate-based instruction sets, and the other two models have Majorana instruction sets. These predefined qubit models represent different qubit architectures like ions or superconductors. The qubit models cover a range of operation times and error rates, so you can use them to explore the required resource costs for practical quantum applications.

| Predefined qubit models | Instruction set type |
|-------------------------|----------------------|
| `"qubit_gate_ns_e3"`    | Gate-based           |
| `"qubit_gate_ns_e4"`    | Gate-based           |
| `"qubit_gate_us_e3"`    | Gate-based           |
| `"qubit_gate_us_e4"`    | Gate-based           |
| `"qubit_maj_ns_e4"`     | Majorana             |
| `"qubit_maj_ns_e6"`     | Majorana             |

For more information, see [Physical Qubit parameters of the Resource Estimator](/azure/quantum/overview-resources-estimator#physical-qubit-parameters).

### Choose the QEC scheme

Quantum error correction (QEC) is crucial for any quantum computing platform to achieve truly scalable quantum computation. The set of operations that a quantum computing platform permits is limited by physical constraints and might not exactly match the operations prescribed in the algorithm. Even if the operations that the quantum computer offers match the operations in the algorithm, the accuracy to which the quantum computer can perform each operation is likely to be limited.

The Azure Quantum Resource Estimator provides three predefined QEC schemes: two surface code protocols for gate-based and Majorana physical instruction sets, and one Floquet code protocol, which can be used only with a Majorana physical instruction set.

| QEC scheme     | Instruction set type    |
|----------------|-------------------------|
| `surface_code` | Gate-based and Majorana |
| `floquet_code` | Majorana                |

For more information, see [Quantum error correction schemes in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#quantum-error-correction-schemes).

### Choose the error budget

The total error budget sets the overall allowed error for the algorithm. The allowed error is the proportion of times that the algorithm is allowed to fail. The value of the error budget must be between 0 and 1, and the default value is 0.001. The default value corresponds to 0.1 percent, and means that the algorithm is allowed to fail once per 1,000 runs.

The error budget is highly specific to the application. For example, if you're running Shor's algorithm to factor integers, you can tolerate a large value for the error because, at the end of the algorithm, you can easily check that the output is indeed the prime factors of the input. On the other hand, you might need a smaller error budget for an algorithm that solves a problem with a solution that you can't efficiently verify.

For more information, see [Error budget in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#error-budget).

In the next unit, you learn how to use the Azure Quantum Resource Estimator to estimate the resources required to run Shor's algorithm.

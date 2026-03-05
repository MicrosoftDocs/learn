
The Microsoft Quantum resource estimator is a resource-estimation tool that computes and displays the resources that are required to run a quantum algorithm. The resource estimator assumes that the algorithm is run on a fault-tolerant, large-scale quantum computer.

You can use the resource estimator to assess architectural decisions, compare qubit technologies, and determine the resource requirements for specific hardware. Information from the resource estimator includes the total number of physical qubits, the algorithm runtime, and the required computational resources. The resource estimator also explains the formulas and values that are used to calculate each estimate.

In this unit, you learn how to customize the resource estimator with different parameters settings.

## How does the Microsoft Quantum resource estimator work?

The resource estimator takes various target parameters as input. The target parameters have predefined values to easily get you started, or you can customize their values to modify the output. The following table describes the main three target parameters:

| Target parameter                       | Description                                                           |
|----------------------------------------|-----------------------------------------------------------------------|
| Physical qubit information             | The type of physical qubit and qubit architecture                     |
| Quantum error correction (QEC) scheme  | The type of error correction that you apply to your quantum algorithm |
| Error budget                           | The maximum acceptable error rate for your quantum calculations       |

### Choose the physical qubit model

The resource estimator has six predefined qubit models. Four of the models have gate-based instruction sets, and the other two models have Majorana instruction sets. These predefined qubit models represent different qubit architectures, like ions or superconductors. The qubit models cover a range of operation times and error rates, so you can compare them to explore the resource requirements for practical quantum applications.

| Predefined qubit models | Instruction set type |
|-------------------------|----------------------|
| `qubit_gate_ns_e3`      | Gate-based           |
| `qubit_gate_ns_e4`      | Gate-based           |
| `qubit_gate_us_e3`      | Gate-based           |
| `qubit_gate_us_e4`      | Gate-based           |
| `qubit_maj_ns_e4`       | Majorana             |
| `qubit_maj_ns_e6`       | Majorana             |

For more information about physical qubit parameters, see [Physical Qubit parameters of the resource estimator](/azure/quantum/overview-resources-estimator#physical-qubit-parameters).

### Choose the QEC scheme

Quantum error correction (QEC) is crucial for a quantum computing platform to achieve truly scalable quantum computation. The set of operations that a quantum computing platform permits is limited by physical constraints and might not exactly match the operations that you prescribe in the algorithm. Even if the operations that the quantum computer permits match the operations in the algorithm, the quantum computer isn't completely accurate for every operation. The QEC scheme corrects for these inaccurate operations.

The resource estimator provides two predefined QEC schemes: a surface code protocol and a Floquet code protocol. The surface code protocol applies to gate-based and Majorana physical instruction sets. The Floquet code protocol applies only to Majorana physical instruction sets.

| QEC scheme     | Instruction set type    |
|----------------|-------------------------|
| `surface_code` | Gate-based and Majorana |
| `floquet_code` | Majorana                |

For more information about QEC schemes, see [Quantum error correction schemes in the Microsoft Quantum resource estimator](/azure/quantum/overview-resources-estimator#quantum-error-correction-schemes).

### Choose the error budget

The total error budget sets the overall allowed error for the algorithm. The allowed error is the proportion of times that the algorithm is allowed to fail. The value of the error budget must be between 0 and 1, and the default value is 0.001. The default value corresponds to 0.1%, which means that the algorithm is allowed to fail once per 1,000 runs.

The error budget is highly specific to the application. For example, if you're running Shor's algorithm to factor integers, you can tolerate a large value for the error because you can easily check whether the output numbers are the prime factors of the input number at the end of the algorithm. On the other hand, you might need a smaller error budget for an algorithm that solves a problem with a solution that you can't efficiently verify.

For more information about error budgets, see [Error budget in the Microsoft Quantum resource estimator](/azure/quantum/overview-resources-estimator#error-budget).

In the next unit, you use the resource estimator to estimate the resources required to run Shor's algorithm.

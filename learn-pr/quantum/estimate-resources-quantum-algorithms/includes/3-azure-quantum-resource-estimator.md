
The Azure Quantum Resource Estimator in the Azure Quantum service is a resource estimation tool that computes and then displays the resources that are required for a quantum algorithm, assuming that it's executed on a fault-tolerant, error-corrected quantum computer. You can use the estimator to assess architectural decisions, compare qubit technologies, and determine the resources that you need to execute a specific quantum algorithm. You can see the total number of physical qubits, wall clock time, the computational resources that are required, and the details of the formulas and values that are used for each estimate. 

> [!NOTE]
> Currently, the quantum computers that are available aren't fault-tolerant, error-correcting quantum computers. Currently, quantum computers are defined as *noisy intermediate-scale quantum* (NISQ) computers. The Azure Quantum Resource Estimator assumes execution on a fault-tolerant quantum computer, so you can't use the estimator for NISQ computers.

The Azure Quantum Resource Estimator takes a [quantum intermediate representation (QIR)](/azure/quantum/concepts-qir) program as input. It supports any language that translates to QIR, such as Q# and Qiskit.

## How does the Azure Quantum Resource Estimator work?

The Azure Quantum Resource Estimator takes some inputs that are called *target parameters*, and which have predefined values, to easily get you started:

- `qubitParams`, a physical qubit model.
- `qecScheme`, a QEC scheme.
- `errorBudget`, an error budget.
- `constraints` - the constraints on the component-level

### Physical qubit models

The `qubitParams` parameter sets qubit parameters. When physical qubit assumptions are modeled, two physical instruction sets are used to operate the qubits. The physical instruction set can be either *gate-based* or *Majorana*. A gate-based instruction set provides single-qubit measurement, single-qubit gates (including *T gates*), and two-qubit gates. A Majorana instruction set provides a physical T gate, single-qubit measurement, and two-qubit joint measurement operations.

You can choose from six predefined qubit parameters. Four of the parameters have gate-based instruction sets, and two parameters have Majorana instruction sets. These predefined qubit parameters represent different qubit architectures like ions or superconductors, which are defined in published research articles. The qubit models cover a range of operation times and error rates, so you can use them to explore the resource costs that are required for practical quantum applications.

| Predefined qubit parameters | Instruction set type | References                                                                                                 |
|------------------------------|-----------------|------------------------------------------------------------------------------------------------------------|
| `"qubit_gate_ns_e3"`         | gate-based      | [arXiv:2003.00024](https://arxiv.org/abs/2003.00024), [arXiv:2111.11937](https://arxiv.org/abs/2111.11937) |
| `"qubit_gate_ns_e4"`         | gate-based      | [arXiv:2003.00024](https://arxiv.org/abs/2003.00024), [arXiv:2111.11937](https://arxiv.org/abs/2111.11937) |
| `"qubit_gate_us_e3"`         | gate-based      | [arXiv:1701.04195](https://arxiv.org/abs/1701.04195)                                                       |
| `"qubit_gate_us_e4"`         | gate-based      | [arXiv:1701.04195](https://arxiv.org/abs/1701.04195)                                                       |
| `"qubit_maj_ns_e4"`          | Majorana        | [arXiv:1610.05289](https://arxiv.org/abs/1610.05289)                                                       |
| `"qubit_maj_ns_e6"`          | Majorana        | [arXiv:1610.05289](https://arxiv.org/abs/1610.05289)                                                       |

You can select predefined qubit parameters by specifying the `name` field in the `qubitParams` parameter. You also can customize predefined qubit parameters by specifying the name, and then updating any of the other values.

For example, to decrease the error rate of two-qubit joint measurement in `"qubit_maj_ns_e4"`, use this code:

```json
{
    "qubitParams": {
        "name": "qubit_maj_ns_e4",
        "twoQubitJointMeasurementErrorRate": 1e-5
    }
}
```

For more information, see [Qubit parameters of the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#physical-qubit-parameters).

### QEC schemes

Quantum error correction (QEC) is crucial for any quantum computing platform to achieve truly scalable quantum computation. The set of operations that are permitted by a quantum computing platform are limited by physical constraints and might not match the operations that are prescribed in the algorithm. Even if the operations that the quantum computer offers match the operations in the algorithm, the accuracy to which the quantum computer can perform each operation is likely to be limited.

Fault-tolerant quantum computation bridges the accuracy gap by encoding many physical qubits into a smaller number of logical qubits. To guarantee accuracy, logical qubits must always be encoded. The operations of the quantum algorithm must be performed on the logical qubits while they're encoded. Each logical operation must both preserve the code structure and carefully limit the spread of errors.

The error correction code (ECC) distance is a parameter that controls the error rate of logical qubits and the number of physical qubits that are required to encode them. The higher the ECC distance, the more accurate the computation will be. But the number of physical qubits that are required will be higher also. The goal is to find the minimum ECC distance that can achieve the required error rate that you set for a specific application.

The Azure Quantum Resource Estimator provides three predefined QEC schemes: two *surface code* protocols for gate-based and Majorana physical instruction sets, and the *Floquet code* protocol, which can be used only with a Majorana physical instruction set.

| QEC scheme     | Instruction set type | References                                                                                                 |
|----------------|-----------------|------------------------------------------------------------------------------------------------------------|
| `surface_code` | gate-based      | [arXiv:1208.0928](https://arxiv.org/abs/1208.0928), [arXiv:1009.3686](https://arxiv.org/abs/1009.3686)     |
| `surface_code` | Majorana        | [arXiv:1909.03002](https://arxiv.org/abs/1909.03002), [arXiv:2007.00307](https://arxiv.org/abs/2007.00307) |
| `floquet_code` | Majorana        | [arXiv:2202.11829](https://arxiv.org/abs/2202.11829)                                                       |

You can select a predefined QEC scheme by specifying the `name` field in the `qecScheme` parameter. You also can customize predefined QEC schemes by specifying the name, and then updating any of the other values. For example, you can update the time to execute a single logical operation, which depends on the code distance and the physical operation time assumptions of the underlying physical qubits. To update `"logicalCycleTime"`, use this code:

```json
{
    "qecScheme": {
        "name": "floquet_code",
        "logicalCycleTime": "18 * oneQubitMeasurementTime * codeDistance"
    }
}
```

For more information, see [QEC in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#quantum-error-correction-schemes).

### Error budget

The total error budget sets the overall allowed error for the algorithm. The allowed error is the number of times the algorithm is allowed to fail. The value of the error budget must be between 0 and 1, and the default value is 0.001. The default value corresponds to 0.1 percent and means that the algorithm is allowed to fail once in 1,000 executions. This parameter is highly specific to the application. For example, if you're running Shor’s algorithm for factoring integers, a large value for the error budget can be tolerated because you can check that the output is indeed the prime factors of the input. On the other hand, a smaller error budget might be needed for an algorithm that solves a problem that has a solution that can't be efficiently verified.

The error budget $\epsilon$ corresponds to the sum of three parts:

$$ \epsilon = \epsilon_{\log} + \epsilon_{\rm dis} + \epsilon_{\rm syn} $$

```JSON
{
    "errorBudget": {
        "logical": <double>, // Required
        "tStates": <double>, // Optional
        "rotations": <double> // Optional
    }
}

For more information, see [Error budget in the Azure Quantum Resource Estimator](/azure/quantum/overview-resources-estimator#error-budget).

### Constraints

You can use `constraints` parameters to apply constraints on the component-level. By adjusting constraints, you can optimize the estimates toward reducing the number of qubits or toward reducing the runtime. 

```JSON
{
    "constraints": {
        "logicalDepthFactor": <double>, // controll execution time 
        "maxTFactories": <int> // control number of qubits
    }
}
```

## What is the result of a resource estimation job?

The Azure Quantum Resource Estimator takes the target parameters `{qubitParams, qecScheme, errorBudget, constraints}` and your quantum algorithm. It computes a pre-layout and post-layout estimation of the logical resources that are required to run this type of algorithm in this type of computational scenario.

The resource estimator computes the logical and physical estimation of the algorithm. It calculates the QEC code distance, and from this value, the number of physical qubits needed to encode one logical qubit. It calculates the number of logical qubits, T gates, rotation gates, control gates, measurements, T factory physical values, and total runtime, among other values.

The result of the resource estimation job is printed in groups of [output data](/azure/quantum/overview-resources-estimator#output-data): physical qubits, breakdown, logical qubit parameters, T factory parameters, pre-layout logical resources, and assumed error budget.

Next, learn the basics of working with the Azure Quantum Resource Estimator, and submit a basic job.

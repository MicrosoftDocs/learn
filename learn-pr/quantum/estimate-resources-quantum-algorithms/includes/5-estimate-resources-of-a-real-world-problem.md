In [Create your first Q# program by using the Quantum Development Kit](/training/modules/qsharp-create-first-quantum-development-kit/3-random-bit-generator), you learn that classical security protocols don't produce truly random numbers. Instead, classical security protocols produce pseudo random numbers, and a hacker can determine the sequence of random numbers that was used to generate a classical password. To increase your security, your first task as a member of the space fleet was to create secure passwords by using a quantum random number generator. 

But there are other ways to create secure passwords and conceal confidential information. *Cryptography* uses physical or mathematical means, like computational difficulty, to accomplish a task. A popular cryptographic protocol is the [Rivest–Shamir–Adleman (RSA) scheme](https://wikipedia.org/wiki/RSA_(cryptosystem)?azure-portal=true), which is based on the practical difficulty of factoring prime numbers by using a classical computer.

Shor's factoring algorithm studies a quantum algorithm with superquadratic speedup and the cost of error correction. In [Explore the key concepts of quantum computing by using Q#](/training/modules/qsharp-explore-key-concepts-quantum-computing/8-introduction-quantum-algorithms/?azure-portal=true), you can review an overview of Shor's algorithm application in cryptography.

Some of today’s classical cryptographic schemes are based on assumptions of the difficulty of factoring large numbers. Estimating the resources required for Shor’s algorithm is important to assess the vulnerability of these types of cryptographic schemes.

## Estimate the resources with Azure Quantum

In the following exercise, you calculate the resource estimates for the factoring of a 2,048-bit integer. For this application, you compute the physical resource estimates directly from precomputed logical resource estimates. For more information, see [Use known estimates for an operation](/azure/quantum/how-to-work-with-re#use-known-estimates-for-an-operation).For the tolerated error budget, you use $\epsilon = 1/3$.

> [!TIP]
> You can use this example as a blueprint to estimate the physical resources required of any application for which you already have computed logical estimates.

### Get started

In your Azure Quantum workspace, create a new notebook:

1. On the left menu, select **Notebooks**.
1. Select **My Notebooks**, and then select **Add New**.
1. For **Kernel Type**, select **IPython**.
1. Enter a name for the file, for example, *factoringResourceEstimator.ipynb*.
1. Select **Create file**.

First, you need to import some Python classes from `azure.quantum` to create a workspace and the resource estimator target. 

Select **Code** to add a new cell, and then enter and run the following code:

```python
from azure.quantum import Workspace
from azure.quantum.target.microsoft import MicrosoftEstimator, QubitParams, QECScheme
import qsharp
```

To connect to the Azure Quantum workspace, select **Code**, and then enter and run the following code:  

```python
workspace = Workspace (
    resource_id = "",
    location = ""
)
```

### Extract resource estimates from logical resource counts

Then, you create a Q# program that describes the algorithm in terms of precomputed logical resource estimates. If you already know some estimates for an operation, the Resource Estimator allows you to incorporate the known estimates into the overall cost of the program to reduce the execution time. For this end, you use the `AccountForEstimates` Q# operation. 

Select **Code** to add a new cell, and then enter and run the following code:

```python
%%qsharp
open Microsoft.Quantum.ResourceEstimation;

operation FactoringFromLogicalCounts() : Unit {
    use qubits = Qubit[12581];
    
    AccountForEstimates([TCount(12), RotationCount(12), RotationDepth(12), CczCount(3731607428), MeasurementCount(1078154040)], PSSPCLayout(), qubits);
}
```
### Run experiments

As configurations for your experiment, you use all six predefined qubit parameters. As a predefined QEC scheme, use `surface_code` with gate-based qubit parameters and `floquet_code` with Majorana-based qubit parameters. 

So, you have 6 different items of configurations. In the Azure Quantum Resource Estimator, you can submit jobs that have multiple configurations of job parameters, or multiple *items*, as a single job to avoid rerunning multiple jobs on the same quantum program.

To create a batching job with 6 items, you can use the `make_params` function and set `num_items` to 6. The `error_budget` is set globally for all items as 1/3. The names for `qubit_params` and `qec_scheme` are set individually for each item.

Select **Code** to add a new cell, and then enter or paste the following code:

```python
estimator = MicrosoftEstimator(workspace) 

labels = ["Gate-based µs, 10⁻³", "Gate-based µs, 10⁻⁴", "Gate-based ns, 10⁻³", "Gate-based ns, 10⁻⁴", "Majorana ns, 10⁻⁴", "Majorana ns, 10⁻⁶"]

params = estimator.make_params(num_items=6)
params.error_budget = 0.333
params.items[0].qubit_params.name = QubitParams.GATE_US_E3
params.items[1].qubit_params.name = QubitParams.GATE_US_E4
params.items[2].qubit_params.name = QubitParams.GATE_NS_E3
params.items[3].qubit_params.name = QubitParams.GATE_NS_E4
params.items[4].qubit_params.name = QubitParams.MAJ_NS_E4
params.items[4].qec_scheme.name = QECScheme.FLOQUET_CODE
params.items[5].qubit_params.name = QubitParams.MAJ_NS_E6
params.items[5].qec_scheme.name = QECScheme.FLOQUET_CODE
```

Next, you submit the resource estimation job based on the Q# operation `FactoringFromLogicalCounts`. Select **Code** to add a new cell, and then enter and run the following code:

```python
job = estimator.submit(FactoringFromLogicalCounts, input_params=params)
results = job.get_results()
```

### Understand the results

Finally, you present the experimental results in a summary table using the `summary_data_frame` function. Select **Code** to add a new cell, and then enter and run the following code:

```python
results.summary_data_frame(labels=labels)
```

Your output should look similar to this example:

**Summary**

|Qubit model|Logical qubits|	Logical depth|	T states|	Code distance |	T factories	| T factory fraction| Physical qubits |	Physical runtime|
|---|---|---|---|---|---|---|---|---|
|Gate-based µs, 10⁻³|	25481|	1.2e+10|	1.5e+10	|27|	13|	0.6%|	37.38M|	6 years|
|Gate-based µs, 10⁻⁴|	25481|	1.2e+10|	1.5e+10	|13|	14|	0.8%|	8.68M|	3 years|
|Gate-based ns, 10⁻³|	25481| 1.2e+10 | 1.5e+10	|27|	15|	1.3%|	37.65M|	2 days|
|Gate-based ns, 10⁻⁴|	25481|	1.2e+10	|1.5e+10	|13	|18|	1.2%|	8.72M|	18 hours|
|Majorana ns, 10⁻⁴	|   25481|	1.2e+10	|1.5e+10	|15	|15|	1.3%|	26.11M|	15 hours|
|Majorana ns, 10⁻⁶	|   25481|	1.2e+10	|1.5e+10	|7	|13	|0.5%|	6.25M|	7 hours|

In the worst scenario, a hacker who is using gate-based µs qubits (qubits that have operation times in the nanosecond regime, such as superconducting qubits) and a surface QEC code would need six years and 37.38 millions of qubits to factor a 2,048-bit integer by using Shor's algorithm.

If you use a different qubit technology, for example gate-based ns ion qubits and the same surface code, the number of qubits doesn't change much, but the runtime became two days in the worst case and 18 hours in the optimistic case. If you change the qubit technology and the QEC code, for example, by using Majorana-based qubits, factoring a 2,048-bit integer by using Shor’s algorithm could be done in hours with an array of 6.25 millions of qubits in the best case scenario.

From your experiment, you can conclude that using Majorana qubits and a Floquet QEC code is the best choice to execute Shor's algorithm and factor a 2,048-bit integer password. The space fleet should prepare for future quantum hackers!  

In [Create your first Q# program by using the Quantum Development Kit](/training/modules/qsharp-create-first-quantum-development-kit/3-random-bit-generator), you learn that classical security protocols don't produce truly random numbers. Instead, classical security protocols produce pseudo random numbers, and a hacker can determine the sequence of random numbers that was used to generate a classical password. To increase your security, your first task as a member of the space fleet was to create secure passwords by using a quantum random number generator. 

But there are other ways to create secure passwords and conceal confidential information. *Cryptography* uses physical or mathematical means, like computational difficulty, to accomplish a task. A popular cryptographic protocol is the [Rivest–Shamir–Adleman (RSA) scheme](https://wikipedia.org/wiki/RSA_(cryptosystem)?azure-portal=true), which is based on the practical difficulty of factoring prime numbers by using a classical computer.

Shor's factoring algorithm studies a quantum algorithm with superquadratic speedup and the cost of error correction. In [Explore the key concepts of quantum computing by using Q#](/training/modules/qsharp-explore-key-concepts-quantum-computing/8-introduction-quantum-algorithms/?azure-portal=true), you can review an overview of Shor's algorithm application in cryptography.

Some of today’s classical cryptographic schemes are based on assumptions of the difficulty of factoring large numbers. Estimating the resources required for Shor’s algorithm is important to assess the vulnerability of these types of cryptographic schemes.

## Estimate the resources with Azure Quantum

In the following exercise, you calculate the resource estimates for the factoring of a 2,048-bit integer. For the tolerated error budget, you'll use $\epsilon = 1/3$.

### Get started

In your Azure Quantum workspace, create a new notebook:

1. On the left menu, select **Notebooks**.
1. Select **My Notebooks**, and then select **Add New**.
1. For **Kernel Type**, select **IPython**.
1. Enter a name for the file, for example, *factoringResourceEstimator.ipynb*.
1. Select **Create file**.

First, you need to import several Python classes and functions from `azure.quantum` and `qiskit`. You aren't using Qiskit to build quantum circuits, but you'll use `AzureQuantumJob` and `job_monitor`, which are built on top of the Qiskit ecosystem.

Select **Code** to add a new cell, and then enter and run the following code:

```python
from azure.quantum.qiskit import AzureQuantumProvider
from azure.quantum.qiskit.job import AzureQuantumJob

from qiskit.tools.monitor import job_monitor
```

To connect to the Azure Quantum workspace, select **Code**, and then enter and run the following code:  

```python
provider = AzureQuantumProvider (
    resource_id = "",
    location = ""
)
```

### Extract resource estimates from logical resource counts

Next, implement a generic function that takes as input the Azure Quantum provider and the QIR bitcode of the quantum program. The result it returns is an Azure Quantum job. Resource estimation input parameters can be passed via keyword arguments to the function.

Select **Code** to add a new cell, and then enter and run the following code:

```python
from azure.quantum.qiskit import AzureQuantumProvider

def resource_estimation_job_from_qir(provider: AzureQuantumProvider, bitcode: bytes, **kwargs):
    """A generic function to create a resource estimation job from QIR bitcode"""

    # Find the Azure Quantum Resource Estimator target from the provider
    backend = provider.get_backend('microsoft.estimator')

    # You can provide a name for the job via keyword arguments
    # Or use QIR job as a default name
    name = kwargs.pop("name", "QIR job")

    # Extract some job-specific arguments from the back end's configuration
    config = backend.configuration()
    blob_name = config.azure["blob_name"]
    content_type = config.azure["content_type"]
    provider_id = config.azure["provider_id"]
    output_data_format = config.azure["output_data_format"]

    # Finally, create the Azure Quantum JSON object and return it
    return AzureQuantumJob(
        backend=backend,
        target=backend.name(),
        name=name,
        input_data=bitcode,
        blob_name=blob_name,
        content_type=content_type,
        provider_id=provider_id,
        input_data_format="qir.v1",
        output_data_format=output_data_format,
        input_params=kwargs,
        metadata={}
    )
```

Based on this function, you create another function that creates a resource estimation job directly from precomputed logical resource estimates. This function internally creates a small QIR program that uses the low-level QIR function `__quantum__qis__applyunimplemented__body`. You use the function to inject logical resource counts into a list of qubits.

Select **Code** to add a new cell, and then enter and run the following code:

```python
def resource_estimation_job_from_logical_counts(
    provider: AzureQuantumProvider,
    qubit_count: int = 0,
    t_count: int = 0,
    rotation_count: int = 0,
    rotation_depth: int = 0,
    ccz_count: int = 0,
    measurement_count: int = 0,
    **kwargs
):
    from pyqir.generator import ir_to_bitcode
    import textwrap

    ir = f"""
        %Array = type opaque
        %Qubit = type opaque
        attributes #1 = {{ "EntryPoint" }}
        declare %Array* @__quantum__rt__qubit_allocate_array(i64)
        declare void @__quantum__rt__qubit_release_array(%Array*)
        declare void @__quantum__qis__applyunimplemented__body(i64, i64, i64, i64, i64, %Array*)
        define void @Project__Program() #1 {{
        entry:
            %target = call %Array* @__quantum__rt__qubit_allocate_array(i64 {qubit_count})
            call void @__quantum__qis__applyunimplemented__body(i64 {t_count}, i64 {rotation_count}, i64 {rotation_depth}, i64 {ccz_count}, i64 {measurement_count}, %Array* %target)
            call void @__quantum__rt__qubit_release_array(%Array* %target)
            ret void
        }}
        """

    bitcode = ir_to_bitcode(textwrap.dedent(ir))
    
    return resource_estimation_job_from_qir(provider, bitcode, **kwargs)
```

### Run experiments

A resource estimation job consists of two types of job parameters:

- [Target parameters](/azure/quantum/overview-resources-estimator#target-parameters): Qubit model, QEC schemes, and error budget.
- Operation arguments (optional): Arguments that can be passed to the QIR program.

In the Azure Quantum Resource Estimator, you can submit jobs that have multiple configurations of job parameters, or multiple *items*, as a single job to avoid rerunning multiple jobs on the same quantum program.

As configurations for your experiment, you use all six predefined qubit parameters. As a predefined QEC scheme, use `surface_code` with gate-based qubit parameters and `floquet_code` with Majorana-based qubit parameters. For all experiments, assume an error budget of 1/3. So, you have six different items of configurations.

Select **Code** to add a new cell, and then enter or paste the following code:

```python
labels = ["Gate-based µs, 10⁻³", "Gate-based µs, 10⁻⁴", "Gate-based ns, 10⁻³", "Gate-based ns, 10⁻⁴", "Majorana ns, 10⁻⁴", "Majorana ns, 10⁻⁶"]

items = [
    {"qubitParams": {"name": "qubit_gate_us_e3"}, "errorBudget": 0.333},
    {"qubitParams": {"name": "qubit_gate_us_e4"}, "errorBudget": 0.333},
    {"qubitParams": {"name": "qubit_gate_ns_e3"}, "errorBudget": 0.333},
    {"qubitParams": {"name": "qubit_gate_ns_e4"}, "errorBudget": 0.333},
    {"qecScheme": {"name": "floquet_code"}, "qubitParams": {"name": "qubit_maj_ns_e4"}, "errorBudget": 0.333},
    {"qecScheme": {"name": "floquet_code"}, "qubitParams": {"name": "qubit_maj_ns_e6", "tGateErrorRate": 0.01}, "errorBudget": 0.333}
]
```

Next, create a resource estimation job for all items based on logical resource counts that you've extracted and precomputed for the 2,048-bit factoring instance.

Select **Code** to add a new cell, and then enter and run the following code:

```python
job = resource_estimation_job_from_logical_counts(provider,
    qubit_count=12581,
    t_count=12,
    rotation_count=12,
    rotation_depth=12,
    ccz_count=3731607428,
    measurement_count=1078154040,
    items=items
)
job_monitor(job)
results = job.result()
```

### Understand the results

Finally, you present the experimental results by using built-in resource estimation tables and a custom summary table. Write a reusable `dashboard` function that creates an HTML display from a pandas DataFrame and the resource estimation tables.

Select **Code** to add a new cell, and then enter and run the following code:

```python
def dashboard(results):
    def get_row(result):
        # Extract raw data from the result dictionary
        logical_qubits = result["physicalCounts"]["breakdown"]["algorithmicLogicalQubits"]
        logical_depth = result["physicalCounts"]["breakdown"]["logicalDepth"]
        num_tstates = result["physicalCounts"]["breakdown"]["numTstates"]
        code_distance = result["logicalQubit"]["codeDistance"]
        num_tfactories = result["physicalCounts"]["breakdown"]["numTfactories"]
        tfactory_fraction = (result["physicalCounts"]["breakdown"]["physicalQubitsForTfactories"] / result["physicalCounts"]["physicalQubits"]) * 100
        physical_qubits = result["physicalCounts"]["physicalQubits"]
        runtime = result["physicalCounts"]["runtime"]

        # Format some entries
        logical_depth_formatted = f"{logical_depth:.1e}"
        num_tstates_formatted = f"{num_tstates:.1e}"
        tfactory_fraction_formatted = f"{tfactory_fraction:.1f}%"
        physical_qubits_formatted = f"{physical_qubits / 1e6:.2f}M"

        # Make runtime human-readable; find the largest units for which the
        # runtime has a value that is larger than 1.0.  For that unit, 
        # round the value and append the unit suffix.
        units = [("nanosecs", 1), ("microsecs", 1000), ("millisecs", 1000), ("secs", 1000), ("mins", 60), ("hours", 60), ("days", 24), ("years", 365)]
        runtime_formatted = runtime
        for idx in range(1, len(units)):
            if runtime_formatted / units[idx][1] < 1.0:
                runtime_formatted = f"{round(runtime_formatted) % units[idx][1]} {units[idx - 1][0]}"
                break
            else:
                runtime_formatted = runtime_formatted / units[idx][1]

        # Special case for years
        if isinstance(runtime_formatted, float):
            runtime_formatted = f"{round(runtime_formatted)} {units[-1][0]}"

        # Append all extracted and formatted data to a data array
        return (logical_qubits, logical_depth_formatted, num_tstates_formatted, code_distance, num_tfactories, tfactory_fraction_formatted, physical_qubits_formatted, runtime_formatted)

    data = [get_row(results.data(index)) for index in range(len(results))]

    # Create a DataFrame with explicit column names and configuration names extracted from the array
    import pandas as pd
    df = pd.DataFrame(data, columns=["Logical qubits", "Logical depth", "T states", "Code distance", "T factories", "T factory fraction", "Physical qubits", "Physical runtime"], index=labels)

    from IPython.display import HTML

    html = f"""
    Summary{df.to_html()}
    Details{results._repr_html_()}
    """
    
    return HTML(html)

dashboard(results)
```

The output looks similar to this example:

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

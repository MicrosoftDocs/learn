In [Create your first Q# program by using the Quantum Development Kit](/training/modules/qsharp-create-first-quantum-development-kit/3-random-bit-generator) module, you learned that classical security protocols don't produce truly random numbers, but rather pseudorandom numbers and thus a hacker can find out the sequence of random numbers used to generate a classical password. To avoid this, your first task as a member of the space fleet was to create secure passwords using a quantum random number generator. 

However, there are more ways to create secure passwords and conceal confidential information. Cryptography is the technique by using physical or mathematical means, such as using a computational difficulty of solving a particular task. A popular cryptographic protocol is the [Rivest–Shamir–Adleman (RSA) scheme](https://wikipedia.org/wiki/RSA_(cryptosystem)?azure-portal=true), which is based on the practical difficulty of factoring prime numbers by using a classical computer.

One quantum algorithm with superquadratic speedup and for which the cost of error correction is well studied is Shor’s factoring algorithm. In [Explore the key concepts of quantum computing by using Q#](/training/modules/qsharp-explore-key-concepts-quantum-computing/8-introduction-quantum-algorithms/?azure-portal=true) module, you can find an overview of Shor's algorithm application in cryptography.

Some of today’s classical cryptographic schemes that are based on assumptions of the difficulty of factoring large numbers. Estimating the resources required for Shor’s algorithm is important for assessing the vulnerability of such cryptographic schemes. 


## Estimate the resources with Azure Quantum

You'll calculate the resource estimates for the factoring of a 2048-bit integer. As tolerated error budget, you choose $\epsilon = 1/3$. 

### Getting started

Create a new Notebook in your workspace as you did in the previous step. 

1. In the left blade, select **Notebooks**.
1. Click **My Notebooks** and click **Add New**.
1. In **Kernel Type**, select **IPython**.
1. Type a name for the file, for example *factoringResourceEstimator.ipynb*, and click **Create file**.

First, we need to import several Python classes and functions from `azure.quantum` and `qiskit`. We aren't using Qiskit to build quantum circuits, however, we're using `AzureQuantumJob` and `job_monitor`, which are built on top of the Qiskit ecosystem. Click **+ Code** to add a new cell. 

```python
from azure.quantum.qiskit import AzureQuantumProvider
from azure.quantum.qiskit.job import AzureQuantumJob

from qiskit.tools.monitor import job_monitor
```

We connect to the Azure Quantum workspace. Click **+ Code** to add a new cell.  

```python
provider = AzureQuantumProvider (
    resource_id = "",
    location = ""
)
```

### Extracting resource estimates from logical resource counts

Let's implement a generic function that takes as input the Azure Quantum provider and the QIR bitcode of the quantum program. It returns as a result an Azure Quantum job. Resource Estimation input parameters can be passed via keyword arguments to the function. 

For every code snippet in this unit, click **+ Code** to add a new cell and copy the code. 

```python
from azure.quantum.qiskit import AzureQuantumProvider

def resource_estimation_job_from_qir(provider: AzureQuantumProvider, bitcode: bytes, **kwargs):
    """A generic function to create a resource estimation job from QIR bitcode"""

    # Find the Azure Quantum Resource Estimator target from the provider
    backend = provider.get_backend('microsoft.estimator')

    # You can provide a name for the job via keyword arguments; if not,
    # we'll use QIR job as a default name
    name = kwargs.pop("name", "QIR job")

    # We extract some job specific arguments from the backend's configuration
    config = backend.configuration()
    blob_name = config.azure["blob_name"]
    content_type = config.azure["content_type"]
    provider_id = config.azure["provider_id"]
    output_data_format = config.azure["output_data_format"]

    # Finally, we create the Azure Quantum JSON object and return it
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

Based on this function, we create another function that creates a resource estimation job directly from precomputed logical resource estimates. This function internally creates a small QIR program that uses the low-level QIR function `__quantum__qis__applyunimplemented__body` that allows to inject logical resource counts to a list of qubits.

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

### Running experiments

As configurations for the experiment we use all six pre-defined qubit parameters. As pre-defined QEC scheme we use `surface_code` with gate-based qubit parameters, and `floquet_code` with Majorana based qubit parameters. For all experiments, we assume an error budget of 1/3.

```python
experiments = [
    ("Gate-based µs, 10⁻³", {"qubitParams": {"name": "qubit_gate_us_e3"}, "errorBudget": 0.333}),
    ("Gate-based µs, 10⁻⁴", {"qubitParams": {"name": "qubit_gate_us_e4"}, "errorBudget": 0.333}),
    ("Gate-based ns, 10⁻³", {"qubitParams": {"name": "qubit_gate_ns_e3"}, "errorBudget": 0.333}),
    ("Gate-based ns, 10⁻⁴", {"qubitParams": {"name": "qubit_gate_ns_e4"}, "errorBudget": 0.333}),
    ("Majorana ns, 10⁻⁴", {"qecScheme": {"name": "floquet_code"}, "qubitParams": {"name": "qubit_maj_ns_e4"}, "errorBudget": 0.333}),
    ("Majorana ns, 10⁻⁶", {"qecScheme": {"name": "floquet_code"}, "qubitParams": {"name": "qubit_maj_ns_e6", "tGateErrorRate": 0.01}, "errorBudget": 0.333})
]
```

Next, we're creating a resource estimation job based on logical resource counts that we have extracted for the pre-computed for the 2048-bit factoring instance. We wait for each job to finish and push the extracted resource estimation results into the `experiment_results list`.

```python
from ipywidgets import IntProgress, Layout
from IPython.display import display

experiment_results = []

progress_bar = IntProgress(value=1, min=1, max=len(experiments), style={'description_width': 'initial'}, layout=Layout(width='75%'))
display(progress_bar)

for idx, (name, params) in enumerate(experiments):
    progress_bar.description = f"{idx + 1}. {name}"

    job = resource_estimation_job_from_logical_counts(provider,
        qubit_count=12581,
        t_count=12,
        rotation_count=12,
        rotation_depth=12,
        ccz_count=3731607428,
        measurement_count=1078154040,
        **params # use parameters from experiment configuration
    )
    job_monitor(job)
    result = job.result()

    experiment_results.append((name, result))

    progress_bar.value += 1
```

### Understanding the results

Finally, we're presenting the experimental results using built-in resource estimation tables and a custom summary table. For this purpose, we write a reusable `dashboard` function that creates an HTML display from a pandas data frame and the resource estimation tables.

```python
def dashboard(experiment_results):
    def get_row(result):
        # Extract raw data from result dictionary
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

        # Make runtime human readable; we find the largest units for which the
        # runtime has a value that is larger than 1.0.  For that unit we are
        # rounding the value and append the unit suffix.
        units = [("nanosecs", 1), ("microsecs", 1000), ("millisecs", 1000), ("secs", 1000), ("mins", 60), ("hours", 60), ("days", 24), ("years", 365)]
        runtime_formatted = runtime
        for idx in range(1, len(units)):
            if runtime_formatted / units[idx][1] < 1.0:
                runtime_formatted = f"{round(runtime_formatted) % units[idx][1]} {units[idx - 1][0]}"
                break
            else:
                runtime_formatted = runtime_formatted / units[idx][1]

        # special case for years
        if isinstance(runtime_formatted, float):
            runtime_formatted = f"{round(runtime_formatted)} {units[-1][0]}"

        # Append all extracted and formatted data to data array
        return (logical_qubits, logical_depth_formatted, num_tstates_formatted, code_distance, num_tfactories, tfactory_fraction_formatted, physical_qubits_formatted, runtime_formatted)

    index, data = zip(*[(name, get_row(result.data())) for (name, result) in experiment_results])

    # Create data frame with explicit column names and configuration names extracted from array
    import pandas as pd
    df = pd.DataFrame(data, columns=["Logical qubits", "Logical depth", "T states", "Code distance", "T factories", "T factory fraction", "Physical qubits", "Physical runtime"], index=index)

    from IPython.display import HTML

    detailed_html = [f"""
    
      {name}
      {result.summary._repr_html_()}
    """ for (name, result) in experiment_results]

    html = f"""
    Summary{df.to_html()}
    
      {"".join(detailed_html)}
    
    """
    
    return HTML(html)

dashboard(experiment_results)
```

**Summary**

|Qubit model|Logical qubits|	Logical depth|	T states|	Code distance |	T factories	| T factory fraction| Physical qubits |	Physical runtime|
|---|---|---|---|---|---|---|---|---|
|Gate-based µs, 10⁻³|	25481|	1.2e+10|	1.5e+10	|27|	13|	0.6%|	37.38M|	6 years|
|Gate-based µs, 10⁻⁴|	25481|	1.2e+10|	1.5e+10	|13|	14|	0.8%|	8.68M|	3 years|
|Gate-based ns, 10⁻³|	25481| 1.2e+10 | 1.5e+10	|27|	15|	1.3%|	37.65M|	2 days|
|Gate-based ns, 10⁻⁴|	25481|	1.2e+10	|1.5e+10	|13	|18|	1.2%|	8.72M|	18 hours|
|Majorana ns, 10⁻⁴	|   25481|	1.2e+10	|1.5e+10	|15	|15|	1.3%|	26.11M|	15 hours|
|Majorana ns, 10⁻⁶	|   25481|	1.2e+10	|1.5e+10	|7	|13	|0.5%|	6.25M|	7 hours|

We see that in the worst scenario, a hacker using gate-based µs qubits (qubits that have operation times in the nanosecond regime such as superconducting qubits) and a surface QEC code would need six years and 37.38 millions of qubits to factor a 2048-bit integer with Shor's algorithm.

If we use a different qubit technology, for example gate-based ns ion qubits and the same surface code, the number of qubits doesn't change much, but the runtime became two days in the worst case and 18 hours in the optimistic case. If we change the qubit technology and the QEC code, for example, with Majorana-based qubits, factoring a 2048-bit integer using Shor’s algorithm could be done in hours with an array of 6.25 millions of qubits in the best case scenario. 

We can conclude that using Majorana qubits and a Floquet QEC code is the best choice to execute Shor's algorithm and factor a 2048-bit integer password. The space fleet should prepare for future quantum hackers, and even better, be ready to hack our space enemies ourselves!  

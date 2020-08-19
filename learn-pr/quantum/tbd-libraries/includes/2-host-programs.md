One of the Quantum Development Kit's greatest strengths is its flexibility
across platforms and development environments. Much of this stems from the
multiple ways in which users can run Q# programs. So far in this learning path,
you have been running Q# as a standalone application, where Q# is the only
language involved and the program is invoked directly. Specifically we have
considered examples with the command-line interface, but for the sake of
completeness note that Q# can also be used directly from [Q# Jupyter
Notebooks](https://docs.microsoft.com/quantum/quickstarts/install-jupyter?view=qsharp-preview&tabs=tabid-conda).

While using Q# directly is sufficient for many purposes, there are also many
applications which either require, or are drastically simplified by, the use of
an additional *host program*. Written in either Python or a .NET language (e.g.
C# or F#), a host program has the ability to invoke Q# programs—which are then
run in the same manner as usual—and receive the returned results. An obvious
benefit of host programs is therefore that those results can be easily collected
and used in any manner such as plotting, post-processing, or file exporting.

## Useful applications of host programs

The Q# language was developed specifically around the quantum end of quantum
computation that is, around the processes which will be sent to run on quantum
devices. It therefore includes many quantum-specific features, but lacks some
abilities which are "standard" to common languages; for example, plotting and
the ability to import and export files. Besides visualization as a useful tool
when exploring Q#, some "advanced" workflows and applications of Q# actually
*rely* on the use of host programs. Among these are some uses of the
domain-specific libraries which you will see in later units—for example,
importing molecular data files for use with the quantum chemistry library, or
importing the data and visualizing the classification in with the quantum 
machine learning library.

Whether it's for curiosity, convenience, or a critical function, the ability to
use Q# through host programs is a great skill to have on hand. Next, we show you
how to set up your system to use either a Python or a C# host program, and then
get you familiar with the workflow by rolling quantum dice.

## Set up your host program

### [Python setup](#tab/tabid-python)

Install [Miniconda](https://docs.conda.io/en/latest/miniconda.html) or
[Anaconda](https://www.anaconda.com/products/individual#Downloads). **Note:**
64-bit installation required.

1. Open an Anaconda Prompt.

   - Or, if you prefer to use PowerShell or pwsh: open a shell, run `conda init
     powershell`, then close and re-open the shell.

1. Create and activate a new conda environment named `qsharp-env` with the
   required packages (including Jupyter Notebook and IQ#) by running the
   following commands:

    ```bash
    conda create -n qsharp-env -c quantum-engineering qsharp notebook

    conda activate qsharp-env
    ```

1. Run `python -c "import qsharp"` from the same terminal to verify your
   installation and populate your local package cache with all required QDK
   components.
   
To implement Q# operations in Python programs you first need to create a Q# project
as usual. In the the same folder as the `Program.qs` of the Q# project, create a 
Python program called `host.py` to simulate the Q# operations. You need to import 
the `qsharp` module. The Python client will treat Q# namespaces as if they 
were Python modules, and each Q# operation a Python function of the 
associated module. For example:

```python
import qsharp
from MyNamespace import MyQuantumOperation
```

To simulate each operation you only need to use a Python method, `simulate`,
that is generated for each operation. For example, for the operation
`GenerateRandomBit` that we defined in the module [todo](todo), the following
lines will output a random bit:

```python
import qsharp
from QuantumRNG import GenerateRandomBit

print(GenerateRandomBit.simulate())
```

If your operation has input arguments, you can specify them by inserting them
between the brackets of `.simulate()`.

For more information about Python host programs in the QDK you can read the 
following [section about host programs in Q#](https://docs.microsoft.com/quantum/user-guide/host-programs?tabs=tabid-python#q-with-host-programs).

### [C# setup](#tab/tabid-cs)

To use C# you don't need to install anything else. The .NET Core SDK 3.1 already
includes everything that you might need. The process to run Q# applications from
C# is:

1. Create a new Q# library

  ```dotnetcli
  dotnet new classlib -lang Q# -o quantum
  ```

1. Create a new C# or F# console project

  ```dotnetcli
  dotnet new console -lang C# -o host  
  ```

1. Add your Q# library as a reference from your host program

  ```dotnetcli
  cd host
  dotnet add reference ../quantum/quantum.csproj
  ```

1. [Optional] Create a solution for both projects

  ```dotnetcli
  dotnet new sln -n quantum-dotnet
  dotnet sln quantum-dotnet.sln add ./quantum/quantum.csproj
  dotnet sln quantum-dotnet.sln add ./host/host.csproj
  ```
Once you have your projects set up following the above instructions, you can call into Q# from your .NET console application.
The Q# compiler will create .NET classes for each Q# operation and function that allow you to run your quantum programs on a simulator.

For more information about C# host programs in the QDK you can read the 
following [section about host programs in Q#](https://docs.microsoft.com/quantum/user-guide/host-programs?tabs=tabid-csharp#q-with-host-programs).

***


## Roll the quantum dice

To demonstrate how a host program can be used to call Q# operations and
collect/process the results, we will use the same Q# code used in the quantum
random number generator to simulate and visualize the results of repeatedly
rolling two dice.

The Q# program may look familiar: it simply allocates a single qubit, puts it in
superposition, measures it, and returns the result.
Most of the bells and whistles are thus reserved for the host program, which
simulates the roll of a single dice by repeatedly calling the Q# operation to
generate a random bit-string and converting it to integer form (and repeating
this if the random integer is higher than the number of sides on your dice).
Supposing each roll consists of two dice, the program repeats this twice and
collects the net sum of each roll.
After repeating this for a given number of rolls, we are left with a list of
results which we can process in any way we see fit.
In this case, we will simply create a histogram to observe the relative
probability of each roll, and perhaps give you a quantum helping hand for
the next time you play Monopoly.

To avoid relying on external packages or other dependencies, we won't "plot" 
the histogram in a traditional sense. Instead, we'll use a few extra lines in 
the host program to print the histogram directly in the console.

### Q# program

In your Q# project, create a Q# file with the following contents. It is the
familiar `GenerateRandomBit` operation. 

```qsharp
namespace QuantumRNG {
open Microsoft.Quantum.Measurement; 
open Microsoft.Quantum.Intrinsic;
    
    operation GenerateRandomBit() : Result {
        using (q = Qubit())  {  // Allocate a qubit.
            H(q);               // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            return MResetZ(q);  // Measure the qubit value.
        }
    }
}
```

Now let's write the quantum dice rolling simulation for each host program:

### [Python host program](#tab/tabid-python)

```python
import qsharp
from QuantumRNG import GenerateRandomBit 

dice_max = 6
num_rolls = 1000

roll_result_list = []
for roll in range(num_rolls):
    roll_sum = 0
    # Each roll consists of two dice:
    for dice in range(2):
        # Get random integer in 0-5 for each dice rolled:
        single_dice_result = dice_max
        while single_dice_result >= dice_max:
            bit_string = [] 
            for i in range(0, dice_max.bit_length()):
                bit_string.append(GenerateRandomBit.simulate())
            single_dice_result = int("".join(str(x) for x in bit_string), 2)
        # Add single dice result to total of roll:
        roll_sum += single_dice_result
    # Add 2 so results correspond to the real dice range 1-6:
    roll_result_list.append(roll_sum + 2)

# Create list with number of times each result appeared:
result_hist = [0 for i in range(2*dice_max - 1)]
for res in roll_result_list:
    result_hist[res-2] += 1

print('Number of times rolling [2, 3, ..., %s]:' % str(2*dice_max))
print(result_hist)

# "Plot" histogram using console printing:
max_stars = 24
norm_factor = num_rolls/max(result_hist)

print("\nHistogram:")
for idx, res in enumerate(result_hist):
    num_stars = round(norm_factor * (res / num_rolls) * max_stars)
    star_str = "".join(['*' for i in range(num_stars)])
    label_str = ('%-3d: ' % (idx + 2)) 
    print(label_str + star_str)
```

### [C# host program](#tab/tabid-python)

```csharp
using System;
using System.Linq;
using System.Collections.Generic;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

using QuantumRNG;

namespace host
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                var bitString = "0";

                int dice_max = 6;
                int num_rolls = 1000;
                // Number of bits required:
                int size = Convert.ToInt32(Math.Floor(Math.Log(dice_max, 2.0) + 1));
                
                List<int> roll_result_list = new List<int>();

                for (int roll = 0; roll < num_rolls; roll++)
                {
                    var roll_sum = 0;
                    // Each roll consists of two dice:
                    for (int dice = 0; dice < 2; dice++)
                    {
                        // Get random integer in 0-5 for each dice rolled:
                        var single_dice_result = dice_max; 
                        while (single_dice_result >= dice_max)  
                        {
                            bitString = "0"; 
                            bitString = String.Join("", Enumerable.Range(0, size).Select(idx =>
                                                    GenerateRandomBit.Run(sim).Result == Result.One ? "1" : "0"
                                                                                        )
                                                    );
                            single_dice_result = Convert.ToInt32(bitString, 2);
                        }
                        // Add single dice result to total of roll:
                        roll_sum += single_dice_result;
                    }
                    // Add 2 so results correspond to the real dice range 1-6:
                    roll_result_list.Add(roll_sum + 2);
                }     

                // Create list with number of times each result appeared:
                var result_hist = new List<int>(new int[2 * dice_max - 1]); // list of 0's
                foreach (int res in roll_result_list)
                {
                    result_hist[res - 2]++;
                }

                Console.WriteLine($"Number of times rolling [2, 3, ..., {2 * dice_max}]:");
                Console.WriteLine("[" + String.Join(", ", result_hist) + "]");
                Console.WriteLine("\nHistogram");
                    
                int max_stars = 24;
                double norm_factor = (double)num_rolls / (double)result_hist.Max();

                string histogram_string = "";
                int i = 0;
                foreach (int res in result_hist)
                {
                    double pre_round = norm_factor * ((double)res / (double)num_rolls) * (double)max_stars;
                    int num_stars = (int)Math.Round(pre_round);
                    string star_str = new String('*', num_stars);
                    histogram_string += String.Format("{0,-3}: {1} \n", i + 2, star_str);
                    i++;
                }
                Console.WriteLine(histogram_string);
            }
        }
    }
}
```

***

### Output

Your output should look like the following:

```output
Number of times rolling [2, 3, ..., 12]:
[28, 53, 86, 128, 143, 159, 135, 113, 71, 60, 24]

Histogram:
2  : ****
3  : ********
4  : *************
5  : *******************
6  : **********************
7  : ************************
8  : ********************
9  : *****************
10 : ***********
11 : *********
12 : ****
```

Congratulations! Now you can launch your own quantum casino. Jokes aside, this
is a very simple representation of how the quantum kit offers high
interoperability between different environments. This means that you can use
the skills and tools that you have from other environments and combine them
with Q# and the power of quantum computing.

## Discover more

- For more details on host programs, see [Ways to run a Q#
  program](https://docs.microsoft.com/en-us/quantum/user-guide/host-programs?view=qsharp-preview&tabs=tabid-python).

In the next units we are going to explore the libraries of the Quantum
Development Kit. Some of them make intensive use of host programs like Python or
C#.

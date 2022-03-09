You're ready to connect to Earth's Azure Quantum services and start solving problems on a real quantum computer. 

In this unit, you learn how to submit a job to Azure Quantum using a Jupyter notebook in the Azure Quantum portal.

## Copy a sample notebook

To get started, copy a sample notebook from the notebook gallery.

1. Log in to the [Azure portal](https://portal.azure.com) and select your Azure Quantum workspace.
1. Select **Notebooks**.
1. In the **Sample gallery**, locate the **Hello, world: Q#** notebook tile, select either the **IonQ** or **Quantinuum** provider (the sample code is identical) and select **Copy to my notebooks**.
1. The sample notebook can be found under **My notebooks** and you can now run the notebook.

![Load a sample Jupyter notebook](../media/create_notebook_steps.png)

## Run the notebook

To run the sample notebook, follow these steps for your selected provider.

### [IonQ](#tab/tabid-ionq)

1. In **My notebooks**, select the **hello-world-qsharp-ionq** notebook. 
1. To run the full program from top to bottom, select **Run all**. 
1. To walk through the example and run each cell individually from top to bottom, select the cell you want to run and select the **run icon**.

![Run a Jupyter notebook](../media/run_or_run_all.png)

### Stepping through the program on IonQ

The *hello world* program runs a simple quantum random number generator and displays a histogram of the results. 

Some things to note:

- **The kernel**: In the upper right of the notebook, you can see that the notebook is running the **Python 3 (ipykernel)** kernel, which is the default Python shell for Juptyer Notebooks. When you create a notebook in Azure Quantum, you can select either the **Python 3 (ipykernel)** or the **Azure Quantum Q#** kernel. Both kernels are fully compatible with Q# code. 
- **1st cell**: Preloads your subscription information to connect to the Azure Quantum service. 
- **2nd cell**: Retrieves the available targets (quantum computers and simulators) in your workspace. 
- **3rd and 4th cells**: The Q# code that defines the program. Note the *%%qsharp* magic command which allows you to enter Q# code directly into the notebook when using the **Python 3 (ipykernel)**. 
- **5th cell**: Sets the target and submits the job. 
- **6th and 7th cells**: Plots and displays the result. The results should be roughly split between 0 and 1. 

### [Quantinuum](#tab/tabid-qunatinuum)

1. In **My notebooks**, select the **hello-world-qsharp-honeywell** notebook. 
1. To run the full program from top to bottom, select **Run all**. 
1. To walk through the example and run each cell individually from top to bottom, select the cell you want to run and select the **run icon**.

![Run a Jupyter notebook](../media/run_or_run_all.png)


### Stepping through the program on Quantinuum

The *hello world* program runs a simple quantum random number generator and displays a histogram of the results. 

Some things to note:

- **The kernel**: In the upper right of the notebook, you can see that the notebook is running the **Python 3 (ipykernel)** kernel, which is the default Python shell for Juptyer Notebooks. When you create a notebook in Azure Quantum, you can select either the **Python 3 (ipykernel)** or the **Azure Quantum Q#** kernel. Both kernels are fully compatible with Q# code. 
- **1st cell**: Preloads your subscription information to connect to the Azure Quantum service. 
- **2nd cell**: Retrieves the available targets (quantum computers and simulators) in your workspace. 
- **3rd and 4th cells**: The Q# code that defines the program. Note the *%%qsharp* magic command which allows you to enter Q# code directly into the notebook when using the **Python 3 (ipykernel)**. 
- **5th cell**: Sets the target and submits the job. 
- **6th and 7th cells**: Plots and displays the result.

Looking at the histogram, you may notice that the program returned 0 every time, which is not very random. This is because the notebook was prepopulated to use the **Honeywell API Validator**, *honeywell.hqs-lt-s1-apival*. Using the API Validator ensures that your code will run successfully on Quantinuum hardware, but also returns 0 for every quantum measurement. 

To create a true random number generator, modify the code in the 5th cell to use the **System Model H1 Emulator** target, *honeywell.hqs-lt-s1-sim*

```python
qsharp.azure.target("honeywell.hqs-lt-s1-sim")
```

Re-run that cell and the following cells. Now, the results should be roughly split between 0 and 1. 

***

> [!NOTE]
> If you have any questions regarding the workspace creation process or run into any issue at any point using Azure Quantum, bookmark [Azure Quantum office hours](https://aka.ms/AQ/OfficeHours) and join our open office hours every Thursday 8∶30 AM Pacific Standard Time zone (PST).


Congratulations, you learned how to use Azure Quantum to create a true quantum random bit generator! However, we don't want quantum computers just to generate random numbers.

In the next units, you'll learn about the different targets available to run your algorithms.

Calculating a regression line for a simple binomial (two-variable) function from first principles is possible, but involves some mathematical effort. When you consider a real-world dataset in which ***x*** is not a single feature value such as temperature, but a vector of multiple variables such as temperature, day of week, month, rainfall, and so on; the calculations become more complex.

For this reason, data scientists generally use specialized machine learning frameworks to perform model training and evaluation. Such frameworks encapsulate common algorithms and provide useful functions for preparing data, fitting data to a model, and calculating model evaluation metrics.

## Try for yourself

One of the most commonly used machine learning frameworks for Python is **scikit-learn**, and in this hands-on exercise, you'll use scikit-learn to train and evaluate a regression model. To complete the exercise, you'll need:

- A Microsoft Azure subscription.
- A Visual Studio Codespace based on the **MicrosoftDocs/ml-basics** GitHub repository.

If you don't already have an Azure subscription, you can sign up for a free trial at [https://azure.microsoft.com/free/](https://azure.microsoft.com/free?azure-portal=true).

If you have not already created a Codespace based on the **MicrosoftDocs/ml-basics** repository, complete the following steps to do so:

1. Open <a href = "https://online.visualstudio.com/environments/new?azure-portal=true&name=ml-basics&repo=MicrosoftDocs/ml-basics" target="_blank" rel="noopener">Visual Studio Codespaces</a> in a new browser tab; and if prompted, sign in using the Microsoft account associated with your Azure subscription.
2. Create a Codespace with the following settings (if you don't already have a Visual Studio Codespaces billing plan, you'll be prompted to create one):
    - **Codespace Name**: *A name for your Codespace - for example, **ml-basics**.*
    - **Git Repository**: MicrosoftDocs/ml-basics
    - **Instance Type**: Standard (Linux) 4 cores, 8GB RAM
    - **Suspend idle Codespace after**: 30 minutes
3. Wait for the Codespace to be created. This will take around 3 minutes. You'll see the following things happen:
    - A script will initialize and configure your Codespace.
    - A list of notebook (.ipynb) files will appear in the pane on the left.
4. After preparation is complete, you can close the **Welcome** pane, and any others that have opened during setup. You can also change the color scheme to suit your preference - just click the **&#9881;** icon at the bottom left and select a new **Color Theme**. A light color theme may make it easier to read the Python code in the notebooks.

After you've created the environment, open the **Regression.ipynb** notebook and follow the instructions it contains. If a page welcoming you to the Python extension is displayed, close it.

> [!NOTE]
> We highly recommend using a Visual Studio Codespace hosted in Azure for this exercise - this setup ensures the correct version of Python and the various packages you will need are installed. If you prefer to complete the exercise using your own computer, and you have experience configuring Python development environments, you can find details for configuring a local development environment at [Running the labs on your own computer](https://github.com/MicrosoftDocs/ml-basics/blob/master/local-setup.md?azure-portal=true).

When you've finished working through the notebook, return to this module and move on to the next unit to check your knowledge.

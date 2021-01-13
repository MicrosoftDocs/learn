Meteors can be visible from Earth every night. But the best meteor showers are the ones that originate from one of the comets that orbits around our sun. To see those meteor showers, beyond knowing the path of the comets, we must also consider the side of the Earth where the meteors will enter our atmosphere. And we must consider whether the night sky will be dark enough to optimize our view of the meteor tails. 

## Review the data science life cycle

Before we jump into the code, we need to review the [data science life cycle](https://docs.microsoft.com/azure/machine-learning/team-data-science-process/overview?azure-portal=true). *Data science* is a field that supports the discovery of new ways to view and understand our world by using data. 

A typical data science project iterates through four main steps:
1. Business understanding
1. Data acquisition and understanding
1. Modeling
1. Deployment

A project will *iterate* through these steps. So in every step, you can revisit one of the other steps to see if something has changed or if what you *now* know provides insights that might change one of the other steps.

Although we're not space-exploration experts, we can use what we learn from experts to help guide this module. In a scenario where what you're building and discovering affects something real, you should always consult an expert in the field. 

This module focuses on the "Data acquisition and understanding" node of the data science life cycle. 

## Set up your local environment

This module helps you create a model to predict the best date to view a meteor shower. To create the model, you need some kind of Python notebook development environment. 

If you haven't set up a Python environment before, we recommend that you use the [Visual Studio Code data science setup documents](https://code.visualstudio.com/docs/python/data-science-tutorial?azure-portal=true). You'll need:
- Visual Studio Code
- Python
- Miniconda

> [!NOTE]
> If you've already completed an *Over the Moon* Learn module, open your *over-the-moon* folder in Visual Studio Code and skip to step 3. 

After you install everything, follow these steps to prepare your environment:
1. Create a folder called *over-the-moon*. 
2. Open the folder in Visual Studio Code.
3. Create a folder inside the *over-the-moon* folder. Name it *meteor-showers*.
4. Create a folder inside the *meteor-showers* folder. Name it *data*.
5. Create a file called *meteor-showers.ipynb*.
6. Open the *meteor-showers.ipynb* file in Visual Studio Code.
7. Make sure you're using the conda environment that you set up earlier.

Your environment should look like this screenshot:

:::image type="content" source="../media/visual-studio-code-env.png" alt-text="Screenshot that shows a local Visual Studio Code environment example.":::

Meteors can be visible from Earth every night. But the best meteor showers are the ones that originate from one of the comets that orbits around our sun. To see those meteor showers, beyond knowing the path of the comets, we must also consider the side of the Earth where the meteors will enter our atmosphere. And we must consider whether the night sky will be dark enough to optimize our view of the meteor tails. 

## Review the data science life cycle

Before we jump into the code, we need to review the [data science life cycle](/azure/machine-learning/team-data-science-process/overview?azure-portal=true). *Data science* is a field that supports the discovery of new ways to view and understand our world by using data. 

A typical data science project iterates through four main steps:
1. Business understanding
1. Data acquisition and understanding
1. Modeling
1. Deployment

A project will *iterate* through these steps. So in every step, you can revisit one of the other steps to see if something has changed or if what you *now* know provides insights that might change one of the other steps.

Although we're not space-exploration experts, we can use what we learn from experts to help guide this module. In a scenario where what you're building and discovering affects something real, you should always consult an expert in the field. 

This module focuses on the "Data acquisition and understanding" node of the data science life cycle. 

## Set up your development environment

This module helps you create a model to predict the best date to view a meteor shower. To create the model, you need some kind of Python notebook development environment. 

If you haven't set up a Python environment before, the easiest way to do this is to use GitHub Codespaces. To start using GitHub Codespaces, follow these steps:
1. Make sure you're signed in to [GitHub](https://github.com?azure-portal=true).
1. Go to [Codespaces](https://github.com/codespaces?azure-portal=true).
1. In the **Explore quick start templates** section, locate the **Jupyter Notebook** template and select **Use this template**. 

>[!NOTE]
>If the Jupyter Notebook template isn't displayed on this page, select **See all** to list all available templates.

The Juptyer Notebook codespace launches and should look similar to the following screenshot:

:::image type="content" source="../media/codespaces-welcome.png" alt-text="Screenshot that shows a new Jupyter Notebooks codespaces environment.":::

>[!TIP]
>For personal GitHub accounts, you can use 120 core hours of Codespaces a month for free. For more information on billing, see [About billing for GitHub Codespaces](https://docs.github.com/en/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces?azure-portal=true). For more information on how to use Codespaces, see [GitHub Codespaces overview](https://docs.github.com/en/codespaces/overview?azure-portal=true).

After you've created your codespace, follow these steps to prepare your environment:
1. Create a folder called *over-the-moon*.
1. Create a folder inside the *over-the-moon* folder. Name it *meteor-showers*.
1. Create a file called *meteor-showers.ipynb*.
1. Create a folder inside the *meteor-showers* folder. Name it *data*.
1. Open the *meteor-showers.ipynb* file.

Your environment should look like this screenshot:

:::image type="content" source="../media/visual-studio-code-env.png" alt-text="Screenshot that shows a the set up of folders and files in the codespaces environment.":::
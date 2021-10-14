In this unit, you'll add a machine learning model to a .NET class library and choose your scenario.

## Create C# Class Library

With Model Builder, you can add machine learning to an existing project, or. Since we're starting from from scratch, we'll create a C# class library project.

1. Start Visual Studio
1. On the Start Window, choose **Create a new project**
1. In the Create a a new project dialog, type "class library" into the search bar.
1. Select **Class Library** from the list of options. Make sure that the language is C# and select **Next**.

:::image type="content" source="../media/create-class-library-project.png" alt-text="Create class library project":::

1. In the Project name text box, type "PredictiveMaintenance". Leave the defaults for all other fields and select **Next**
1. Select **.NET 6.0 (Preview)** from the Framework dropdown and select **Create** to scaffold your C# class library.

Portability is one of the benefits that class libraries provide you. Once you're done training your model, class libraries make it easy to reference any models that are part of it from console, desktop, web, and any other type of .NET application. Therefore, if you need to reference your models in various places, it's recommended to add your models to a class library.

## Add machine learning to your project

Once your class library project opens in Visual Studio, it's time to add machine learning to it.

1. In Visual Studio's solution explorer, right-click your project.
1. Select **Add > Machine Learning Model...**.

:::image type="content" source="../media/add-machine-learning-model.png" alt-text="Add machine learning model to project":::

1. From the list of new items in the Add New Item dialog, select **Machine Learning Model (ML.NET)**.
1. In the Name text box, use the name "PredictiveMaintenanceModel.mbconfig" for your model and select **Add**.

:::image type="content" source="../media/create-class-library-project.png" alt-text="Create new MBConfig item":::

After a few seconds, a file called *PredictiveMaintenanceModel.mbconfig* is added to your project. Files that use the *.mbconfig* extension are Model Builder configuration files authored in JSON that allow you to:

- Provide a name for your model.
- Collaborate with others on your team via source control.
- Persist state. If at any point in the training process you need to close Model Builder, your state is saved and you can pick up right where you left off.

## Choose your scenario

In addition to adding *PredictiveMaintenanceModel.mbconfig*, the first time you add a machine learning model to a project, the Model Builder screen opens. Now it's time to select your scenario:

For our use case, we're trying to determine whether a machine is broken or not. Since there are only two options and we want to determine which state a machine is in, the data classification scenario makes the most sense.

In the Scenario step of the Model Builder screen, select the **Data classification** scenario. Once you've selected this scenario, you're immediately advanced to the Environment screen.

:::image type="content" source="../media/choose-scenario.png" alt-text="Choose data classification scenario":::

In the next unit, we'll learn some more about supported compute environments in Model Builder.
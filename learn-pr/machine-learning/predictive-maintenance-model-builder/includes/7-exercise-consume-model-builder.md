You spent some time training a model and using evaluation metrics to select the best model for your data. Now it's time to put it to use in making predictions on your company's devices. In this unit, you'll create a console application that takes in new data and uses your model to predict whether the device will fail or not.

## Add the console application to the solution

In the **Consume** step of the Model Builder screen:

1. Select **Add to solution** for the console application template.
1. In the **Add sample console app** dialog, enter the name **PredictiveMaintenanceConsole**.
1. Select **Add to solution**.

:::image type="content" source="../media/consume-machine-learning-model.png" alt-text="Screenshot that shows selections for consuming a machine learning model in a dot NET console application.":::

After a few seconds, a new .NET console application is added to your solution.

## Run your application

1. In Visual Studio Solution Explorer, right-click the **PredictiveMaintenanceConsole** project.
1. Select **Set as Startup Project**.
1. Start your application.
1. A console window opens and produces output text similar to the following:

    ```console
    Using model to make single prediction -- Comparing actual Machine_failure with predicted Machine_failure from sample data...
    
    
    Product_ID: M14860
    Type: M
    Air_temperature: 298.1
    Process_temperature: 308.6
    Rotational_speed: 1551
    Torque: 42.8
    Tool_wear: 0
    Machine_failure: 0
    
    
    Predicted Machine_failure: 0
    
    
    =============== End of process, hit any key to finish ===============
    ```

> [!TIP]
> For this demo, the default hard-coded data sample was used to run the application and make predictions. In a real-world setting, you'd want to take inputs from a file or the console and make predictions on that data.

Congratulations! You've consumed a machine learning model by using ML.NET and Model Builder.

In this unit, you'll add a console application to your solution to consume your model

## Add console application to solution

In the Consume step of the Model Builder screen:

1. Select **Add to solution** for the console app template.
1. In the Add sample console app dialog, enter the name "PredictiveMaintenanceConsole".
1. Select **Add to solution**.

<!-- INSERT CONSUME SCREENSHOT -->

After a few seconds, the .NET console application is added to your solution.

## Run your application

1. In the Visual Studio solution explorer, right-click the PredictiveMaintenanceConsole project.
1. Select **Set as Startup Project**.
1. Start your application.
1. A console window opens and output similar to the following.

    ```console
    Using model to make single prediction -- Comparing actual Machine_failure with predicted Machine_failure from sample data...
    
    
    Product_ID: M14860
    Type: M
    Air_temperature__K_: 298.1
    Process_temperature__K_: 308.6
    Rotational_speed__rpm_: 1551
    Torque__Nm_: 42.8
    Tool_wear__min_: 0
    Machine_failure: 0
    
    
    Predicted Machine_failure: 0
    
    
    =============== End of process, hit any key to finish ===============
    ```

Congratulations! You've trained and consumed a machine learning model!
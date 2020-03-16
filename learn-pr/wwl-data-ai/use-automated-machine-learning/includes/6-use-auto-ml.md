Azure Machine Learning includes an *automated machine learning* capability that leverages the scalability of cloud compute to automatically try multiple model-training algorithms and pre-processing techniques in parallel to find the best performing model for your data.

## Run an automated machine learning experiment

In Azure Machine Learning, operations that you run are called *experiments*. Follow the steps below to run an experiment that uses automated machine learning to train a regression model that predicts bicycle rentals.

1. In [Azure Machine Learning studio](https://ml.azure.com), view the **Automated ML** page (under **Author**).
2. Create a new Automated ML run with the following settings:
    - **Select dataset**:
        - **Dataset**: bike-rentals
    - **Configure run**:
        - **Experiment name**: auto-train-bike-rental
        - **Target column**: rentals
        - **Training compute target**: aml-cluster
    - **Task type and settings**:
        - **Task type**: Regression
        - **Additional configuration settings:**
            - **Primary metric**: Normalized root mean square error (more about this later!)
            - **Automated featurization**: Selected
            - **Explain best model**: Unselected
            - **Blocked algorithms**: *Block <u>all</u> other than **RandomForest** and **LightGBM** - normally you'd want to try as many as possible, but doing so will take a lot of time!*
3. When you finish submitting the automated ML run details, it will start automatically. Wait for the run status to change from *Preparing* to *Running* (this may take five minutes or so, as the cluster nodes need to be initialized before training can begin - now might be a good time for a coffee break!). You may need to select **&#8635; Refresh** periodically.
4. When the run status changes to *Running*, view the **Models** tab and observe as each possible combination of training algorithm and pre-processing steps is tried and the performance of the resulting model is evaluated. The page will automatically refresh periodically, but you can also select **&#8635; Refresh**.
5. After a few models have been trained and evaluated (with a status of **Completed**), select **&#10754; Cancel** to cancel the remaining iterations

## Review the best model

Although you canceled the automated machine learning run, some models were trained; so you can review the best performing one.

1. On the **Details** tab of the automated machine learning run, note the recommended model.

    This recommendation is based on the performance metric you specified (*Normalized root mean square error*). To calculate this, the training process used some of the data to train the model, and applied a technique called *cross-validation* to iteratively test the trained model with data it wasn't trained with and compare the predicted value with the actual known value. The difference between the predicted and actual value (known as the *residuals*) indicates the amount of *error* in the model, and our performance metric is calculated by squaring the errors across all of the test cases, finding the mean of these squares, and then taking the square root. What all of this means is that smaller this value is, the more accurately the model is predicting.
2. Select **View model details**, and note that you can see all of the run metrics that give statistical information about the performance of the model.
3. Select the **Visualizations** tab and review the charts that show the performance of the model by comparing the predicted values against the true values, and showing the *residuals* (differences between predicted and actual values) as a histogram.

The **Predicted vs. True** chart should show a diagonal trend in which the predicted value correlates closely to the true value. A dotted line shows how a perfect model should perform, and the closer the line for your model's average predicted value is to this, the better its performance. A histogram below the line chart shows the distribution of true values.

<p style='text-align:center'><img src='media/predicted-vs-true.png' alt='Predicted vs True chart'/></p>

The **Residual Histogram** shows the frequency of residual value ranges. Residuals represent variance between predicted and true values that can't be explained by the model - in other words, errors; so what you should hope to see is that the most frequently occurring residual values are clustered around 0 (in other words, most of the errors are small), with fewer errors at the extreme ends of the scale.

<p style='text-align:center'><img src='media/residual-histogram.png' alt='Residuals histogram'/></p>

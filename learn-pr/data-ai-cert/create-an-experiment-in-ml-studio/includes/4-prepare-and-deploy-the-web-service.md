You've created and trained an experiment in Azure Machine Learning Studio. Now it's time to publish it as a web service that clients can access.

Let's prepare and publish your experiment as a web service and then evaluate the results. 

You should have already created the energy-efficiency experiment that you'll publish as a web service. Here are your next steps:

1. On the left navigation bar of Machine Learning Studio, select the **Experiments** icon.

1. Select your completed **Energy Efficiency Regression** experiment to open it.

1. Depending on the state of the web service, you might not have to run your experiment again. If the upper-right corner of the designer displays **Finished running**, and your stages show green check marks, you're ready for the next step. If not, select the **Run** button.

## Set up the web service

1. After the energy-efficiency experiment has run, at the bottom of the designer, hover over **Set Up Web Service**.

1. Select **Predictive Web Service** [Recommended].

    > [!TIP]
    > If the **Predictive Web Service** option is not available, run your experiment again. Check for the **Finished running** note.

1. Verify that the **Predictive experiment** tab opens. The designer should show a web service input and web service output operation.

1. Select **Run**.

1. Verify successful completion by looking for a green check mark in the **Score Model** operation. Also look for a **Finished running** note in the upper-right corner.

## Deploy the web service

Select **Deploy Web Service**. Machine Learning Studio creates the web service and opens a new window that indicates success. You'll notice an API key for your web service. Applications will use this key to access the web service.

## Test the web service

Now that the web service is deployed, let’s test it to see the output results.

1. Next to the **Request/Response** option, select **Test** to open the data entry dialog box.

1. In the data entry dialog box, enter the following values from the training model data:
    - Wall area: **296**
    - Roof area: **110.25** 
    - Overall height: **7**   
    - Glazing area: **0** 
    - Heating load: **15.55** 

3. In the lower-right corner, select the check mark.

You'll see the output on the status bar, just above **New** at the bottom of the Machine Learning Studio window.

To see an example of the returned JSON code, select **Details**. You'll see the values you entered and two additional values. These are the model's evaluations of the energy efficiency for the values you entered.
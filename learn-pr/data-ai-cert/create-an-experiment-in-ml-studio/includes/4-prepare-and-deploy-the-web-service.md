Creating an experiment in Azure ML Studio is only the first step in making the experiment available. After the experiment is created and trained, you need to publish it as a web service so it can be accessed by clients.

## Prepare the Web Service

Let's prepare and publish your experiment as a web service and evaluate the results. You should have already completed the previous exercise for creating the energy-efficiency experiment to ensure you have an actual experiment to use for publishing a web service.

2. Click the **Experiments** icon on the left nav bar of Azure ML Studio.  
3. Locate your completed **Energy Efficiency Regression** experiment.
4. Click the experiment to open it in Azure ML Studio.
5. Depending on the state of the web service, you may not have to run it again. If it indicates _Finished running_ in the upper right corner of the designer and you have green checks in the different stages, you're ready for the next step. If not, then click the **Run** button.

### Set Up the Web Service

1. With the Energy Efficiency experiment open in the designer and displaying green check marks showing completion, hover your mouse over the **Set Up Web Service** button in the button bar at the bottom of the designer.
2. Select **Predictive Web Service** [Recommended].

    > [!TIP]
    > If this option is grayed out, it means you need to run your experiment again. Check for the Finished Running note.

1. Verify that a new tab opens called **Predictive experiment** with the predictive experiment visible on this new tab. You should see a Web service input and Web service output operation on the designer.
1. Before we can deploy this web service, we need to run this new experiment. Click the **Run** button.
1. Verify successful completion by checking for a green check mark in the **Score Model** operation and _Finished running_ in the upper right corner.

we're ready to deploy the service.

### Deploy the Web service

1. Click the **Deploy Web Service** button.

Azure ML Studio begins the creation of web service and opens a new screen indicating success. You'll notice an API key for your web service. This key will be used by applications, to access this web service.

### Test the Web Service

Now that the web service is deployed, let’s test it to see the output results.

1. Click the **Test** button, next to the **Request/Response** option, to open the data entry dialog.
2. Enter the following values in the data entry dialog (these values are taken from the training model data)
    - **296** for wall area
    - **110.25** for roof area
    - **7** for overall height  
    - **0** for glazing area
    - **15.55** for heating load

3. Click the check mark in the bottom-right corner of the data entry dialog.

Look at the status bar, just above the **New** button on the bottom of the ML Studio window, for the output. 

You can also click the **Details** button to see an example of the returned JSON. You'll see the values you entered in the dialog along with two additional values appended to the end of these values. These are the model's evaluations of the energy efficiency for the values you passed as input.
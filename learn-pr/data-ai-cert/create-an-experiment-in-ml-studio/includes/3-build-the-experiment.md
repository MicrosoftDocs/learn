In this unit, will build out and run the experiment

1. Expand the **Data Transformation** category and then **Sample and Split** subcategory.
1. Drag a **Split Data** operation onto the designer surface.
1. In the right panel, set the Fraction of rows in the first output dataset to **0.7** to split the data at 70/30.
1. Connect the dataset to the Split Data operation by dragging the dataset handle to the Split Data operation.

    ![Adding split data](../media/3-build-the-experiment-split-data-step-small.png)

1. In the left panel, expand the **Machine Learning** category, then **Initialize Model**, and finally **Regression**.
1. Locate the **Decision Forest Regression** entry and drag it onto the designer surface.
1. In the left panel, expand the **Score** subcategory and locate the **Score Model** entry.
1. Drag the **Score Model** operation onto the designer.
1. In the left panel, expand **Train** and drag a **Train Model** operation onto the designer.
1. In the left panel, expand the **Evaluate** subcategory of Machine Learning and drag an **Evaluate Model** operation onto the designer.

    > [!TIP]
    > If you find you are running out of space in the designer surface, you can scroll the designer surface area or use your mouse wheel to zoom in or out.
    
1. Your experiment window should now look like this:

    ![Preview of workspace with all items added to the designer surface](../media/3-interim-step-surface-small.png)

1. Connect output 1 of the **Split Data** operation to the **Train Model** operation.
1. Select the **Train Model** operation.
1. Click the **Launch Column Selector** in the right pane of ML Studio.
1. Click the **With Rules** entry and then click inside the empty column list and select the **Wall Area** column name.
1. Click the check mark to accept the selection.
1. Connect the **Decision Forest Regression** operation to the remaining input of the **Train Model** operation.
1. Connect the second output of the **Split Data** operation to the **Score Model** operation.
1. Connect the output of the **Score Model** operation to the left input of the **Evaluate Model** operation.
1. Connect the output of the **Train Model** operation to the remaining **Score Model** input.
1. Your experiment should now look like this:

    ![Complete experiment with all connections made and configurations set](../media/3-all-connections-made-small.png)

1. Run the experiment by clicking the **Run** button on the bottom of the designer window.
1. Ensure that you have green check marks in all the operation boxes and that the upper right corner of the designer displays _Finished Running_ with a green check mark.
1. Save your experiment as **Energy Efficiency Regression**.

At this point, feel free to look at the data that is in the csv file to gain an understanding of what your experiment is acting on.
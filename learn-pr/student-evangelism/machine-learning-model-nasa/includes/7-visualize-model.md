One of the benefits of using a decision tree classifier is the visualization that you can use to better understand how the model makes decisions. Using `graphviz` and `pydotplus`, you can quickly see how a decision is made. In future iterations, you can see how decisions are changed.

## Create the visual tree

To create a visual representation of the model, you'll create a function that takes in as parameters:

- Data: `tree` - The machine learning model
- Columns: `feature_names` - A list of the columns in the input data
- Output: `class_names` - A list of the options for classification (in this case, yes or no)
- File name: `png_file_to_save` - The name of the file where you want to save the visualization

You'll call [scikit-learn's `export_graphviz()` function](https://scikit-learn.org/stable/modules/generated/sklearn.tree.export_graphviz.html?azure-portal=true) and then return an image representation of the graph that scikit-learn gives you.

```python
# Let's import a library for visualizing our decision tree.
from sklearn.tree import export_graphviz

def tree_graph_to_png(tree, feature_names,class_names, png_file_to_save):
    tree_str = export_graphviz(tree, feature_names=feature_names, class_names=class_names,
                                     filled=True, out_file=None)
    graph = pydotplus.graph_from_dot_data(tree_str)  
    return Image(graph.create_png())
```

Calling this function is fairly straightforward:

- Data: `tree_model` - The model you trained and tested earlier
- Columns: `X.columns.values` - The list of columns in the input
- Output: [`yes`,`no`] - The two possible outcomes
- File name: `decision_tree.png` - The name of the file where you want to save the image

```python
# This function takes a machine learning model and visualizes it.
tree_graph_to_png(tree=tree_model, feature_names=X.columns.values,class_names=['No Launch','Launch'], png_file_to_save='decision-tree.png')
```

This function creates the following image.

:::image type="content" source="../media/decision-tree.png" alt-text="Visualization of decision tree." loc-scope="azure":::

Overall, when we look at the dataset, we have 240 samples:

- 192 are no launches
- 48 are launches

This result is because of our data cleaning strategy, where we assumed all non-labeled days are no-launch days.

Using the new labels, we can say "If the wind speed was less than 1.0, then 191 of the 240 samples guessed that no launch was possible on that day."
This result might seem odd, but based on the data it's correct. Here's the evidence:
We plotted the launch versus no-launch distribution for days that the Wind Speed at Launch Time <= 1 prior to dropping the column earlier in this notebook and it shows that for nearly all times we don’t launch:

:::image type="content" source="../media/plot-launches.png" alt-text="Plot of launches versus no launches." loc-scope="azure":::

## Understand the visualization

This simple tree shows you that the most important feature of the data was `Wind Speed at Launch Time`. If the wind speed was less than 1.0, then 191 of the 240 samples were correctly guessed to be no launch. We see that 191 of those samples only needed the `Wind Speed at Launch Time` value to be less than 1.0 to correctly guess the outcome, while above 1.0 required more information.

This insight isn't good. We previously set all values that were empty to 0. We also know that many of the values that were related to the time of launch were 0 because 60% of our data wasn't related to an actual launch or attempted launch.

As you continue to look at the tree, you can see that `Max Wind Speed` is the next most important feature of the data. Here, you can see that of the remaining 49 days when the max wind speed was less than 30.5, 48 of the days yielded a correct launch output and one of them yielded a no-launch output.

This data might be more interesting with some real-world context. There was only one day where a launch was planned and the `Max Wind Speed` value was greater than 30.5, which was May 27, 2020. The Space X Dragon launch was then postponed to May 30, 2020. Here's the evidence:

```python
launch_data[(launch_data['Wind Speed at Launch Time'] > 1) & (launch_data['Max Wind Speed'] > 30.5)]
```

:::image type="content" source="../media/only-no.png" alt-text="Only launch with greater than 1.0 wind speed at launch time and greater than 30 max wind speed." loc-scope="azure":::

## Improve the results

With this visualization, you could see that some features became important. But this emphasis was based on incorrect information.

One improvement that could be made is to determine the relationship between `Max Wind Speed` and `Wind Speed at Launch Time` for the rows that have that information. Then, instead of making `Wind Speed at Launch Time` 0 for non-launch days, it could have been made to be the estimate of what it would be at a common launch time. This change might have represented the data better.

Can you think of other ways to improve the data?
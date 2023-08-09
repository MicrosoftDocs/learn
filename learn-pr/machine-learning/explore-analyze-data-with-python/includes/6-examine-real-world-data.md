Data presented in educational material is often remarkably perfect, designed to show students how to find clear relationships between variables. "Real-world" data is a bit less simple.

Because of the complexity of "real-world" data, we have to inspect raw data for issues before we use it.

As such, the best practice is to inspect the raw data and process it before use, which reduces errors or issues typically by removing erroneous data points or modifying the data into a more useful form.

## Real-world data issues

Real-world data can contain many different issues that can affect the utility of the data and our interpretation of the results.

It's important to realize that most real-world data are influenced by factors that weren't recorded at the time. For example, we might have a table of race-car track times alongside engine sizes; but various other factors that weren't written down, such as the weather, probably also played a role. If problematic, we can often reduce the influence of these factors by increasing the size of the dataset.

In other situations, data points that are clearly outside of what's expected&#8212;also known as "*outliers*"&#8212;can sometimes be safely removed from analyses, although we must take care to not remove data points that provide real insights.

Another common issue in real-world data is bias. Bias refers to a tendency to select certain types of values more frequently than others in a way that misrepresents the underlying population, or "real world". Bias can sometimes be identified by exploring data while keeping in mind basic knowledge about where the data came from.

Real-world data will always have issues, but data scientists can often overcome these issues by:

* Checking for missing values and badly recorded data.
* Considering removing obvious outliers.
* Examining what real-world factors might affect their analysis and determining if their dataset size is large enough to reduce the impact of these factors.
* Checking for biased raw data and considering their options to fix the bias, if found.

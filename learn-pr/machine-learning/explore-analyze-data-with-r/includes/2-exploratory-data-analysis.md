Exploratory Data Analysis, popularly referred to as EDA, is an iterative cycle of analyzing data sets to summarize their main characteristics, often by visualizing and transforming your data. 

Data scientists can use various tools and techniques to explore, visualize, and manipulate data. One of the most common ways in which data scientists work with data is to use the R language and some specific packages for data exploratory. One of these packages is the Tidyverse – a collection of packages that provide tooling for the most common data science challenges[1]. Some of the packages in the Tidyverse that you’ll interact with include ggplot2, dplyr and tibble. 

## Data visualization using ggplot2

ggplot2 is an R package for creating elegant graphics for data analysis. ggplot2 provides a flexible way of creating graphs by combining independent components of a graphic in a series of iterative steps. This makes ggplot2 one of the most versatile and powerful tools for making graphs in R. 

## Data transformation using dplyr 

dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges[1]. As such, dplyr enables you to transform the data into the right form that you need, to permit further analysis or visualization. 

## Storing data using data frames and tibbles 

Data frames present the most common way of storing data in R to permit analysis. The easiest way to think of a data frame is as R’s equivalent to the Excel spreadsheet, since it stores data in a similar format.  

:::image type="content" source="../media/data-frame-example.png" alt-text="Table illustrating a data frame with some sample data."::: 

Tibbles on the other hand, are modern data frames that seek to improve some of the aspects of R’s built-in data frame. The term tibble and data frame is used interchangeably in this learning path. 

## Explore data in a Jupyter notebook 

Jupyter notebooks are a popular way of running basic scripts using your web browser. Typically, these notebooks are a single webpage, broken up into text sections and code sections that are executed on the server rather than your local machine. This means you can get started quickly without needing to install R, Python or other tools. 

## Testing hypotheses 

Data exploration and analysis is typically an iterative process, in which the data scientist takes a sample of data and performs the following kinds of task to analyze it and test hypotheses: 

- **Clean data** to handle errors, missing values, and other issues. 
- **Apply statistical techniques to better understand the data**, and how the sample might be expected to represent the real-world population of data, allowing for random variation. 
- **Visualize data** to determine relationships between variables, and in the case of a machine learning project, identify features that are potentially predictive of the label. 
- Revise the hypothesis and repeat the process. 
 
[1] Hadley Wickham and others, 'Welcome to the Tidyverse', [*Journal of Open Source Software*, 2019](https://doi.org/10.21105/joss.01686).
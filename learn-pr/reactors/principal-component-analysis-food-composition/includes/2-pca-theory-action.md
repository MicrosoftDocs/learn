One way to reduce the number of dimensions we have to work with is by projecting (or converting) our feature space into a lower dimensional space. 

## PCA in theory

The reason why we can do this is that in most real-world problems, data points are not spread uniformly across all dimensions. Some features might be near constant, while others are highly correlated, which means that those data points lie close to a lower-dimensional subspace.

## An analogy

We can picture the process of PCA reducing the number of dimensions as we would, well, a picture. A picture is a two-dimensional representation of a three-dimensional world. But the reason a pixel sits where it does on a picture and looks how it looks is because of where it is on the X, Y and Z coordinates which make up the world we see. The picture isn't merely taking a two-dimensional slice, but rather consolidating three dimensions into two new dimensions.

This is especially evident in a picture with a [bokeh](https://wikipedia.org/wiki/Bokeh?azure-portal=true) effect (those pictures where the subject is in focus and everything else is blurry). The photographer has exerted a fair bit of control over how the conversion from 3-D to 2-D is going to take place. The pixels making up our subject will show as sharp, while all other pixels will be fuzzy. Basically, the photographer is drawing our eyes to what's important.

We can do the same with the dimensions (or columns) in our data, reducing the number and allowing us to focus (pun intended) on the important information.

## PCA in action

PCA behaves much in the same way, by allowing us to focus on what's important, specifically variance. Where are we seeing a spread of data? Where are we seeing change? What's truly impacting the data?

Let's take a look at an example of a three dimensional data space as represented in the image below. The data points are not spread across the entire plane, but are nicely clumped, roughly in an oval. Because the cluster (or, indeed, any cluster) is roughly elliptical, it can be mathematically described by two values: its major (long) axis and its minor (short) axis. These axes form the principal components of the cluster. Basically, this is where the magic is happening for our data.

We can **construct a whole new feature space** around this cluster, defined by two eigenvectors (the vectors that define the linear transformation to this new feature space), $c_{1}$ and $c_{2}$. Better still, we don't have to consider all of the dimensions of this new space. Intuitively, we can see that most of the points lie on or close to the line that runs through $c_{1}$. So, if we project the cluster down from two dimensions to that single dimension, we capture most of the information about this data sense while simplifying our analysis. This ability to extract most of the information from a dataset by considering only a fraction of its definitive eigenvectors forms the heart of principal component analysis (PCA).

> [!div class="alert is-tip"]
> ### Takeaway
>
> Even just by looking at the metadata about the information in a DataFrame or the first and last few values in one, you can get an immediate idea about the size, shape, and content of the data you are dealing with.
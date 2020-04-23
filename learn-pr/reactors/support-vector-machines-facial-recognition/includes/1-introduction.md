Support Vector Machines (SVM)
Support Vector Machines, or SVMs, can often do better than other models at fitting data — especially data is that is highly non-linear. SVM models use kernels to draw complex boundaries around sets of like data points. The diagram on the left in the illustration below shows a 2D set of data points that a linear model will not fit. In other words, there is no line you can draw to separate the blue points from the green points. However, SVM can use a "kernel trick" to add a third dimension to each data point based on its distance from the center. In 3D space (below right), you can then draw a plane that cleanly separates the two classes of data points.



That's a simple way to visualize how Support Vector Machines work. Let's learn about SVM by using the Labeled Faces in the Wild (LFW) dataset that is provided with scikit-learn to build a facial-recognition model.


PCA reduces the number of dimensions in a dataset from _m_ to _n_, often without incurring a commensurate loss of information. For example, it might reduce the number of dimensions by 50% but retain 90% of the information in the original dataset. Think of a world globe projected onto a sheet of paper to create a world map. The 2-D map contains almost all of the information that the 3-D globe does, but it has one-third fewer dimensions.

It is possible that using PCA to reduce the number of columns ("features") in the dataset will increase the accuracy of the model by reducing the amount of information in each facial image, effectively filtering out the "noise" of too much detail. A pleasant side effect is that the model should train faster, too. Let's build a pipeline that performs a PCA transform on the input data, reducing 2,914 columns to 150, and uses an SVM classifier to fit a model to the training data.

> [!NOTE]
> Pipelines are a handy mechanism in scikit-learn for building complex models that transform input data before using it to train or predict.

```python
from sklearn.decomposition import PCA
from sklearn.pipeline import make_pipeline

pca = PCA(n_components=150, whiten=True, svd_solver='randomized', random_state=42)
svc = SVC(class_weight='balanced', gamma='auto')
model = make_pipeline(pca, svc)
model.fit(x_train, y_train)
```

The output is:

```Output
Pipeline(memory=None,
     steps=[('pca', PCA(copy=True, iterated_power='auto', n_components=150, random_state=42,
  svd_solver='randomized', tol=0.0, whiten=True)), ('svc', SVC(C=1.0, cache_size=200, class_weight='balanced', coef0=0.0,
  decision_function_shape='ovr', degree=3, gamma='auto', kernel='rbf',
  max_iter=-1, probability=False, random_state=None, shrinking=True,
  tol=0.001, verbose=False))])
```

Now let's score the model again.

```python
model.score(x_test, y_test)
```

The output is `0.9122807017543859`.

That's _much_ better! Is it intuitive why using PCA to eliminate almost 95% of the data in each facial image increased the accuracy of the model? If not, try running the code below to visualize what the faces look like after they're PCAed. Then compare the resulting facial images to the ones above. Do you see the difference? _Now_ is it obvious why PCA had such a dramatic effect on the model?

```python
transformed = pca.transform(faces.data)
restored = pca.inverse_transform(transformed).reshape(1140, 62, 47)

fig, ax = plt.subplots(3, 8, figsize=(18, 10))
for i, axi in enumerate(ax.flat):
    axi.imshow(restored[i], cmap='gist_gray')
    axi.set(xticks=[], yticks=[], xlabel=faces.target_names[faces.target[i]])
```

Here's the output:

:::image type="content" alt-text="A panel of 24 greyscale photos of five famous political leaders, but with some faces blurry and undefined" source="../media/faces2.png" loc-scope="Azure":::

One of the more interesting aspects of PCA is that if you use it to reduce the number of dimensions (components) from 500 to 100, the 400 dimensions that it eliminates are the ones that add the least information to the model. It inherently sorts the components by relevance and keeps the most important ones. This is the primary reason why a 50% reduction in a dataset's dimensions doesn't necessarily mean a 50% loss of information.

### Try it yourself

Because the LFW dataset contains images, it affords us a great opportunity to visualize the effects of PCA. The PCA transformation above reduced the number of dimensions from 2,914 to 150, and yet you could still recognize the faces in the image. In the next cell, try decreasing the number of dimensions to 100, 50, 25, and even fewer. At what point do the faces become unrecognizable?

<br />

<details>

<summary>Hint <i>(expand to reveal)</i></summary>

The task is to add code to transform <code>faces.data</code> with <code>pca2</code>, and then invert the transform and plot the results to see how much information was discarded.

Hint: Set <code>n_components</code> to the number of dimensions you want the dataset reduced to. Then, call <code>transform()</code> and <code>inverse_transform()</code> on <code>pca2</code>. Copy and paste the code in the preceding code cell to render the results.
   
In a possible solution, the input is: 

```python
pca2 = PCA(n_components=100, whiten=True, svd_solver='randomized', random_state=42)
pca2.fit(faces.data)
```

The output is:

```Output
PCA(copy=True, iterated_power='auto', n_components=100, random_state=42,
  svd_solver='randomized', tol=0.0, whiten=True)
```

</details>

<br /><br />

*** 

Next, let's tune the hyperparameters. Then, we'll cross-validate the model.

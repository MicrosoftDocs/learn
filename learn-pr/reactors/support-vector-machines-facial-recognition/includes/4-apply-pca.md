PCA reduces the number of dimensions in a dataset from m to n, often without incurring a commensurate loss of information. For example, it might reduce the number of dimensions by 50% but retain 90% of the information in the original dataset. Think of a world globe projected onto a sheet of paper to create a world map. The 2D map contains almost all of the information that the 3D globe does, but it has 1/3rd fewer dimensions.

It is possible that using PCA to reduce the number of columns ("features") in the dataset will increase the accuracy of the model by reducing the amount of information in each facial image, effectively filtering out the "noise" of too much detail. A pleasant side effect is that the model should train faster, too. Let's build a pipeline that performs a PCA transform on the input data, reducing 2,914 columns to 150, and uses an SVM classifier to fit a model to the training data.

Pipelines are a handy mechanism in scikit-learn for building complex models that transform input data before using it to train or predict.

```python
from sklearn.decomposition import PCA
from sklearn.pipeline import make_pipeline

pca = PCA(n_components=150, whiten=True, svd_solver='randomized', random_state=42)
svc = SVC(class_weight='balanced', gamma='auto')
model = make_pipeline(pca, svc)
model.fit(x_train, y_train)
```

```output
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

```output
0.9122807017543859
```

That's much better! Is it intuitive why using PCA to eliminate almost 95% of the data in each facial image increased the accuracy of the model? If not, try running the code below to visualize what the faces look like after they're PCAed. Then compare the resulting facial images to the ones above. Do you see the difference? Now is it obvious why PCA had such a dramatic effect on the model?

```python
transformed = pca.transform(faces.data)
restored = pca.inverse_transform(transformed).reshape(1140, 62, 47)

fig, ax = plt.subplots(3, 8, figsize=(18, 10))
for i, axi in enumerate(ax.flat):
    axi.imshow(restored[i], cmap='gist_gray')
    axi.set(xticks=[], yticks=[], xlabel=faces.target_names[faces.target[i]])
```

Here's something else to consider. How is it possible that eliminating almost 95% of the data in a facial dataset retains enough information that you can still recognize the faces? And what does that tell you about PCA?

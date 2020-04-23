PCA in practice
It is finally time to perform the PCA on our data. (As stated before, even with pretty clean data, a lot of effort has to go into preparing the data for analysis.)

In [ ]:
fit = PCA()
pca = fit.fit_transform(nutr_df_TF)
So, now that we have peformed the PCA on our data, what do we actually have? Remember that PCA is foremost about finding the eigenvectors for our data. We then want to select some subset of those vectors to form the lower-dimensional subspace in which to analyze our data.

Let's take a look at a scatter plot created by the first two components. We can already see some clustering, which we'll be able to better represent when we get towards the end.

In [ ]:
plt.scatter(pca[:,0], pca[:,1], alpha='.1')
plt.xlabel('C1')
plt.ylabel('C2')
plt.title('Collapsed data')
Not all of the eigenvectors are created equal. Just a few of them will account for the majority of the variance in the data. (Put another way, a subspace composed of just a few of the eigenvectors will retain the majority of the information from our data.) We want to focus on those vectors.

To help us get a sense of how many vectors we should use, consider this scree graph of the variance for the PCA components, which plots the variance explained by the components from greatest to least.

In [ ]:
plt.plot(fit.explained_variance_ratio_)
This is where data science can become an art. As a rule of thumb, we want to look for "elbow" in the graph, which is the point at which the few components have captured the majority of the variance in the data (after that point, we are only adding complexity to the analysis for increasingly diminishing returns). In this particular case, that appears to be at about five components.

We can take the cumulative sum of the first five components to see how much variance they capture in total.

In [ ]:
print(fit.explained_variance_ratio_[:5].sum())
So our five components capture about 70 percent of the variance. We can see what fewer or additional components would yield by looking at the cumulative variance for all of the components. You can see increasing to 6 components would cover an additional 3 percentage points over the first 5, and there's an ever-diminisioning return.

In [ ]:
fit.explained_variance_ratio_.cumsum()
We can also examine this visually.

In [ ]:
plt.plot(np.cumsum(fit.explained_variance_ratio_))
plt.title("Cumulative Explained Variance Graph")
Ultimately, it is a matter of judgment as to how many components to use, but five vectors (and 70 percent of the variance) will suffice for our purposes in this section.

To aid further analysis, let's now put those five components into a DataFrame.

In [ ]:
pca_df = pd.DataFrame(pca[:, :5], index=desc_df.index)
pca_df.head()
Each column represents one of the eigenvectors, and each row is one of the coordinates that defines that vector in five-dimensional space.

We will want to add the FoodGroup column back in to aid with our interpretation of the data later on. Let's also rename the component-columns $c_{1}$ through $c_{5}$ so that we know what we are looking at.

In [ ]:
pca_df = pca_df.join(desc_df)
pca_df.drop(['FoodGroup', 'GmWt_Desc1', 'GmWt_2', 'GmWt_Desc2', 'Refuse_Pct', 'Shrt_Desc'], axis=1, inplace=True)
pca_df.rename(columns={0:'c1', 1:'c2', 2:'c3', 3:'c4', 4:'c5'}, inplace=True)
Don't worry that the FoodGroup column has all NaN values: it is not a vector, so it has no vector coordinates.

One last thing we should demonstrate is that each of the components is mutually perpendicular (or orthogonal in math-speak). One way of expressing that condition is that each component-vector should perfectly correspond with itself and not correlate at all (positively or negatively) with any other vector.

In [ ]:
np.round(pca_df.corr(), 5)
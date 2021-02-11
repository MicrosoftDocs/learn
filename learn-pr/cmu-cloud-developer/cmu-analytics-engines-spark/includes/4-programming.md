Now that we have seen the architecture and the computation flow of Spark, it makes sense to look at a simple Spark program. Before doing that, we still need to understand some of the common primitive RDD operations. 

We start with some basic single-RDD transformations `(RDD1 = {1,2,3,3})`:

| Function name | Purpose | Example | Result |
|---|---|---|---|
| `map()`      | Apply a function to each element in the RDD and return an RDD of the result. | `rdd.map(x => x + 1)` | `{2, 3, 4, 4}` |
| `flatMap()`  | Apply a function to each element in the RDD and return an RDD of the contents of the iterators returned. Often used to extract words. | `rdd.flatMap(x => x.to(3))` | `{1, 2, 3, 2, 3, 3, 3}` |
| `filter()`   | Return an RDD consisting of only elements that pass the condition passed to `filter()`. | `rdd.filter(x => x != 1)` | `{2, 3, 3}` |
| `distinct()` | Remove duplicates.| `rdd.distinct()` | `{1, 2, 3}` |


Transformations can also have more than one RDD as the input. Here we look at transformations having two RDDs as the input `(RDD1 = {1,2,3}; RDD2 = {3,4,5})`: 

| Function name | Purpose | Example | Result |
|---|---|---|---|
| `union()`        | Produce an RDD containing elements from both RDDs. | `rdd.union(other)` | `{1, 2, 3, 3, 4, 5}` |
| `intersection()` | RDD containing only elements found in both RDDs. | `rdd.intersection(other)` | `{3}` |
| `subtract()`     | Remove the contents of one RDD (e.g., remove training data). | `rdd.subtract(other)` | `{1, 2}` |
| `cartesian()`    | Cartesian product with the other RDD. | `rdd.cartesian(other)` | `{(1, 3), (1, 4), … (3,5)}` |

Finally, we look at some actions, again on a single RDD = `{1,2,3,3}`:

| Function name | Purpose | Example | Result |
|---|---|---|---|
| `collect()`                  | Return all elements from the RDD. | `rdd.collect()`| `{1, 2, 3, 3}` |
| `count()`                    | Number of elements in the RDD. | `rdd.count()` | `4` |
| `countByValue()`             | Number of times each element occurs in the RDD. | `rdd.countByValue()` | `{(1, 1), (2, 1), (3, 2)}` |
| `take(num)`                  | Return numelements from the RDD. | `rdd.take(2)` | `{1, 2}` |
| `top(num)`                   | Return the top numelements the RDD. | `rdd.top(2)` | `{3, 3}` |
| `takeOrdered(num)(ordering)` | Return numelements based on provided ordering. | `rdd.takeOrdered(2)(myOrdering)` | `{3, 3}` |
| `reduce(func)`               | Combine the elements of the RDD together in parallel (e.g., sum). | `rdd.reduce((x, y) => x + y)` | `9` |
| `fold(zero)(func)`           | Same as `reduce()` but with the provided zero value. | `rdd.fold(0)((x, y) => x + y)` | `9` |
| `aggregate(zeroValue)(seqOp, combOp)` | Similar to `reduce()` but used to return a different type. | `rdd.aggregate((0, 0)) ((x, y) =>(x._1 + y, x._2 + 1), (x, y) =>(x._1 + y._1, x._2 + y._2))` | `(9, 4)` |

Now that we have studied some primitives, let us see how all these operations fit together to implement a simple program. We explore the implementation of an iterative PageRank algorithm on Spark. 

The PageRank algorithm iteratively updates a rank for each URL by adding contributions from URLs that link to it. PageRank assumes that a web surfer starting on a random page has an 85% chance to select a random link from their current page, and a 15% chance to jump to a random page anywhere on the internet.

On each iteration, each URL contributes r/n to its neighbors, where *r* is its own rank, and *n* is the number of neighbors of that node. It then updates its rank to $\frac{a}{N} + (1 - a) \sum c_{i}$, where $\sum c_{i}$ is the sum of all received contributions and $N$ is the total number of documents. $a$ indicates the probability that a random surfer starting from a webpage will stop clicking through. This is known as the damping factor (as mentioned above, studies have found it to have a probability of about 0.85).

Consider the following PageRank Scala program: 

``` java
val links = spark.textFile(...).map(...).persist()
var ranks = // RDD of (URL, rank) pairs
for (i &lt;- 1 to ITERATIONS) 
{
	// Build an RDD of (targetURL, float) pairs
	// with the contributions sent by each page
	val contribs = links.join(ranks).flatMap 
	{
		(url, (links, rank)) =&gt;
		links.map(dest =&gt; (dest, rank/links.size))
	}

	// Sum contributions by URL and get new ranks
	ranks = contribs.reduceByKey((x,y) =&gt; x+y).mapValues(sum =&gt; a/N + (1-a)*sum)
}
```

In this Spark implementation of PageRank, our input dataset consists of a text file of the format `(URL, rank)`. For each iteration, a join operation on `links` and `ranks` is used to aggregate the contribution for each URL. The `contribs` RDD represents the contribution sent by each URL. These are summed up over each key (using a reduce), and this value is then updated using the PageRank formula $\frac{a}{N} + (1 - a) \sum c_{i}$. After the `ranks` RDD is updated, the process repeats again for the number of iterations specified. 

![Lineage graph for the Spark PageRank example](../media/pagerank.png)

_Figure 6: Lineage graph for the Spark PageRank example_

As we mentioned on the previous page, the join operation can be optimized to reduce communication by partitioning the links and the ranks in the same way (for example, using a hash partitioner to partition URLs across nodes). If each link partition and its corresponding rank partition are on the same node, we can eliminate cross-node communication entirely for the join. 

Notice in the previous figure, the lineage of the ranks RDD in each iteration keeps increasing. Hence, it may be important to adopt a strategy to persist some of the versions of ranks for better fault recovery.

Decisions about partitioning, persistence, and choosing the optimal set of operations to define a computation are some of the features that make developing optimal Spark programs challenging. However, if implemented correctly, Spark jobs can have a huge speedup over traditional MapReduce jobs. 

<!-- References not cited in topic. Removed references. -->

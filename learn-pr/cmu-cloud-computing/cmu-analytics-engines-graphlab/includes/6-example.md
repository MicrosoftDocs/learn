In this unit, we explore the abstraction of GraphLab by walking through the PageRank example. The PageRank algorithm is a well-known technique invented by Google to rank the importance of website pages returned by the search engine. Using the assumption that more important websites are likely to receive more links from other important websites, it determines the importance of a page by counting the number and quality of links pointed to that page. 

PageRank has various implementations, but its idea can be demonstrated with the following equation: 

$$R[i] = 0.15 + \sum_{j \in Nbr(i)}{w_{ji}} \times R[j]$$

$R[i]$ represents the PageRank value of page $i$. $Nbr(i)$ is the set of pages pointing to page $i$. And $w_{ji}$ is a weight associated with this link, which is normally defined as the inverse of page $j$'s outdegree.

As you may have noticed, the above equation is recursive, so the PageRank values of different pages may be mutually dependent on each other. Therefore, the computing process of PageRank often starts with a set of initial values, and each page iteratively applies the above equation to update its value until reaching convergence. 

To perform this algorithm with GraphLab, we first map the problem to a graph-based abstraction. For PageRank, this should be intuitive; the vertices of the graph correspond to pages, and edges correspond to links of the pages. We also add a per-vertex parameter, the rank of the page, denoted as $R[i]$. Now that the data is represented in GraphLab, we decompose the operation expressed in the PageRank equation to Gather, Apply, Scatter steps in GraphLab's abstraction: 

> [!div class="alert is-tip"]
> **Algorithm 3**
>
> PageRank $(i)$ algorithm on GraphLab, executing on page $i$
> 
> - **Gather $(j, i)$** Function:
>   - return $w_{ji} \times R[j]$
> - **Sum $(a, b)$** Function:
>   - return $(a + b)$
> - **Apply $(i, \Sigma)$** Function:
>    - $R[i] = 0.15 + \Sigma$
> - **Scatter $(i, j)$** Function:
>    - if $R[i]$ changed, then trigger $j$ to be recomputed (to be made active)
>

In the Gather phase, page $i$ goes through each of its in-edges and gathers the corresponding values from its neighbors. The gathered values will be accumulated using the Sum function, which simply adds all the in-edge values in this algorithm. Next, page $i$ performs the Apply function to update its PageRank value to the sum of **0.15** and the aggregated result. Finally, it checks if the updated PageRank is different from the previous one, and goes through each out-edge to trigger the recomputation of its neighbors if the PageRank value is changed. PageRank will iteratively run the GAS functions defined above for all active vertices until the values do not change beyond a certain threshold. When there are no more active vertices, the algorithm is said to have **converged** to the required result.

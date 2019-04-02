<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_7_summary.xml -->

In this section, we explore the abstraction of GraphLab by walking through the PageRank example. The PageRank algorithm is a well-known technique proposed by Google. It is used by Google to rank the importance of website pages returned by their search engine. Using the assumption that more important websites are likely to receive more links from other important websites, it determines the importance of a page by counting the number and quality of links pointed to that page. 

PageRank has various implementations, but its idea can be demonstrated with the following equation: R[i] =0.15 +sumjisinNbr(i)wjitimesR[j]

where R[i] represents the PageRank value of page i, Nbr(i) is the set of pages pointing to page i and wji is a weight associated with this link, which is normally defined as the inverse of page j’s outdegree.

As you may have noticed, the above equation is recursive, the PageRank value of different pages may mutually dependent on each other. Therefore, the computing process of PageRank often starts with a set of initial values, and each page iteratively applies the above equation to update its value until reaching convergence. 

To perform this algorithm with GraphLab, we first map the problem to a graph-based abstraction. For PageRank, this should be intuitive; the vertices of the graph correspond to pages and edges correspond to links of the pages. We also add a per-vertex parameter, the rank of the page, denoted as _R[i]_. Now that the data is represented in GraphLab, we decompose the operation expressed in the PageRank equation to Gather, Apply, Scatter steps in GraphLab’s abstraction: 


______________________________________________________________________________________

_Algorithm 3:_ PageRank(i) Algorithm on GraphLab, executing on page i

______________________________________________________________________________________

- _Gather(_j,i _)_ Function:
    - return wjitimesR[j]

- _Sum(_a,b _)_ Function:
    - return a+b

- _Apply(_i,Sigma _)_ Function:
    - R[i]=0.15+sum

- _Scatter(_i,j _)_ Function:
    - if R[i] changed, then trigger j to be recomputed (to be made active)


______________________________________________________________________________________


In the Gather phase, page _i_ goes through each of its in-edges, and gathers the corresponding values from its neighbors. The gathered values will be accumulated using the Sum function, which simply adds all the in-edge values in this algorithm. Next, page _i_ performs Apply function to update its PageRank value to the sum of _0.15_ and the aggregated result. Finally, it checks if the updated PageRank is different from the previous one, and goes through each out-edge to trigger the recomputation of its neighbors if the PageRank value is changed. Pagerank will iteratively run the GAS functions defined above for all active vertices until the values do not change beyond a certain threshold. When there are no more active vertices, the algorithm is said to have _converged_ to the required result.
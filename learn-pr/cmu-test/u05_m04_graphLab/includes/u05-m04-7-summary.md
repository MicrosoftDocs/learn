<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u05_distributed_programming_analytics_engines\_u05_m04_graphLab\x-oli-workbook_page\_u05_m04_7_summary.xml -->

In this section, we explore the abstraction of GraphLab by walking through the PageRank example. The PageRank algorithm is a well-known technique proposed by Google. It is used by Google to rank the importance of website pages returned by their search engine. Using the assumption that more important websites are likely to receive more links from other important websites, it determines the importance of a page by counting the number and quality of links pointed to that page. 

PageRank has various implementations, but its idea can be demonstrated with the following equation: 
<!-- TODO fix
<m:math display="block" xmlns:m="m"><m:mrow><m:mi>R</m:mi><m:mo stretchy="false">[</m:mo><m:mi>i</m:mi><m:mo lspace="0px" rspace="0px">] =</m:mo><m:mn>0</m:mn><m:mo>.</m:mo><m:mn>15</m:mn><m:mo fontfamily="Times New Roman" lspace="0px" rspace="0px"> +</m:mo><m:mrow><m:munder><m:mo>sum</m:mo><m:mrow><m:mi>j</m:mi><m:mo lspace="2px" rspace="2px">isin</m:mo><m:mi>Nbr</m:mi><m:mo fence="false" stretchy="false">(</m:mo><m:mi>i</m:mi><m:mo fence="false" stretchy="false" form="infix">)</m:mo></m:mrow></m:munder><m:mrow><m:mi>w</m:mi><m:mi mathsize="small">ji</m:mi><m:mtext fontfamily="Times New Roman" mathsize="small"></m:mtext><m:mo lspace="2px" rspace="2px">times</m:mo><m:mi>R</m:mi><m:mo fence="false" stretchy="false">[</m:mo><m:mi>j</m:mi><m:mo fence="false" stretchy="false" form="infix">]</m:mo></m:mrow></m:mrow><m:mo fontfamily="Times New Roman"></m:mo></m:mrow></m:math>
-->



where 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>R</m:mi><m:mo stretchy="false">[</m:mo><m:mi>i</m:mi><m:mo fence="false" stretchy="false" form="infix">]</m:mo></m:mrow></m:math>
-->

 represents the PageRank value of page 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>i</m:mi></m:mrow></m:math>
-->

, 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>Nbr</m:mi><m:mo fence="false" stretchy="false">(</m:mo><m:mi>i</m:mi><m:mo fence="false" stretchy="false" form="infix">)</m:mo></m:mrow></m:math>
-->

 is the set of pages pointing to page 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>i</m:mi></m:mrow></m:math>
-->

 and 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>w</m:mi><m:mi mathsize="small">ji</m:mi><m:mtext mathsize="small"></m:mtext></m:mrow></m:math>
-->

 is a weight associated with this link, which is normally defined as the inverse of page 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>j</m:mi></m:mrow></m:math>
-->

’s outdegree.

As you may have noticed, the above equation is recursive, the PageRank value of different pages may mutually dependent on each other. Therefore, the computing process of PageRank often starts with a set of initial values, and each page iteratively applies the above equation to update its value until reaching convergence. 

To perform this algorithm with GraphLab, we first map the problem to a graph-based abstraction. For PageRank, this should be intuitive; the vertices of the graph correspond to pages and edges correspond to links of the pages. We also add a per-vertex parameter, the rank of the page, denoted as _R[i]_. Now that the data is represented in GraphLab, we decompose the operation expressed in the PageRank equation to Gather, Apply, Scatter steps in GraphLab’s abstraction: 


______________________________________________________________________________________

_Algorithm 3:_ PageRank(i) Algorithm on GraphLab, executing on page i

______________________________________________________________________________________

- _Gather(_j,i _)_ Function:
    - return 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>w</m:mi><m:mi mathsize="small">ji</m:mi><m:mtext mathsize="small"></m:mtext><m:mo lspace="2px" rspace="2px">times</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>R</m:mi><m:mo stretchy="false">[</m:mo><m:mi>j</m:mi><m:mo stretchy="false">]</m:mo></m:mrow></m:math>
-->



- _Sum(_a,b _)_ Function:
    - return 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>a</m:mi><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo>+</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mi>b</m:mi></m:mrow></m:math>
-->



- _Apply(_i,Sigma _)_ Function:
    - 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>R</m:mi><m:mo stretchy="false">[</m:mo><m:mi>i</m:mi><m:mo stretchy="false">]</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo>=</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mn>0.15</m:mn><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo>+</m:mo><m:mtext fontfamily="Times New Roman"></m:mtext><m:mo rspace="2px" largeop="false">sum</m:mo></m:mrow></m:math>
-->



- _Scatter(_i,j _)_ Function:
    - if 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>R</m:mi><m:mo stretchy="false">[</m:mo><m:mi>i</m:mi><m:mo stretchy="false">]</m:mo></m:mrow></m:math>
-->

 changed, then trigger 
<!-- TODO fix
<m:math display="inline" xmlns:m="m"><m:mrow><m:mi>j</m:mi></m:mrow></m:math>
-->

 to be recomputed (to be made active)


______________________________________________________________________________________


In the Gather phase, page _i_ goes through each of its in-edges, and gathers the corresponding values from its neighbors. The gathered values will be accumulated using the Sum function, which simply adds all the in-edge values in this algorithm. Next, page _i_ performs Apply function to update its PageRank value to the sum of _0.15_ and the aggregated result. Finally, it checks if the updated PageRank is different from the previous one, and goes through each out-edge to trigger the recomputation of its neighbors if the PageRank value is changed. Pagerank will iteratively run the GAS functions defined above for all active vertices until the values do not change beyond a certain threshold. When there are no more active vertices, the algorithm is said to have _converged_ to the required result.
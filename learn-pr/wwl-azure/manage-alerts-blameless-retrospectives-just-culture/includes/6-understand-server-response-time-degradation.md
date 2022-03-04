The response time degradation notification tells you:

 -  The response time compared to normal response time for this operation.
 -  How many users are affected?
 -  Average response time and 90th percentile response time for this operation on the day of the detection and seven days before.
 -  Count of this operation requests on the day of the detection and seven days before.
 -  Correlation between degradation in this operation and degradations in related dependencies.
    
     -  Links to help you diagnose the problem.
        
         -  Profiler traces to help you view where operation time is spent (the link is available if Profiler trace examples were collected for this operation during the detection period).
         -  Performance reports in Metric Explorer, where you can slice and dice time range/filters for this operation.
         -  Search for this call to view specific call properties.
         -  Failure reports - If count &gt; 1 it means that there were failures in this operation that might have contributed to performance degradation.

We'll run some performance tests against the application as it is currently configured.


## Perform load test against application

1. On the home page for your deployed application, click the **Send Requests** button. This simulates the submission of 100 requests through the applicaiton.

1. You'll see results.

    ![Screenshot of the Drone Delivery web site after running the performance test](../media/5-performance-test.png)

Fabrikam suspects that the monolithic architecture is preventing heavily utilized services from scaling, leading to the poor performance seen here. Let's see if we can identify the bottleneck and improve the performance of the application.

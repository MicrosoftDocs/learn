You now have all the tools you need to build up confidence in your deployment before it gets executed. Once deployed however, it would also be useful to check whether what you expect to have been deployed to also be there in your environment. 

In this unit you will learn about the extra functional tests you can run after deployment and how you can rollback your deployment in case things don't turn out as expected. 

## Testing your resources once they're deployed

Once your deployment succeeded successfully, you may want to check if everything has been set up and is working as expected. This can be done through functional tests, which test the actual functioning of your application. They give you the confidence that the deployment actually executed as expected. 

A functional test might be, where you try and reach the web application you just deployed and check that you get back a 200 status code. Or it might be connecting to the datebase you deployed and running a basic query. It might also be creating a transaction and observing the outputs. 

<TODO>


## Rolling back and rolling forward

In case the changes you made are not as you expected, there is always the option to rollback to the last version that you deployed. 



1. Task 4 concepts
    1. Why is it important to run functional tests?
    1. Types of functional tests that you might run
    1. Rolling back and rolling forward


   - The importance of testing your resources once they're deployed
   - Some common approaches to testing
       - Invoking HTTP endpoints and inspecting the response code, body, etc
       - Connect to a database, run a basic query
       - Create a synthetic transaction and observe the outputs
    - Load testing, automated penetration testing, and other forms of testing that you can add
    - Rolling back and rolling forward
        - Rolling back by re-executing the pipeline, or re-running the last successful deployment
        - Complexities of rollback when you have other components, especially those with state
        - Rolling forward
Blue-green deployment is a technique that reduces risk and downtime by running two identical environments. These environments are called blue and green.

Only one of the environments is live, with the live environment serving all production traffic.

:::image type="content" source="../media/blue-green-new-58f05eb7.png" alt-text="Diagram showing blue-green deployment.":::


For this example, blue is currently live, and green is idle.

As you prepare a new version of your software, the deployment and final testing stage occur in an environment that isn't live: in this example, green. Once you've deployed and thoroughly tested the software in green, switch the router or load balancer so all incoming requests go to green instead of blue.

Green is now live, and blue is idle.

This technique can eliminate downtime because of app deployment. Besides, blue-green deployment reduces risk: if something unexpected happens with your new version on the green, you can immediately roll back to the last version by switching back to blue.

When it involves database schema changes, this process isn't straightforward. You probably can't swap your application. In that case, your application and architecture should be built to handle both the old and the new database schema.

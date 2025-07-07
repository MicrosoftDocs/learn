## Lab scenario
In this lab, you create a Traffic Manager profile to deliver high availability for the fictional Contoso Ltd organization's web application.

You create two instances of a web application deployed in two different regions (East US and West Europe). The East US region is the primary endpoint for Traffic Manager, and the West Europe region is the failover endpoint.

Then you create a Traffic Manager profile based on endpoint priority. This profile directs user traffic to the primary site running the web application. Traffic Manager continuously monitors the web application, and if the primary site in East US is unavailable, it provides automatic failover to the backup site in West Europe.

## Architecture diagram

:::image type="content" source="../media/6-exercise-create-traffic-manager-profile-using-azure-portal.png" alt-text="Screenshot of the traffic manager profile pointed to two app service plans.":::

## Job skills

- Create web apps.
- Create a Traffic Manager profile.
- Add Traffic Manager endpoints.
- Test the Traffic Manager profile.


> [!IMPORTANT]
> Estimated time: 35 minutes. 
> To complete this exercise, you need an [Azure subscription](https://azure.microsoft.com/free/).

Launch the exercise, and follow the instructions. When finished, be sure to return to this page so you can continue learning.

[![Button to launch exercise.](../media/launch-exercise.png)](https://microsoftlearning.github.io/AZ-700-Designing-and-Implementing-Microsoft-Azure-Networking-Solutions/Instructions/Exercises/M04-Unit%206%20Create%20a%20Traffic%20Manager%20profile%20using%20the%20Azure%20portal.html)

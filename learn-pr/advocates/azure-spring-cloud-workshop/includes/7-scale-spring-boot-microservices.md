Spring Boot microservices and gateways running inside Azure Spring Cloud can be scaled vertically or horizontally:

- Vertical scaling means you increase (or decrease) the CPU and RAM of a given service.
- Horizontal scaling means you can add (or remove) nodes for a given service.

## Scaling the "todo-service" microservice

1. Go to [the Azure portal](https://portal.azure.com/?WT.mc_id=azurespringcloud-mslearn-judubois).
1. Go to the overview page of your Azure Spring Cloud cluster and select "Apps" in the menu.
1. Select the "todo-service" application.
1. Select "Scale" in the left hand-side menu.
1. You can now scale your service horizontally, for example you can give it 2 CPUs and 4 Gb of RAM.
1. You can also scale your service vertically, for example you can set the instance count to 6.

![Scaling](../media/7-scaling.png)

The decision to use a container orchestration platform like Kubernetes depends on several aspects that pivot around business and development requirements. Let's review the high-level architecture of your drone tracking solution.

The drone tracking solution is built as microservices that are designed as loosely coupled, collaborative services. You're deploying these services separately from each other to simplify the solution's design and maintenance. Here is the current design of your solution.

**[Diagram of the high-level architecture that describes the drone tracking solution.]**

- A drone tracking website that includes maps and information about tracked assets

- A cache services that store frequent requested information displayed on the website

- A RESTFul API where tracked drones send data about the drone status, such as a GPS location and battery charge levels

- A queue that holds unprocessed data collected by the RESTful API

- A data processing service that fetches and processes data from the queue

- A NoSQL database that stores processed tracking data and user information captured from the website and data processing service

These services are developed and owned by separate teams in your company. Each team uses containers to build and deploy their service. This new application development strategy allows the developer teams to keep up with the requirements of modern software development, for automation, testing, and overall stability and quality of software.

The change in developer thinking has also resulted in several processes and business benefits for the company. For example, better use of hosted compute resources, new features have improved time to market, and the ability to reach more customers.

However, several container management challenges that lead your company to investigate container orchestration solutions.

For example, your teams found that scaling the tracking application to a handful of deployments was relatively easy, but to scale and manage many instances is hard. Several other aspects also need consideration, for example, dealing with failed containers, container storage allocation, container network configuration, application secrets management, and so on.

As you've seen earlier, Kubernetes provides support for all of these challenges as an orchestration platform.

Use Kubernetes when your company:

- Develops applications as microservices
- Develop applications as cloud-native applications
- Deploys microservices using containers
- Updates containers at scale
- Needs to manage containers at scale

## When not to use Kubernetes

Not all applications need to run in Kubernetes, and as a result, Kubernetes may not be a good fit for your company. For example, if your application uses a monolithic architecture, the effort in containerizing the implementation and deployment to Kubernetes may cost more than the benefits of running the application in Kubernetes. A monolithic architecture can't easily make use of features such as individual component scaling or updates.

Kubernetes can introduce many business benefits for software development, deployment, management, and streamlining of processes. However, Kubernetes has a steep learning curve. The modular design of Kubernetes introduces potentially new concepts that will affect teams across your company.

For example, your development teams have to embrace modern design concepts such as microservices and containerization when developing apps and operations teams have to experiment with container and orchestration environments.

If your company isn't ready to adopt this change, then Kubernetes may not be a good fit.

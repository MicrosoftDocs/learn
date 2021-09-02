You microservice may come under heavy load during certain times of the day. Instead of having to manually spin up another container instance yourself, Kubernetes makes it easy to add additional instances.

1. Run the following command to scale the backend microservice to 5 instances.

    ```bash
    kubectl scale --replicas=5 deployment/pizzabackend
    ```

    The reason we need to specify **deployment/pizzabackend** instead of just **pizzabackend** is because we're scaling the entire Kubernetes deployment of the pizza backend service, and that will scale the instances of the individual pods accordingly.

1. To verify 5 instances are up and running, run this command.

    ```bash
    kubectl get pods
    ```

    Once all the instances are spun up, you should see 5 pod instances (represented as individual rows) in the output. Each row will start with **pizzabackend** and then be followed by a random string.

1. To scale the instance back down, run the following.

    ```bash
    kubectl scale --replicas=1 deployment/pizzabackend
    ```

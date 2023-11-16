One of the benefits of Kubernetes is the support for declarative configuration management. The services you define in the configuration files will be retained at all costs.

This means that if there's a failure, Kubernetes automatically restarts the services that were running before the failure.

Let's see this resilience in action by deleting the `storefrontend` pod and then verifying that Kubernetes restarted it.

1. First, in the **TERMINAL** on the codespace, run `kubectl get pods` and note the name, including the random string, of the `storefrontend` pod. Here's an example output:

    ```bash
    @user-name /workspaces/eShopLite % kubectl get pods

    NAME                             READY   STATUS    RESTARTS   AGE
    productsbackend-7445bdb5c9-pnpk6 1/1     Running   0          31m
    storefrontend-5b6cc765c4-hjpx4   1/1     Running   0          63m
    ```

2. Now, delete the `storefrontend` pod by using the `kubectl delete` command. You need to specify the full name of the pod, including the random string.

    ```bash
    kubectl delete pod storefrontend-5b6cc765c4-hjpx4
    ```

    You'll receive a message immediately stating the pod has been deleted.

3. Because Kubernetes maintains the system state as declared in the configuration files, it immediately starts up another pod instance. You can verify that by running `kubectl get pods`.

    ```bash
    @user-name /workspaces/eShopLite % kubectl get pods

    NAME                             READY   STATUS    RESTARTS   AGE
    productsbackend-7445bdb5c9-pnpk6 1/1     Running   0          31m
    storefrontend-5b6cc765c4-vwmv8   1/1     Running   0          7s
    ```

    Notice that the random string following the `storefrontend` name has changed, indicating that the pod is a new instance. Also the **AGE** value is considerably less as well.

In this exercise, you learned how Kubernetes automatically maintains declared system state, even if there's a failure.
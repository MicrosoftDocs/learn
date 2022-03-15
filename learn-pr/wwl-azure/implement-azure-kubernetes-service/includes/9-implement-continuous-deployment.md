In Kubernetes, you can update the service by using a rolling update.

It will ensure that traffic to a container is first drained, then replaced, and finally, traffic is sent back to the container.

In the meantime, your customers won't see any changes until the new containers are up and running on the cluster.

The moment they are, new traffic is routed to the new containers and stopped at the old containers. Running a rolling update is easy to do with the following command:

```bash
kubectl apply -f nameofyamlfile

```

The YAML file contains a specification of the deployment. The **apply** command is convenient because it makes no difference whether the deployment was already on the cluster.

It means that you can always use the same steps whatever of whether you're doing an initial deployment or an update to an existing deployment.

When you change the name of the image for service in the YAML file, Kubernetes will apply a rolling update, considering the minimum number of running containers you want and how many at a time it's allowed to stop.

The cluster will take care of updating the images without downtime, assuming that your application container is built stateless.

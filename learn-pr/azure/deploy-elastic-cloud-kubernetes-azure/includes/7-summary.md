Your boss at Tailwind Traders asked you to deploy Elastic on AKS with the Kubernetes operator. The goal was to gain control over the underlying infrastructure while increasing efficiency. You created an AKS cluster and installed Elastic Cloud on Kubernetes operator. Then, you deployed a three-node Elasticsearch cluster with two instances of Kibana on AKS.

## References

- Refer to published guidance to get the latest information on [supported versions](https://www.elastic.co/guide/en/cloud-on-k8s/current/k8s_supported_versions.html) of Kubernetes.
- Test the performance of your initial setup and adjust in a separate environment using [Rally](https://github.com/elastic/rally), Elastic’s macro benchmarking framework.

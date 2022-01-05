How do you choose between autoscale and standard throughput?

## Compare workloads

Standard throughput is again suited for workloads with steady traffic.

Autoscale throughput is better suited for unpredictable traffic. Autoscale can ensure that your actual Azure Cosmos DB provisioned throughput oscillates between your minimal acceptable performance and maximum allowed spend.

## Compare request units

Standard throughput requires a static number of request units to be assigned ahead of time.

With autoscale, you only set the maximum, and the minimum billed will be 10% of the maximum when there are zero requests.

## Compare scenarios

You want to use standard throughput provisioning in scenarios when your team can accurately predict the amount of throughput your application needs, and your team suspects these needs will not change over time. Also throughput provisioning is ideal for scenarios where the full RU/s provisioned is consumed for \> 66% of hours per month.

Autoscale throughput is helpful if your team cannot predict your throughput needs accurately or otherwise use the max throughput amount for \< 66% of hours per month.

## Compare rate-limiting

The standard throughput will always remain static at the set RU/s that is provisioned. Requests beyond this will be rate-limited, with a response indicating that a wait should be attempted before retrying.

Autoscale will scale up to the max RU/s before similarly rate-limiting responses

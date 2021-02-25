

> [!NOTE]
> If your AKS cluster version is less than 1.10, the required Metrics Server will not be installed by default. HPAs can only work if they have a valid Metrics Server installation, you can install the Metrics Server on your cluster by downloading the [`components.yaml` file on the latest release](https://github.com/kubernetes-sigs/metrics-server/releases/latest/components.yaml).
>
> Example installation:
>
> ```bash
> kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
> ```

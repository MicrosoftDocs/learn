Contoso has Windows applications as well as Linux applications. Before you containerize a Windows workload, verify its image compatibility, node-pool requirements, licensing, and authentication dependencies.

## Prepare a supported Windows node pool

Keep the cluster's Linux node pool for system components and Arc connectivity. Add Windows capacity as a separate node pool.

For Azure Local release 2509 or later, the Windows node-pool feature is disabled by default. An authorized infrastructure administrator must enable it and prepare the required Windows images before you create a Windows pool. Follow [Enable Windows node pools](/azure/aks-hybrid-edge/local/hyperconverged/howto-enable-windows-node-pools) for preparation steps and permissions for your release.

In the management PowerShell session, the following example adds one Windows Server 2022 node to the cluster created earlier:

```powershell
az aksarc nodepool add --resource-group $resourceGroup --cluster-name $clusterName `
    --name winpool --node-count 1 --os-type Windows --os-sku Windows2022
```

Confirm that the selected OS SKU and VM configuration are supported for the target cluster version. Windows node pools also require the appropriate Windows Server licensing.

A single node is an illustrative starting point, not a production availability recommendation. Size the pool for the workload and its maintenance requirements. Verify node readiness before deploying applications.

## Match the image to the container host

A Windows container image must be compatible with its Windows container host. Don't reuse a Windows Server 2019 application image solely because the old module used it.

The following example uses a Windows Server 2022 IIS image. Its OS and build selectors restrict placement to Windows Server 2022 nodes, which Kubernetes labels with build `10.0.20348`. Use an approved registry and image version for production:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: windows-web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: windows-web
  template:
    metadata:
      labels:
        app: windows-web
    spec:
      nodeSelector:
        kubernetes.io/os: windows
        node.kubernetes.io/windows-build: '10.0.20348'
      tolerations:
      - key: dedicated
        operator: Equal
        value: windows-apps
        effect: NoSchedule
      containers:
      - name: web
        image: mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
        ports:
        - containerPort: 80
```

Save the manifest as `windows-web.yaml`. With the Arc proxy running, apply it and inspect the result:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig apply -f .\windows-web.yaml
kubectl --kubeconfig .\contoso-aks-kubeconfig get pods -o wide
```

The included toleration permits scheduling onto nodes with the custom taint described earlier. It doesn't require that taint to be present. The example doesn't create an externally accessible Service.

## Evaluate application authentication separately

Creating a Windows node pool doesn't configure an application's access to AD DS-protected services. Before you approve the platform, record whether the application needs Kerberos, NTLM, service accounts, or another identity mechanism.

> [!IMPORTANT]
> Windows node-pool documentation explicitly states that group managed service account (gMSA) authentication isn't supported for AKS on Azure Local 23H2 and 24H2. For these releases, manually domain-joining nodes doesn't provide a supported gMSA configuration.

If gMSA is a requirement, verify support for the exact target Azure Local release before you deploy. Preinstalled gMSA components aren't proof that a supported configuration procedure exists. If the required configuration isn't supported, select a supported alternative platform or revise the application design.

See [Create a Windows node pool](/azure/aks-hybrid-edge/local/hyperconverged/howto-create-windows-node-pools) for licensing, supported deployment options, and the documented gMSA limitation.

For build-specific scheduling, see [Handling multiple Windows versions in the same cluster](https://kubernetes.io/docs/concepts/windows/user-guide/#handling-multiple-windows-versions-in-the-same-cluster).

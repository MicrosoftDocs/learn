Contoso has Windows applications as well as Linux applications. Before you containerize a Windows workload, verify its image compatibility, node-pool requirements, licensing, and authentication dependencies.

## Prepare a supported Windows node pool

Keep the cluster's Linux node pool for system components and Arc connectivity. Add Windows capacity as a separate node pool.

For Azure Local release 2509 or later, the Windows node-pool feature is disabled by default. An authorized infrastructure administrator must enable it and prepare the required Windows images before you create a Windows pool. Follow Enable Windows node pools for preparation steps and permissions for your release.

> [!IMPORTANT]
> Windows Server node pools must be licensed using the Windows Server subscription or Azure Hybrid Benefit. Confirm the applicable activation and eligibility requirements for the Azure Local deployment before creating the pool.

In your management PowerShell session, reuse the resource group, cluster name, and custom location ID from cluster creation. Replace the placeholders with those values. Set the variables again if you open another terminal; PowerShell variables aren't shared between processes.

```powershell
$resourceGroup = '<resource-group-containing-your-cluster>'
$clusterName = '<aks-cluster-name>'
$customLocationId = '<custom-location-resource-id>'

az aksarc get-versions --custom-location $customLocationId
if ($LASTEXITCODE -ne 0) {
    throw 'Version and image discovery failed. Resolve the error before continuing.'
}
az aksarc nodepool list --resource-group $resourceGroup `
    --cluster-name $clusterName --output table
if ($LASTEXITCODE -ne 0) {
    throw 'Pool discovery failed. Resolve the error before continuing.'
}
```

For the cluster's intended Kubernetes version, confirm that the readiness entry with `osType: Windows` and `osSku: Windows2022` shows `ready: true`. A listed version alone doesn't mean its image download is complete. Ask the infrastructure administrator to resolve readiness failures before provisioning. As in the earlier preparation unit, `get-versions` automatically creates or uses the custom location's `kubernetesVersions/default` Azure resource; it isn't strictly read-only.

Confirm that the OS SKU and VM configuration are supported for the target cluster version. Run the following creation command only if `winpool` doesn't already exist. If it exists, skip creation and inspect its configuration, using the earlier node-pool taint procedure to update it only if needed. That procedure preserves existing taints.

This example adds one Windows Server 2022 node with the pool-level taint used in the scheduling unit:

```powershell
az aksarc nodepool add --resource-group $resourceGroup --cluster-name $clusterName `
    --name winpool --node-count 1 --os-type Windows --os-sku Windows2022 `
    --node-taints "dedicated=windows-apps:NoSchedule"
if ($LASTEXITCODE -ne 0) {
    throw 'Windows pool creation failed. Resolve the error before deploying workloads.'
}
```

A single node is an illustrative starting point, not a production availability recommendation. Size the pool for the workload and its maintenance requirements.

Keep the Arc proxy running in its separate terminal, and run `kubectl` from the directory containing `contoso-aks-kubeconfig`. Inspect the pool and Windows nodes:

```powershell
az aksarc nodepool list --resource-group $resourceGroup `
    --cluster-name $clusterName --output table
kubectl --kubeconfig .\contoso-aks-kubeconfig get nodes `
    -l kubernetes.io/os=windows `
    -L node.kubernetes.io/windows-build,kubernetes.azure.com/os-sku --show-labels
```

Identify the node belonging to `winpool` from its pool-membership labels, rather than choosing a node from another Windows pool. Replace `<node-from-winpool>` with its name, wait for `Ready`, and verify the build label:

```powershell
$windowsNode = '<node-from-winpool>'
kubectl --kubeconfig .\contoso-aks-kubeconfig `
    wait --for=condition=Ready "node/$windowsNode" --timeout=600s
if ($LASTEXITCODE -ne 0) {
    throw "The Windows node isn't ready. Inspect its status before continuing."
}
$windowsBuild = kubectl --kubeconfig .\contoso-aks-kubeconfig get node $windowsNode `
    -o jsonpath='{.metadata.labels.node\.kubernetes\.io/windows-build}'
if ($LASTEXITCODE -ne 0 -or $windowsBuild -ne '10.0.20348') {
    throw "The node build doesn't match the sample. Resolve compatibility before deploying."
}
kubectl --kubeconfig .\contoso-aks-kubeconfig describe node $windowsNode
if ($LASTEXITCODE -ne 0) {
    throw 'Node inspection failed. Resolve the error before continuing.'
}
```

Confirm the node also shows the pool's `dedicated=windows-apps:NoSchedule` taint. Repeat these checks for each node if you use a larger pool. Image-download readiness, node readiness, and application readiness are separate checks.

## Match the image to the container host

A Windows container image must be compatible with its Windows container host. This example uses a Windows Server 2022 pool and an IIS image based on Windows Server Core LTSC 2022. When changing the node OS SKU or application image, check the Windows container compatibility matrix and update the build selector to match. Don't infer compatibility from the image name alone.

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

Save the manifest as `windows-web.yaml`. The sample uses the `default` namespace and the resource name `windows-web`; run it only where it won't conflict with existing application resources. With the Arc proxy running, apply it and wait for the rollout:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace default `
    apply -f .\windows-web.yaml
if ($LASTEXITCODE -ne 0) {
    throw 'Deployment creation failed. Resolve the error before continuing.'
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace default `
    rollout status deployment/windows-web --timeout=600s
if ($LASTEXITCODE -ne 0) {
    throw "The rollout didn't complete. Inspect pod events before continuing."
}
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace default `
    get pods -l app=windows-web -o wide
```

The initial Windows image pull can take time. If the rollout doesn't complete, inspect pod events for scheduling, image-pull, and container-start failures before proceeding.

The included toleration permits scheduling onto nodes with the custom taint described earlier. It doesn't require that taint to be present or force placement on `winpool`. The OS and build selectors require compatible Windows nodes; use an additional pool-label selector if the workload must use only one pool. If you retained other taints, check that the workload has any additional tolerations it needs.

## Check the IIS application

Verify the default IIS page from inside the container:

```powershell
$statusCode = kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace default `
    exec deployment/windows-web -- powershell.exe -NoProfile -Command `
    "(Invoke-WebRequest -UseBasicParsing -Uri http://localhost -ErrorAction Stop).StatusCode"
if ($LASTEXITCODE -ne 0 -or $statusCode -ne '200') {
    throw 'The IIS HTTP check failed. Inspect the application before continuing.'
}
$statusCode
```

Expect HTTP status `200`. This validates the listener inside the container, not external Service access. The example intentionally doesn't create an externally accessible Service.

## Evaluate application authentication separately

Creating a Windows node pool doesn't configure an application's access to AD DS-protected services. Before you approve the platform, record whether the application needs Kerberos, NTLM, service accounts, or another identity mechanism.

> [!IMPORTANT]
> The documented Azure Local 24H2 Windows node-pool configuration doesn't support group managed service account (gMSA) authentication. Preinstalled components aren't a supported configuration path. Don't manually alter managed nodes or domain-join them to work around this restriction. Recheck platform-specific guidance when evaluating a different release.

If gMSA is a requirement, verify support for the exact target Azure Local release before you deploy. Evaluate a platform with a documented implementation, such as gMSA on AKS in Azure, or revise the application design. The cloud-AKS alternative has its own identity, networking, and domain-service prerequisites. Follow that platform's complete prerequisites and configuration procedure; it isn't a workaround for Azure Local.

See Create a Windows node pool for licensing, supported deployment options, and the documented gMSA limitation.

## Service Windows pools and clean up lab resources

For a Windows node OS transition, follow the supported pool replacement procedure. Create an appropriate replacement pool, update compatible application images and placement rules, and verify the migrated workloads before removing the previous pool. Don't change a managed node VM in place as an OS transition procedure.

Lab cleanup is optional. Delete this sample Deployment only if you no longer need it:

```powershell
kubectl --kubeconfig .\contoso-aks-kubeconfig --namespace default `
    delete -f .\windows-web.yaml --wait=true --timeout=300s
if ($LASTEXITCODE -ne 0) {
    throw "Deployment deletion didn't complete. Inspect its status before continuing."
}
```

Only if `winpool` was created solely for this exercise and no other workloads need it, remove that pool. Reuse `$resourceGroup` and `$clusterName` from this unit, setting them again if you're in a different terminal:

```powershell
az aksarc nodepool delete --resource-group $resourceGroup `
    --cluster-name $clusterName --name winpool
if ($LASTEXITCODE -ne 0) {
    throw 'Pool deletion failed. Inspect its status before continuing.'
}
az aksarc nodepool list --resource-group $resourceGroup `
    --cluster-name $clusterName --output table
if ($LASTEXITCODE -ne 0) {
    throw 'Pool verification failed. Resolve the error before continuing.'
}
```

Wait for deletion to finish and verify that `winpool` is absent. Preserve the Linux pool needed by the Arc agents. If an administrator later disables the Windows node-pool feature, remove all Windows pools first as required by the enablement guide.

For build-specific scheduling, see **Handling multiple Windows versions in the same cluster** in the Summary unit's **More info** section. That section also contains the Windows preparation, licensing, authentication, and servicing references used in this unit.

AI inference services on Azure often require different settings across environments. You want to change these settings without rebuilding containers. ConfigMaps store non-sensitive configuration, such as feature flags and service endpoints. They keep configuration out of images and source code. This approach lets you make fast, controlled changes to settings. You can inject ConfigMap values into Pods as environment variables or as mounted files. Choose environment variables when your application reads from the process environment. Choose mounted files when your application expects configuration files on disk.

> [!NOTE]
> All code examples in this module show configuration patterns for Kubernetes resources. The specific values and resource names are examples. Adapt them to match your application requirements and naming conventions.

## Define a ConfigMap

A ConfigMap is a Kubernetes resource that stores configuration data as key-value pairs. You declare it using YAML and apply it to your cluster. The `data` field holds your configuration keys and their string values. ConfigMap data is limited to 1 MiB total size per ConfigMap. This limit ensures fast synchronization to nodes and efficient etcd storage. For larger configuration files or binary data, use persistent volumes or external configuration services. Use the `binaryData` field for base64-encoded binary values when necessary. ConfigMap keys must consist of alphanumeric characters, dashes, underscores, or dots.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-settings
data:
  FEATURE_X_ENABLED: "true"
  SERVICE_ENDPOINT: "https://api.example.com"
  # File-like configuration can use multi-line values
  app.config: |
    log_level=info
    timeout_seconds=30
```

## Consume ConfigMap values in a Deployment

You inject configuration into Pods through environment variables. This approach uses the `valueFrom` field with `configMapKeyRef` to reference specific keys from your ConfigMap. When the Pod starts, Kubernetes reads the ConfigMap and sets the environment variables in the container. You can also use `envFrom` with `configMapRef` to load all keys from a ConfigMap as environment variables in one declaration. This bulk loading approach works well when you have many configuration values and want to avoid repetitive YAML. After you deploy, validate that Pods receive expected values. Use `kubectl describe pod` and check your application logs to confirm the settings are correct.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web-api
  template:
    metadata:
      labels:
        app: web-api
    spec:
      containers:
      - name: api
        image: myregistry.azurecr.io/web-api:v1
        env:
        - name: FEATURE_X_ENABLED
          valueFrom:
            configMapKeyRef:
              name: app-settings
              key: FEATURE_X_ENABLED
        - name: SERVICE_ENDPOINT
          valueFrom:
            configMapKeyRef:
              name: app-settings
              key: SERVICE_ENDPOINT
        # Alternative: load all keys as environment variables
        # envFrom:
        # - configMapRef:
        #     name: app-settings
```

## Mount ConfigMap as files

Some applications expect configuration files on disk rather than environment variables. You can mount a ConfigMap as files in the container filesystem. This approach uses a volume backed by the ConfigMap. You then add a `volumeMount` entry in the container spec to mount that volume at a specific path. Each key in the ConfigMap becomes a file in the mount directory. When you mount ConfigMaps as volumes, Kubernetes automatically updates the files when you modify the ConfigMap. The kubelet checks for updates on each sync period. However, containers using ConfigMaps as environment variables do not receive automatic updates and require Pod restarts. The automatic update behavior does not apply when you use `subPath` mounts. The following snippet shows the volume and mount configuration. Include these sections inside your Pod or Deployment spec.

```yaml
# Code fragment - focus on volume mount
volumes:
- name: config-volume
  configMap:
    name: app-settings
    # Optional: select specific keys to mount as files
    # items:
    # - key: app.config
    #   path: application.conf
containers:
- name: api
  volumeMounts:
  - name: config-volume
    mountPath: /app/config
    readOnly: true
```

## Use immutable ConfigMaps

You can mark a ConfigMap as immutable to protect against accidental changes that could disrupt running applications. Immutable ConfigMaps offer performance benefits in large clusters by allowing Kubernetes to close watches on these resources. This reduces load on the API server when you have many ConfigMaps. Once you set a ConfigMap to immutable, you cannot change its data or revert the immutable setting. You must delete and recreate the ConfigMap to make changes. Existing Pods maintain mount points to the deleted ConfigMap until they restart. Use immutable ConfigMaps for configuration that should not change during application runtime. This pattern works well for configuration tied to specific application versions where changes require redeployment.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-settings-v2
data:
  FEATURE_X_ENABLED: "true"
  SERVICE_ENDPOINT: "https://api.example.com"
immutable: true
```

## Integrate with Azure App Configuration

You can use [Azure App Configuration](/azure/azure-app-configuration/overview) for centralized configuration management across multiple applications and environments. The [Azure App Configuration Kubernetes Provider](/azure/azure-app-configuration/quickstart-azure-kubernetes-service) runs in your cluster and generates ConfigMaps from data stored in App Configuration. This provider creates standard Kubernetes ConfigMaps that your applications consume through environment variables or volume mounts. The provider synchronizes changes from App Configuration to your cluster automatically. You can manage feature flags, configuration values, and Key Vault references in App Configuration and have them appear as ConfigMaps in your cluster. This approach separates configuration management from cluster operations and provides a centralized view of settings across multiple AKS clusters.

## Verify with kubectl

You can apply the manifests and inspect resources to confirm the configuration is available to your Pods. These manifests are typically stored in files named *configmap.yaml* (ConfigMap) and *deployment.yaml* (Deployment).

```bash
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl describe configmap app-settings
kubectl describe deployment web-api
# Check if Pod received configuration as environment variables
kubectl exec <pod-name> -- printenv | grep FEATURE
```
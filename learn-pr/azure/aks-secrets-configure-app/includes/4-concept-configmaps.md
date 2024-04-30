In the [application repository](https://github.com/Azure-Samples/aks-contoso-ships-sample), there's a [config file](https://github.com/Azure-Samples/aks-contoso-ships-sample/blob/434beca73f7bf5504c0e8d38890daace66f7723f/frontend/src/config.js) loaded in the [`index.html`](https://github.com/Azure-Samples/aks-contoso-ships-sample/blob/f1b1796da12b714fb7ea2a1c807e0e15b0b2abbb/frontend/public/index.html#L5) file to allow the environment variables to be updated without the need of a full image build.

The configuration file doesn't contain sensitive information, it just needs to be loaded along with the container. How can we mount the file in the container without the need of encryption or encoding?

## Understand ConfigMaps

ConfigMaps are counterparts to Secrets. While Secrets provide a way to store and deliver sensitive data, ConfigMaps are objects that provide a way to store nonsensitive data using the same key-value structure as a Secret. The ConfigMaps object allows you to decouple configurations from container images so the images remain stateless.

You create a ConfigMap to store configuration data separately from the application code and load it similarly to how we load Secret objects in the Pod. You can only reference ConfigMaps by using an environment variable, or by mounting them as a file in a volume inside the container.

ConfigMaps have a data size limitation: you can hold up to *1 MiB* of data in a ConfigMap. The size limitation helps you avoid large, complex configuration files by having you break large configurations into smaller chunks. With ConfigMaps, you can mount only the required configuration files in your containers, which allows for more granularity.

Like Secrets, ConfigMaps are namespaced. You can only access and mount a ConfigMap by using the containers present in the same namespace that it was created in.

ConfigMaps are also widely used by other tools, such as [Helm](https://helm.sh) and Kubernetes Operators, to store and read states.

### ConfigMap updates

All ConfigMaps that are *mounted as volumes* inside a pod are automatically updated once their value is changed. This change might not occur immediately because of the [Kubelet configuration](https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically), but it happens automatically so there's no need to restart the Pod.

When a ConfigMap is *bound to environment variables*, it isn't automatically updated. For these cases, it's necessary to restart the Pod for the changes to take effect.

## Create and use ConfigMaps

You can create a ConfigMap using the same approach as a Secret: a YAML file. The ConfigMap specification is as follows:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: configmap-name
  namespace: default
data:
  key-name: "value as key"
  key.name: |
    multi line
    property, called "file-like" values
```

You can reference ConfigMaps by one or more keys in the specification of a Pod or Deployment, as shown in the following example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-as-env
  namespace: default
spec:
  containers:
    - name: configmap-env
      image: alpine
      command: ["sleep", "3600"]
      env:
        - name: ENVIRONMENT_VARIABLE_NAME
          valueFrom:
            configMapKeyRef:
              name: configmap-name
              key: key-name
```

You can also mount them as files inside the pod using read-only volumes, as shown in the following example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: configmap-as-env
  namespace: default
spec:
  containers:
    - name: configmap-env
      image: alpine
      command: ["sleep", "3600"]
      volumeMounts:
      - name: volume-name
        mountPath: "/path/to/mount"
        readOnly: true
  volumes:
    - name: volume-name
      configMap:
        name: configmap-name
        items:
        - key: "key-name"
          path: "path/to/mount/the/key"
```

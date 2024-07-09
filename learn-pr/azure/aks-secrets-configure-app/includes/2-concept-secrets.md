One of the biggest considerations when working with distributed applications is how to manage sensitive information, like passwords, connections, and similar data. Kubernetes allows you to secure this data with a resource called a **Secret**.

## Understand Secrets

In Kubernetes, Secrets allow you to store sensitive information in a safer way than plain text format in pods and deployments. Secrets are designed to store passwords and other sensitive data.

Kubernetes Secrets encode their data in a base64 format. Although base64 isn't an encryption algorithm, Kubernetes can see that the information is encoded and can hide this information from command outputs such as `kubectl describe`. This process doesn't happen with plain text configuration. Secrets are always scoped to a single namespace to avoid added exposure of sensitive data to other workloads in the cluster.

### Types of Secrets

There are different types of Secrets. The most common and default type is `Opaque`, which holds user-defined, arbitrary data. The other common types include:

- `kubernetes.io/service-account-token`: Defines a Service Account Token, and is automatically created when a new Service Account is created.
- `kubernetes.io/basic-auth`: Credentials for basic authentication.
- `kubernetes.io/tls`: TLS client or server data, used to serve HTTPS connections from within an Ingress resource, for example.

> [!TIP]
> For more information, see the official [Kubernetes Secrets documentation](https://kubernetes.io/docs/concepts/configuration/secret/#secret-types).

## Create and use a Secret

According to the official [Kubernetes Secrets documentation](https://kubernetes.io/docs/concepts/configuration/secret/#overview-of-secrets), you can use a Secret in three different ways:

- Mounted as files in a volume on containers inside a Pod or Deployment.
- Referenced as an environment variable in the Pod or Deployment specification.
- Used by the Kubelet when pulling images from private registries via the `imagePullSecret` key in the Pod specification.

You can create Secrets like any other Kubernetes resource, using either a YAML manifest file or a `kubectl` command. The Secret specification is as follows:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-name
  namespace: secret-namespace
type: Opaque
data:
  key_name: "key value in base64 format"
```

For a Secret with this specification, you need to encode the values *before* you create the Secret. If you want to create a Secret with the plain text value and let Kubernetes encode it automatically, you use `stringData` instead of `data`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secret-name
  namespace: secret-namespace
type: Opaque
stringData:
  key_name: "key value in plain format"
```

The application receives the *decoded* Secret string as the value passed to it instead of the encoded one.

### Secret updates

All Secrets that are *mounted as volumes* inside a pod are automatically updated once their value changes. This change might not occur immediately because of the [Kubelet configuration](https://kubernetes.io/docs/concepts/configuration/configmap/#mounted-configmaps-are-updated-automatically), but it happens automatically so there's no need to restart the Pod.

In cases where Secrets are *bound to environment variables* they aren't automatically updated, making it necessary to restart the Pod for the changes to take effect.

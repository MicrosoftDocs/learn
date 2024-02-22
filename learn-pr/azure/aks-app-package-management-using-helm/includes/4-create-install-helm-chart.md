Helm charts make it simple to deploy applications to any Kubernetes cluster. You use Helm to template your application's deployment information as a Helm chart, which you then use to deploy your application.

Let's say your development team already deployed your company's pet store website to your AKS cluster. The team creates three files to deploy the website:

- A *deployment manifest* that describes how to install and run the application on the cluster,
- A *service manifest* that describes how to expose the website on the cluster, and
- An *ingress manifest* that describes how the traffic from outside the cluster routed to the web app.

The team deploys these files to each of the three environments as part of the software development lifecycle. Each of the three files is updated with variables and values that are specific to the environment. Since each file is hardcoded, the maintenance of these files is error-prone.

## How does Helm process a chart?

The Helm client implements a Go language-based template engine that parses all available files in a chart's folders. The template engine creates Kubernetes manifest files by combining the templates in the chart's `templates/` folder with the values from the `Chart.yaml` and `values.yaml` files.

:::image type="content" source="../media/4-helm-chart-process.svg" border="false" alt-text="A diagram shows a process parsing a Helm template file and values file to create and deploy an application to a Kubernetes cluster using manifest files.":::

Once the manifest files are available, the client can install, upgrade, and delete the application defined in the generated manifest files.

## How to define a `Chart.yaml` file

The `Chart.yaml` is one of the required files in a Helm chart definition and provides information about the chart. The contents of the file consists of three required fields and various optional fields.

The three required fields include:

- `apiVersion`: The chart API version to use. You set the version to `v2` for charts that use Helm 3.
- `name`: The name of the chart.
- `version`: The version number of the chart, which uses semantic versioning 2.0.0 and follows the `MAJOR.MINOR.PATCH` version number notation.

The following example shows the contents of a basic `Chart.yaml` file:

```yml
apiVersion: v2
name: webapp
description: A Helm chart for Kubernetes

# A chart can be either an 'application' or a 'library' chart.
#
# Application charts are a collection of templates that can be packaged into versioned archives
# to be deployed.
#
# Library charts provide useful utilities or functions for the chart developer. They're included as
# a dependency of application charts to inject those utilities and functions into the rendering
# pipeline. Library charts do not define any templates and therefore, cannot be deployed.
type: application

# This is the chart version. This version number should be incremented each time you make changes
# to the chart and its templates, including the app version.
version: 0.1.0

# This is the version number of the application being deployed. This version number should be
# incremented each time you make changes to the application.
appVersion: 1.0.0
```

Notice the use of the `type` field in the example file. You can create charts to install either applications or libraries. The default chart type is `application` and can be set to `library` to specify the chart will install a library.

Many optional fields are available to tailor the chart deployment process. For example, you can use the `dependencies` field to specify extra requirements for the chart, like a web app that depends on a database.

> [!NOTE]
> Detailed coverage of all optional fields is outside the scope of this module. However, a link to the Helm documentation is available in the summary section of the module.

## How to define a chart template

A Helm chart template is a file describes different deployment type manifest files. Chart templates are written in the Go template language and provide template functions to automate the creation of Kubernetes object manifest files.

Template files are stored in the `templates/` folder of a chart. The template engine processes these files to create the final object manifest.

For example, let's say your development team uses the following deployment manifest file to deploy the pet store front component of the solution:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: store-front
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: store-front
  template:
    metadata:
      labels:
        app: store-front
    spec:
      nodeSelector:
        "kubernetes.io/os": linux
      containers:
      - name: store-front
        image: {{ .Values.storeFront.image.repository }}:{{ .Values.storeFront.image.tag }}
        ports:
        - containerPort: 8080
          name: store-front
        env: 
        - name: VUE_APP_ORDER_SERVICE_URL
          value: "http://order-service:3000/"
        - name: VUE_APP_PRODUCT_SERVICE_URL
          value: "http://product-service:3002/"
        resources:
          requests:
            cpu: 1m
            memory: 200Mi
          limits:
            cpu: 1000m
            memory: 512Mi
        startupProbe:
          httpGet:
            path: /health
            port: 8080
          failureThreshold: 3
          initialDelaySeconds: 5
          periodSeconds: 5
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          failureThreshold: 3
          initialDelaySeconds: 3
          periodSeconds: 3
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
          failureThreshold: 5
          initialDelaySeconds: 3
          periodSeconds: 3
---
apiVersion: v1
kind: Service
metadata:
  name: store-front
spec:
  type: {{ .Values.storeFront.serviceType }}
  ports:
  - port: 80
    targetPort: 8080
  selector:
    app: store-front
```

Notice how the location of the container image is hardcoded using the `{{.Values.<property>}}` syntax. The syntax allows you to create placeholders for each custom value.

The process of creating Helm charts by hand is tedious. An easy way to create a Helm chart is to use the `helm create` command to create a new Helm chart. You then customize the autogenerated files to match your application's requirements.

## How to define a `values.yaml` file

You use chart values to customize the configuration of a Helm chart. Chart values can either be predefined or supplied by the user at the time of deploying the chart.

A **predefined value** is a case-sensitive value that's predefined in the context of a Helm chart and can't be changed by a user. For example, you can use `Release.Name` to reference the name of the release or `Release.IsInstall` to check if the current operation is an installation.

You can also use predefined values to extract data from the contents of the `Chart.yaml`. For example, if you want to check the chart's version, you'd reference `Chart.Version`. Keep in mind that you can only reference well-known fields. You can think of predefined values as constants to use in the templates you create.

The syntax to include value names in a template file involves enclosing the value name in double curly braces, for example, `{{.Release.Name}}`. Notice the use of a period in front of the value name. When you use a period in this way, the period functions as a lookup operator and indicates the variable's current scope.

For example, the following YAML snippet contains a dictionary defined in a values file:

```yml
object:
  key: value
```

To access the value in a template, you can use the following syntax:

```yml
{{ .Values.object.key }}
```

A **supplied value** allows you to process arbitrary values in the chart template. The `values.yaml` file defines these values.

In the example, the development team allows for the following configurable values:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: store-front
spec:
  replicas: {{ .Values.replicaCount }}
  ...
      containers:
      - name: store-front
        image: {{ .Values.storeFront.image.repository }}:{{ .Values.storeFront.image.tag }}
        ports:
  ...
---
apiVersion: v1
kind: Service
metadata:
  name: store-front
spec:
  type: {{ .Values.storeFront.serviceType }}
  ...
```

Here's an example of the `values.yaml` file:

```yml
...
replicaCount: 1
...
storeFront:
  image:
    repository: "ghcr.io/azure-samples/aks-store-demo/store-front"
    tag: "latest"
  serviceType: LoadBalancer
...
```

Once the template engine applies the values, the final result will look like this example:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: store-front
spec:
  replicas: 1
  ...
      containers:
      - name: store-front
        image: ghcr.io/azure-samples/aks-store-demo/store-front:latest
        ports:
---
apiVersion: v1
kind: Service
metadata:
  name: store-front
spec:
  type: LoadBalancer
  ...
```

## How to use a Helm repository

A Helm repository is a dedicated HTTP server that stores information on Helm charts. You configure Helm repositories with the Helm client for it to install charts from a repository using the `helm repo add` command.

For example, you can add the Azure Marketplace Helm repository to your local Helm client by running the following command:

```bash
helm repo add azure-marketplace https://marketplace.azurecr.io/helm/v1/repo
```

Information about charts available on a repository is cached on the client host. You need to periodically update the cache to fetch the repository's latest information using the `helm repo update` command.

The `helm search repo` command allows you to search for charts on all locally-added Helm repositories. You can run the `helm search repo` command by itself to return a list of all known Helm charts for each added repository. The result lists the chart's name, version, and app version deployed by the chart, as shown in the following example output:

```output
NAME                               CHART VERSION   APP VERSION   DESCRIPTION
azure-marketplace/airflow          11.0.8          2.1.4         Apache Airflow is a platform to programmaticall...
azure-marketplace/apache           8.8.3           2.4.50        Chart for Apache HTTP Server
azure-marketplace/aspnet-core      1.3.18          3.1.19        ASP.NET Core is an open-source framework create...
azure-marketplace/bitnami-common   0.0.7           0.0.7         Chart with custom tempaltes used in Bitnami cha...
azure-marketplace/cassandra        8.0.5           4.0.1         Apache Cassandra is a free and open-source dist...
```

You can search for a specific chart by adding a search term to the `helm search repo` command. For example, if you're searching for an ASP.NET based chart, you can use the following command:

```bash
helm search repo aspnet
```

In this example, the local client has two repositories registered and returns a result from each, as shown in the following example output:

```output
NAME                            CHART VERSION   APP VERSION   DESCRIPTION                                       
azure-marketplace/aspnet-core   1.3.18          3.1.19        ASP.NET Core is an open-source framework create...
bitnami/aspnet-core             1.3.18          3.1.19        ASP.NET Core is an open-source framework create...
```

## How to test a Helm chart

Helm provides an option for you to generate the manifest files that the template engine creates from the chart. This feature allows you to test the chart before a release by combining two extra parameters: `--dry-run` and `debug`. The `--dry-run` parameter ensures that the installation is simulated, and the `--debug` parameter enables verbose output.

```bash
helm install --debug --dry-run my-release ./chart-name
```

The command lists information about the values used and all generated files. You might have to scroll to view all of the generated output.

## How to install a Helm chart

You use the `helm install` command to install a chart. You can install a Helm chart from any of the following locations:

- Chart folders
- Packaged `.tgz` tar archive charts
- Helm repositories

However, the required parameters differ depending on the location of the chart. In all cases, the `install` command requires the name of the chart you want to install and a name for the release the installation creates.

You can install a local chart using an unpacked chart folder of files or a packed `.tgz` tar archive. To install a chart, the `helm` command references the local file system for the chart's location. Here's an example of the install command that will deploy a release of an unpacked chart:

```bash
helm install my-release ./chart-name
```

In the preceding example, the `my-release` parameter is the name of the release and the `./chart-name` parameter is the name of the unpacked chart package.

A packed chart is installed by referencing the packed chart filename. The following example shows the syntax for the same application now packed as a tar archive:

```bash
helm install my-release ./chart-name.tgz
```

When installing a chart from a Helm repository, you use a chart reference as the chart's name. The chart reference includes two parameters, the repository name and the name of the chart, as shown in the following example:

```bash
helm install my-release repository-name/chart-name
```

In the example, the `repository-name/chart-name` parameter contains the reference of the repo, `repository-name`, and the name of the chart, `chart-name`.

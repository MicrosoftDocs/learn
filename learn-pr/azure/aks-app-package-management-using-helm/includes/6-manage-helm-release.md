## How to use functions in a Helm template

The Helm template language defines **functions** that you use to transform values from the `values.yaml` file. The syntax for a function follows the *{{ functionName arg1 arg2 ... }}* structure. Let's look at the `quote` function as an example to see this syntax in use.

The `quote` function wraps a value in quotations marks to indicate the use of a `string`. Let's say you define the following `values.yaml` file:

```yml
apiVersion: v2
name: webapp
description: A Helm chart for Kubernetes
ingress:
  enabled: true
```

You decide you want to use the `ingress.enabled` value as a boolean when determining if an ingress manifest should be generated. To use the `enabled` value as a boolean, you reference the value using `{{ .Values.ingress.enabled }}`.

Later, you decide to display the field as a string in the `templates/Notes.txt` file. Because YAML type-coercion rules can lead to hard-to-find bugs in templates, you decide to follow guidance and be explicit when including strings in your templates. For example, `enabled: false` doesn't equal `enabled: "false"`.

To display the value as a string, you use `{{ quote .Values.ingress.enabled }}` to reference the boolean value as a string.

## How to use pipelines in a Helm template

You use **pipelines** when more than one function needs to act on a value. A pipeline allows you to *send* a value, or the result of a function, to another function. For example, you can rewrite the above `quote` function as `{{ .Values.ingress.enabled | quote }}`. Notice how the `|` indicates that the value is *sent* to the `quote` function.

Here's another example. Let's say you want to convert a value to uppercase and wrap it in quotes. You can write the statement as `{{ .Values.ingress.enabled | upper | quote }}`. Notice how the value is processed by the `upper` function and then the `quote` function.

The template language includes over 60 functions that allow you to expose, look up, and transform values and objects in templates.

## How to use conditional flow control in a Helm template

Conditional flow control allows you to decide the structure or data included in the generated manifest file. For example, you might want to include different values based on the deployment target or control if a manifest file is generated.

The `if / else` block is such a control flow structure and conforms to the following layout:

```yml
{{ if | pipeline | }}
  # Do something
{{ else if | other pipeline | }}
  # Do something else
{{ else }}
  # Default case
{{ end }}
```

Let's say you decide that the ingress manifest file for a chart is only created in specific cases. The following example shows how to accomplish that using an `if` statement:

```yml
{{ if .Values.ingress.enabled }}
apiVersion: extensions/v1
kind: Ingress
metadata:
  name: ...
  labels:
    ...
  annotations:
    ...
spec:
  rules:
    ...
{{ end }}
```

Remember that you can use placeholders to populate metadata in the template. Template files are parsed and evaluated sequentially by the template language from top to bottom. In the previous example, the template engine only generates the manifest file's contents if the `.Values.ingress.enabled` value is `true`.

When the template engine processes the statement, it removes the content declared inside the `{{ }}` syntax and leaves the remaining whitespace. This syntax causes the template engine to include a newline for the `if` statement line. If you leave the preceding file's contents as-is, you'll notice empty lines in your YAML, and the ingress manifest file is generated.

YAML gives meaning to whitespace. That's why *tabs*, *spaces*, and *newline characters* are considered important. To fix the problem of unwanted whitespace, you can rewrite the file as follows:

```yml
{{- if .Values.ingress.enabled -}}
apiVersion: extensions/v1
kind: Ingress
metadata:
  name: ...
  labels:
    ...
  annotations:
    ...
spec:
  rules:
    ...
{{- end }}
```

Notice the use of the `-` character as part of the start `{{-` and the end `-}}` sequence of the statement. The `-` character instructs the parser to remove whitespace characters. `{{-` removes whitespace at the start of a line and `-}}` at the end of a line, including the newline character.

## How to iterate through a collection of values in a Helm template

YAML allows you to define collections of items and use individual items as values in your templates. Accessing items in a collection is possible using an indexer. However, the Helm template language supports the iteration of a collection of values using the `range` operator.

Let's say you define a list of values in your `values.yaml` file to indicate additional ingress hosts. Here's an example of the values:

```yml
ingress:
  enabled: true
  extraHosts:
    - name: host1.local
      path: /
    - name: host2.local
      path: /
    - name: host3.local
      path: /
```

You use the range operator to allow the template engine to iterate through the `.Values.ingress.extraHosts`. The following code snippet shows a condensed example using the `range` operator:

```yml
{{- if .Values.ingress.enabled -}}
apiVersion: extensions/v1
kind: Ingress
metadata:
  ...
spec:
  rules:
    ...
    {{- range .Values.ingress.extraHosts }}
    - host: {{ .name }}
      http:
        paths:
          - path: {{ .path }}
            ...
    {{- end }}
  ...
{{- end }}
```

## How to control the scope of values in a Helm template

When you have values defined several layers deep, your syntax can become lengthy and cumbersome when including these values in a template. The `with` action allows you to limit the scope of variables in a template.

Remember that the `.` used in a Helm template references the current scope. For example, the `.Values` instructs the template engine to find the Values object in the current scope. Let's say you're using the `values.yaml` file from earlier to create a configuration map manifest file:

```yml
ingress:
  enabled: true
  extraHosts:
    - name: host1.local
      path: /
    - name: host2.local
      path: /
    - name: host3.local
      path: /
```

Instead of accessing each item's path value using `{{ .Values.ingress.extraHosts.path }}`, you can use the `with` action. The following code snippet shows an example using the `range` operator to generate a configuration map manifest file:

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- with .Values.ingress.extraHosts }}
  hostname: {{ .name }}
  path: {{ .path }}
  {{ end }}
```

The `{{- with .Values.ingress.extraHosts }}` limits the scope of values to the `.Values.ingress.extraHosts` array.

The `with` action restricts scope. You can't access other objects from the parent scope. Let's say you also want to access the `{{ .Release.Name }}` of the chart in the `with` code block. To access parent objects, you need to indicate the root scope by using the `$` character or rewrite your code. Here's the updated code to show how to include parent objects using the `$` character:

```yml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-configmap
data:
  {{- with .Values.ingress.extraHosts }}
  hostname: {{ .name }}
  path: {{ .path }}
  release: {{ $.Release.Name}}
  {{ end }}
```

> [!NOTE]
> There are several constructs available in the Helm template language to control flow. This module's summary unit includes a section with links to the Helm documentation to learn more.

## How to Helm define chart dependencies

A chart allows for the declaration of dependencies to support the main application and forms part of the installed release.

:::image type="content" source="../media/6-helm-deploy-subchart-dependencies.svg" border="false" alt-text="A diagram shows how Helm deploys all subcharts as dependencies of the main chart to a Kubernetes cluster.":::

You can either create a subchart using the `helm create` command, specifying the new chart's location in the `/charts` folder, or use the `helm dependency` command. Remember that the `/charts` folder might contain subcharts deployed as part of the main chart's release.

The `helm dependency` command allows you to manage dependencies included from a Helm repository. The command uses metadata defined in the `dependencies` section of your chart's values file. You specify the name, version number, and the repository from where to install the subchart. Here's an extract of a `values.yaml` file that has a MongoDB chart listed as a dependency:

```yml
apiVersion: v2
name: my-app
description: A Helm chart for Kubernetes
...
dependencies:
  - name: mongodb
    version: 10.27.2
    repository: https://marketplace.azurecr.io/helm/v1/repo
```

Once the dependency metadata is defined, you run the `helm dependency build` command to fetch the tar packaged chart. The chart build command downloads the chart into the `charts/` folder.

```bash
helm dependency build ./app-chart
```

Subcharts are managed separately from the main chart and might need updates as new releases become available. The command to update subcharts is `helm dependency update`. This command fetches new versions of the subchart while deleting outdated packages.

```bash
helm dependency update ./app-chart
```

Keep in mind that a chart dependency isn't limited to other applications. You may decide to reuse template logic across your charts and create a dependency specifically to manage this logic as a chart dependency. You'll get an example of this strategy in the next exercise.

## How to upgrade a Helm release

Helm allows upgrading existing releases as a delta of all the changes that apply to the chart and its dependencies.

:::image type="content" source="../media/6-helm-delta-release.svg" border="false" alt-text="A diagram shows how the Helm upgrade command creates a delta of all changed items in a Helm chart to upgrade a release and create a new release revision on a Kubernetes cluster.":::

For example, let's say the development team of the example `webapp` in this unit makes code changes that impact only the website's functionality. The team makes the following updates to the `Chart.yaml` file to reflect the new version of the application:

- Updates the web app's container image and tags the image as `webapp: linux-v2` when pushing the image to the container registry.
- Updates the `dockerTag` value to `linux-v2` and the chart version value to `0.2.0` in the chart's values file.

Here's an example of the updated `values.yaml` file:

```yml
apiVersion: v2
name: my-app
description: A Helm chart for Kubernetes

type: application

version: 0.2.0
appVersion: 1.0.0

registry: "my-acr-registry.azurecr.io"
dockerTag: "linux-v2"
pullPolicy: "Always"
```

Instead of uninstalling a current release, you use the `helm upgrade` command to upgrade the existing Helm release.

```bash
helm upgrade my-app ./app-chart
```

Remember that Helm generates a delta of the changes made to the Helm chart when you upgrade a release. As such, a Helm upgrade only upgrades the components identified in the delta. In the example, only the website is redeployed.

Once the upgrade completes, you can review the deployment history of the release using the `helm history` command with the release name.

```bash
helm history my-app
```

The history command returns several fields that describe the release, as shown in the following example output:

```output
REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
1               Mon Oct 11 17:25:33 2021        deployed        aspnet-core-1.3.18      3.1.19          Install complete
```

Notice the `revision` field in the result. Helm tracks release information of all releases done for a Helm chart. When you install a new version of a Helm chart, the revision count increases by one, and the new release information is matched to that revision.

Here's an example of the same history command run following a new version install of the web app:

```output
REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
1               Mon Oct 11 17:25:33 2021        superseded      aspnet-core-1.3.18      3.1.19          Install complete
2               Mon Oct 11 17:35:13 2021        deployed        aspnet-core-1.3.18      3.1.19          Upgrade complete
```

## How to roll back a Helm release

Helm allows the rollback of an existing Helm release to a previously installed release. Recall from earlier that Helm tracks release information of all releases of a Helm chart.

You use the `helm rollback` command to roll back to a specific Helm release revision. This command uses two parameters. The first parameter identifies the name of the release, and the second identifies the release revision number.

```bash
helm rollback my-app 2
```

The `helm rollback` command rolls back the release version of the app to the specified revision and update the app release history. A follow-on run of the `helm history` command shows the latest active revision number as the latest release entry.

For example, let's say the development team of the example `webapp` in this unit discovers a bug in the drone-tracking web application and needs to roll back to a previous release. Instead of uninstalling the current release and install a previous version, they roll back to the working release.

```bash
helm rollback my-app 1
```

Once a rollback completes, you can review the deployment history using the `helm history` command.

```output
REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
1               Mon Oct 11 17:25:33 2021        superseded      aspnet-core-1.3.18      3.1.19          Install complete
2               Mon Oct 11 17:35:13 2021        superseded      aspnet-core-1.3.18      3.1.19          Rolled back to 1
3               Mon Oct 11 17:38:13 2021        deployed        aspnet-core-1.3.18      3.1.19          Upgrade complete
```

Notice how the description field shows the rollback's revision number to make it easier for you to track changes.

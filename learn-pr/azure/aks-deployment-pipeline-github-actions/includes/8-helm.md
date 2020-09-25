We have successfully built and pushed both of our production and staging images to the ACR. It's time to automate all the steps and make the machine work for us.

But there's a problem. Our workloads aren't generic enough, this way we can't deploy them automatically, we need to change the files every time, manually.

## Helm charts

Helm is called "The Package Manager for Kubernetes" because it embraces and extends all Kubernetes features providing a way to group our manifest files into **charts**.

A chart is a group of one or more workloads together with some configuration files and a chart description file. Those files together compose a unit that can be easily deployed to a Kubernetes cluster.

One of the greatest advantages of using Helm is that we don't need to deploy all files individually. Instead, we can issue a single command to deploy multiple files in a chart, or even multiple dependent charts with an automatic dependency resolution.

The structure of a chart directory is this:

:::image type="content" source="../media/8-helm-chart-tree.png" alt-text="A Helm chart tree":::

Let's go through each file and directory to understand their meaning.

|Name  |Type  |Meaning  |
|---------|---------|---------|
|Chart.yaml     |File         |File that describes the chart, it's the file that will have the name, description, and version of the chart         |
|charts     |Directory         |Directory to include dependent charts         |
|templates     |Directory         |Directory where all the manifest files live         |
|values.yaml     |File         |File that contains all default values for helm templates         |

> [!TIP]
> You can check all the documentation on Helm charts in the [official docs](https://helm.sh/docs/chart_template_guide/getting_started/)

The other feature that makes Helm stand out is, in fact, the feature that we'll need the most. The ability to create and manipulate templates.

## Helm templates

Templates are the feature that makes possible for manifest files to be automated and put into a CI pipeline.

A template file is a manifest file that contains placeholders for variable values, let's take this example of the `deployment.yaml` file inside the `kubernetes` directory of our website fork:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website
spec:
  selector:
    matchLabels:
      app: contoso-website
  template:
    metadata:
      labels:
        app: contoso-website
    spec:
      containers:
        - image: !IMAGE!
          name: contoso-website
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 250m
              memory: 256Mi
          ports:
            - containerPort: 80
              name: http
```

See the `!IMAGE!` placeholder? That's a place where we should put our repository and image name. If we were doing a manual replacement, we'd do something like this:

```bash
$ sed 's+!IMAGE!+'"$ACR_NAME"'/contoso-website+g' kubernetes/deployment.yaml
```

This would replace `!IMAGE!` in the file by the name of our ACR and the name of our image and print out the result, so we can pipe this command to a `kubectl apply -f -` and create our workloads.

However this isn't elegant and it's not efficient. Helm comes with templating natively, we could replace `!IMAGE!` by `{{.Values.containerImage}}`:

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: contoso-website
spec:
  selector:
    matchLabels:
      app: contoso-website
  template:
    metadata:
      labels:
        app: contoso-website
    spec:
      containers:
        - image: {{.Values.containerImage}}
          name: contoso-website
          resources:
            requests:
              cpu: 100m
              memory: 128Mi
            limits:
              cpu: 250m
              memory: 256Mi
          ports:
            - containerPort: 80
              name: http
```

And then we just need to run the Helm command to install the workload passing this argument:

```bash
$ helm install contoso-website ./chart-location \
 --set containerImage="$ACR_NAME/contoso-website"
```

Besides this simple feature, Helm also uses template functions, which allows us to use more complex logic to include, for example, default and required values. This is something that is a bit more complicated on bash.

So, to make our CI pipeline more efficient, let's build the helm chart for the company's website.

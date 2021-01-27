You have successfully built and pushed both your staging and production images to your Container Registry instance. It's time to automate all the steps and make the machine work for you.

But, there's a problem. Your workloads aren't generic enough, so you can't deploy them automatically. Instead, you must manually change the files every time. 

As a solution, you'll create and use a Helm chart.

## Helm charts

Helm is an open-source packaging tool that helps you install and manage the lifecycle of Kubernetes applications. Similar to Linux package managers like APT and Yum, you can use Helm to manage Kubernetes charts. 

A Kubernetes chart is a group of one or more workloads that are packaged with configuration files and a chart description file. When packaged in a chart, the files can easily be deployed as a unit to a Kubernetes cluster.

One of the top advantages of using Helm is that you don't need to deploy files individually. Instead, you can issue a single command to deploy the chart. You can even deploy multiple dependent charts, with an automatic dependency resolution.

Here's the structure of a Helm chart directory:

:::image type="content" source="../media/8-helm-chart-tree.png" alt-text="Screenshot that shows an example of a Helm chart tree.":::

The following table describes each file and directory that's included in a Kubernetes chart:

|Name  |Type  |Meaning  |
|---------|---------|---------|
|Chart.yaml     |File         |Describes the chart. It's the file that contains the name, description, and version of the chart.         |
|charts     |Directory         |Includes dependent charts.         |
|templates     |Directory         |Contains all manifest files.         |
|values.yaml     |File         |Contains all default values for Helm templates.         |

Another feature that makes Helm stand out as a tool is the feature that you'll need the most for this exercise—the ability to create and manage templates.

## Helm templates

Templates are the feature that makes it possible for manifest files to be automated and added to a CI pipeline.

A template file is a manifest file that contains placeholders for variable values. Let's look at the following example of the deployment.yaml file inside the kubernetes directory of your website fork:

```yaml
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

The `!IMAGE!` placeholder is where you put your repository and image name. In a manual replacement, you'd do something like this example:

```bash
$ sed 's+!IMAGE!+'"$ACR_NAME"'/contoso-website+g' kubernetes/deployment.yaml
```

The code replaces `!IMAGE!` in the file with the name of your Container Registry instance and the name of your image. Then, it prints out the result. You can pipe this command to `kubectl apply -f -` and create the workloads.

However, this solution isn't elegant or efficient. Helm comes with native templating that allows you to replace `!IMAGE!` by using `{{.Values.containerImage}}`:

```yaml
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

Then, you just need to run the Helm command to install the workload and pass this argument:

```bash
$ helm install contoso-website ./chart-location \
 --set containerImage="$ACR_NAME/contoso-website"
```

In addition to this simple feature, Helm offers template functions. You can use template functions for more complex logic, for example, to include default and required values.

To make your CI pipeline more efficient, let's build the Helm chart for the company's website.

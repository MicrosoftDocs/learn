In this unit, you create a Helm chart to deploy to Azure Kubernetes Service (AKS) by using GitHub Actions. To create the Helm chart, you complete the following tasks:

- Check the Helm installation.
- Create a chart.
- Configure the chart.
- Create a deployment.
- Create an empty YAML file.
- Add contents to the YAML file.
- Create a service.
- Create an ingress.
- Create a DNS zone name.

## Check the Helm installation and update the repo

The Helm CLI is already installed in Azure Cloud Shell. If you don't already have Cloud Shell open, sign in to [Cloud Shell](https://shell.azure.com/?azure-portal=true) and make sure **Bash** is set as the Cloud Shell terminal.

1. Run `helm version` to make sure the displayed Helm version is greater than **3**.

1. Switch to your forked repository for this module by running `cd mslearn-aks-deployment-pipeline-github-actions`.

1. Run `git pull origin main` to pull in your changes from previous units.

## Create a Helm chart

Generate a boilerplate Helm template in the *kubernetes* directory of your repository.

1. In Cloud Shell, switch to the *kubernetes* directory:

   ```bash
   cd kubernetes
   ```

1. Use `helm create` to create a new directory called *contoso-website* in the *kubernetes* directory:

   ```bash
   helm create contoso-website
   ```

1. Switch to the new directory with `cd`.

   ```bash
   cd contoso-website
   ```

1. Delete the *charts* and *templates* folders in this directory.

    ```bash
    rm -r charts templates
    ```

1. Create a new empty *templates* folder.

   ```bash
   mkdir templates
   ```

1. To start building workloads in your empty chart, create a new set of YAML files by moving the existing files in *kubernetes* to the new *templates* folder:

   ```bash
   mv ../*.yaml ./templates
   ```

You now have a new Helm chart. Next, configure the chart.

## Configure the chart

1. Run `cd ../..` to switch to the root of your repository.

1. Run `code .` to open the code editor in the current directory.

1. In the left menu, expand the *kubernetes/contoso-website* folder, and open the *Chart.yaml* file. *Chart.yaml* is the file that names the chart and is where Helm looks for information about the chart.

1. Remove all the contents of the file except for the first three lines and the chart version, and edit the description so the file looks like this example:

   ```yaml
   apiVersion: v2
   name: contoso-website
   description: Chart for the Contoso company website
   version: 0.1.0
   ```

1. Save the file by selecting the top right corner of the editor toolbar and then selecting **Save**, or by pressing **Ctrl+S**.

### Create a deployment

Add templates for this deployment.

1. From the left menu, open the *deployment.yaml* file in the *kubernetes/templates* folder.

1. In the main `metadata` section, add a new key called `namespace` with the value `{{ default "staging" .Release.Namespace }}`. The `metadata` section should look like this example:

   ```yaml
   metadata:
     name: contoso-website
     namespace: {{ default "staging" .Release.Namespace }}
   ```

   By default, the workflow deploys this resource to the `staging` namespace, but if the `helm install` command has a `Namespace` option, the workflow uses that namespace instead.

1. Under the `template`/`spec`/`containers` section, replace `!IMAGE!` with the `latest` or `tag` versions from your AKS cluster.

    It's good practice to split up the `registry`, `image`, and `tag` parts of the image name to work with them more easily. Add three new template variables that use the values of `Values.image.registry`, `Values.image.name`, and `Values.image.tag`.

    ```yaml
    - image: {{ .Values.image.registry }}.azurecr.io/{{ .Values.image.name }}:{{ default "latest" .Values.image.tag }}
    ```
    
    Your *deployment.yaml* file should look like the following example:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: contoso-website
      namespace: {{ default "staging" .Release.Namespace }}
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
            - image: {{ .Values.image.registry }}.azurecr.io/{{ .Values.image.name }}:{{ default "latest" .Values.image.tag }}
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

1. Save the file.

### Add content to the values.yaml file

Earlier, you used `{{ .Release.Namespace }}`, so `Release` is a *variable scope*. Each variable scope has different default values and variables. The *values.yaml* file is another variable scope. Helm uses the *values.yaml* file to retrieve all the template values that start with `{{ .Values }}`.

This file should have the same structure as the file you use to call the variables. Take a quick look at your edited *deployment.yaml* file to see the structure. Notice that you used `.Values.image.registry`, `.Values.image.name`, and `.Values.image.tag` in the *deployment.yaml* file.

1. In the root of the *contoso-website* directory, open the *values.yaml* file.

1. Delete all contents in the file, so you have an empty YAML file.

1. Add the following content to the empty file, replacing the `<ACR-NAME>` placeholder with your Azure Container Registry name.

    ```yaml
    image:
      registry: <ACR-NAME>
      name: contoso-website
      tag: latest
    ```

    
    These values are the default if you don't pass a different value as a parameter by using the `--set` option of the Helm command.

1. Save the file.

### Create a service

1. Open the *service.yaml* file in the *templates* folder.

1. In the `metadata` section of the file, add a new key called `namespace` that uses the same value that you used in the *deployment.yaml* file.

   ```yaml
      namespace: {{ default "staging" .Release.Namespace }}
   ```

    Your *service.yaml* file should look like the following example:

    ```yaml
    apiVersion: v1
    kind: Service
    metadata:
      name: contoso-website
      namespace: {{ default "staging" .Release.Namespace }}
    spec:
      ports:
        - port: 80
          protocol: TCP
          targetPort: http
          name: http
      selector:
        app: contoso-website
      type: ClusterIP
    ```

1. Save the file.

### Create an ingress

1. Open the *ingress.yaml* file.

1. In the `metadata` section of the file, again add the `namespace` value that you used in the *deployment.yaml* file. 

1. Go to the `host` key. You create separate hosts for staging and production deployments, so users can't access the `staging` namespace by using production URLs. Concatenate the namespace in the host name. The HTTP application routing add-on in the AKS cluster handles name resolution.

    ```yaml
           - host: contoso-{{ default "staging" .Release.Namespace }}.!DNS!
    ```

1. Replace `!DNS!` with a new template variable for your DNS zone name.

    ```yaml
           - host: contoso-{{ default "staging" .Release.Namespace }}.{{ .Values.dns.name }}
    ```

    Your final *ingress.yaml* file should look like the following example:

    ```yaml
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: contoso-website
      namespace: {{ default "staging" .Release.Namespace }}
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-{{ default "staging" .Release.Namespace }}.{{ .Values.dns.name }}
          http:
            paths:
              - backend:
                  service:
                    name: contoso-website
                    port:
                      name: http
                path: /
                pathType: Prefix
    ```

1. Save the file.

### Add a DNS zone name value

1. Open the *values.yaml* file and add a `dns.name` key after the `image` key. Replace `<ACR-NAME>` with your Container Registry name and `<DNS-NAME>` with your **AKS DNS Zone Name** from the setup script output. Your file should look like the following example:

    ```yaml
    image:
      registry: <ACR-NAME>
      name: contoso-website
      tag: latest
    
    dns:
      name: <DNS-NAME>
    ```

    If you don't have your DNS zone name from the original setup script output, run the following Azure CLI query in a different Cloud Shell window to get it, replacing the `<resource-group-name>` placeholder with your resource group name.
    
    ```azurecli-interactive
    az aks show -g <resource-group-name> -n contoso-website -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

1. Save the file.


## Push your changes

Close the Cloud Shell Editor by selecting the upper right corner of the editor toolbar and then selecting **Close Editor**.

To push all the changes to your fork, run the following commands in Cloud Shell in order:

```bash
git add .
```

```bash
git commit -m "Add helm"
```

```bash
git push -u origin main
```

When prompted, provide the PAT you created earlier as the password.

Proceed to the next unit to deploy your Helm chart and application to AKS by using GitHub Actions.

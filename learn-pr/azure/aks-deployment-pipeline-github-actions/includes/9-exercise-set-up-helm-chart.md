Let's set up the environment to deploy a helm chart to AKS by using GitHub Actions.

## Check Helm installation

1. You need to install Helm if you want to continue your deployment pipeline. In Cloud Shell, the CLI is already installed. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash. If you haven't created a Cloud Shell yet, select **Bash** as the running shell.

1. Run `helm version` and check whether the displayed version is greater than **3**.
1. Pull the changes you've made to the CI workflow in the preceding units by running this command:

    ```bash
    git pull origin main
    ```

## Create a chart

1. `cd` to the repository you forked, and then `cd` to the kubernetes directory.
1. In this directory, run the following command:

    ```bash
    helm create contoso-website
    ```

1. The command should create a new directory called `contoso-website` in the `kubernetes` directory.
1. `cd` into the new directory, and then delete the `charts` and `templates` folders.
1. Create a new empty `templates` folder by using the following command:

    ```bash
    mkdir templates
    ```

    Right now, you have created an empty chart. To start building the workloads, you'll use what others have already built. You'll use YAML files that currently aren't in the new directory you created.

1. Move the old `kubernetes` files to the `templates` folder.

1. From within the `contoso-website` directory, run:

    ```bash
    mv ../*.yaml ./templates
    ```

Completing these steps is all it takes to create a chart. Now, let's configure it.

## Configure the chart

1. Return to the parent directory by running `cd ..`. You should be at the root of the repository now.
1. To open the editor in the current directory, enter `code` .
1. Open the Chart.yaml file.

    The Chart.yaml file is the file that names the chart. This file is where Helm looks for information about the chart itself. You should have a file that looks like this example:

    ```yaml
    apiVersion: v2
    name: contoso-website
    description: A Helm chart for Kubernetes

    # A chart can be either an 'application' or a 'library' chart.
    #
    # Application charts are a collection of templates that can be packaged into versioned archives
    # to be deployed.
    #
    # Library charts provide useful utilities or functions for the chart developer. They're included as
    # a dependency of application charts to inject those utilities and functions into the rendering
    # pipeline. Library charts do not define any templates and therefore cannot be deployed.
    type: application

    # This is the chart version. This version number should be incremented each time you make changes
    # to the chart and its templates, including the app version.
    # Versions are expected to follow Semantic Versioning (https://semver.org/)
    version: 0.1.0

    # This is the version number of the application being deployed. This version number should be
    # incremented each time you make changes to the application. Versions are not expected to
    # follow Semantic Versioning. They should reflect the version the application is using.
    appVersion: 1.16.0
    ```

    Remove all the comments and unused keys. Leave only the required options. Edit them to look like this example:

    ```yaml
    apiVersion: v2
    name: contoso-website
    description: Chart for the Contoso company website
    version: 0.1.0
    ```

    Save and close the file.

## Configure the chart template files

In this section, you go through each of the template files to set them up and add templating to them.

### Create a deployment

1. In the left menu, open the **kubernetes** folder and find the deployment.yaml file in the templates folder you just moved.

    The file should look like this example:

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

    Let's add templating for this deployment, starting with the `namespace` and `name` keys.

1. Add a new key in the `metadata` section called `namespace` with the following configuration

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

    This means that, by default, you'll deploy this resource into the `staging` namespace. But, if the installation has a `namespace` option, you'll use that instead.

1. Let's jump to the `image` key.

    It's a good practice to split up the `registry`, `tag`, and `image` parts of the image name. Add three new template variables to this part.

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
            - image: {{ .Values.image.registry }}/{{ .Values.image.name }}:{{ default "latest" .Values.image.tag }}
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

    In this section, you're splitting the three sections of the image so you can better work with them separately.

1. Save and close the file.
1. Open the `values.yaml` file in the root of the `contoso-website` directory
1. Remove all contents within the file, you should end up with an empty YAML file. Now let's include your content in it.

     You saw earlier that you used `{{ .Release.Namespace }}`, so `Release` is a __variable scope__. Each variable scope has different default values and variables.

    Helm uses the `values.yaml` file to retrieve all the template values that start with `{{ .Values }}`, the `values.yaml` file is another variable scope.

    The structure of this file should follow the same structure you're using when calling our variables. So let's take a quick look in the `deployment.yaml` file you edited and check out the structure.

    Notice you're using `.Values.image.registry`, `.Values.image.name`, and `.Values.image.tag`. Create the `values.yaml` file as follows:

    ```yaml
    image:
      registry: <your-acr-name>
      name: contoso-website
      tag: latest
    ```

    These values will act as the __default__ values if no value is passed as parameter through the `--set` option of Helm CLI.

1. Save and close the file.

## Create a service

1. Find and open the `service.yaml` file.

    Add a new key called `namespace` within the `metadata` section and use the same value you put in the `deployment.yaml` file.

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

1. Save and close the file.

## Create an Ingress

Let's change the `ingress.yaml` file.

1. Find and open the `ingress.yaml` file

    Add a new key called `namespace` within the `metadata` section and use the same value you put in the `deployment.yaml` file

    ```yaml
    apiVersion: v1
    kind: Ingress
    metadata:
      name: contoso-website
      namespace: {{ default "staging" .Release.Namespace }}
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso.!DNS!
          http:
            paths:
              - backend:
                  serviceName: contoso-website
                  servicePort: http
                path: /
    ```

    Jump to the `host` key. In this part you'll need to create different hosts for different deployments, you can't have users accessing the `staging` namespace through production URLs.

    Concatenate the namespace in the hostname, the HTTP Application Routing add-on in the AKS cluster will do the naming resolution automatically.

    ```yaml
    apiVersion: v1
    kind: Ingress
    metadata:
      name: contoso-website
      namespace: {{ default "staging" .Release.Namespace }}
      annotations:
        kubernetes.io/ingress.class: addon-http-application-routing
    spec:
      rules:
        - host: contoso-{{ default "staging" .Release.Namespace }}.!DNS!
          http:
            paths:
              - backend:
                  serviceName: contoso-website
                  servicePort: http
                path: /
    ```

    Now add a new template variable that will be your DNS zone name

    ```yaml
    apiVersion: v1
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
                  serviceName: contoso-website
                  servicePort: http
                path: /
    ```

1. Save and close the file.
1. Open the `values.yaml` file, let's add the `dns.name` key, so it looks like this:

    ```yaml
    image:
      repository: <acr-name>
      name: contoso-website
      tag: latest

    dns:
      name: <your-dns-zone-name>
    ```

    You can obtain your DNS zone name by running the following Azure CLI query:

    ```azurecli-interactive
    az aks show -g {resource-group-name} -n {aks-cluster-name} -o tsv --query addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
    ```

1. Save and close the file.
1. Push all the changes to the fork using the following command:

    ```bash
    git push -u origin main
    ```

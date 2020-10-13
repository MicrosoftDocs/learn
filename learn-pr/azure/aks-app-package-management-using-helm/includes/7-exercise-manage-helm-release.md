Helm charts make it easy to install, upgrade, roll back, and delete an application on a Kubernetes cluster. Earlier, the team was successful in installing the pre-configured Helm chart from the Azure Marketplace Helm repository.

To test the management of release upgrades and rollbacks, the team decides to simulate the experience by installing a basic .NET Core Blazor Server application.

In this exercise, you'll customize an existing Helm chart to install, upgrade, roll back, and delete a Helm release.

## Review the Helm chart folder structure

This exercise uses the `aspnet-core` Helm chart you installed earlier from the Azure Marketplace as a foundation to install a .NET Core Blazor Server app. The source code to the application is already downloaded as part of the AKS cluster creation exercise and available in the `clouddrive/mslearn-aks/modules/learn-helm-deploy-aks/src/drone-webapp` folder.

If you completed previous exercise, you'll find a cache copy of the Helm chart in the `$HOME/.cache/helm/repository` folder in the Cloud Shell.

1. List the contents of the `$HOME/.cache/helm/repository` folder to locate the `aspnet-core-0.2.0.tgz` file.

    ```bash
    ls $HOME/.cache/helm/repository -l
    ```

    The command should return a result similar to the following output.

    ```output
    -rw-r--r-- 1 user user   25425 Sep  8 13:38 aspnet-core-0.2.0.tgz
    -rw-r--r-- 1 user user    1198 Sep  8 13:17 azure-marketplace-charts.txt
    -rw-r--r-- 1 user user 2082600 Sep  8 13:17 azure-marketplace-index.yaml
    ```

    All Helm charts install from repositories are cached in this folder. If you're interested inspecting or modifying the contents of a chart, you can extract the zipped package from the cache folder and install the chart as a local chart.

    For this exercise, the chart is already unpacked and available in the `clouddrive/mslearn-aks/modules/learn-helm-deploy-aks/src/drone-webapp-chart` folder.

1. Inspect the existing Helm chart by recursively listing all contents of the drone-webapp-chart folder.

    ```bash
    cd clouddrive/mslearn-aks/modules/learn-helm-deploy-aks/src
    find drone-webapp-chart/ -print
    ```

    The command should return a result similar to the following output.

    ```output
    drone-webapp-chart/
    drone-webapp-chart/.helmignore
    drone-webapp-chart/Chart.yaml
    drone-webapp-chart/charts
    drone-webapp-chart/README.md
    drone-webapp-chart/templates
    drone-webapp-chart/templates/deployment.yaml
    drone-webapp-chart/templates/extra-list.yaml
    drone-webapp-chart/templates/health-ingress.yaml
    drone-webapp-chart/templates/hpa.yaml
    drone-webapp-chart/templates/ingress.yaml
    drone-webapp-chart/templates/NOTES.txt
    drone-webapp-chart/templates/pdb.yaml
    drone-webapp-chart/templates/service.yaml
    drone-webapp-chart/templates/serviceaccount.yaml
    drone-webapp-chart/templates/tls-secret.yaml
    drone-webapp-chart/templates/_helpers.tpl
    drone-webapp-chart/values.yaml
    ```

    Notice the following components in this chart:

    - a `Chart.yaml` file (`drone-webapp-chart/charts/common/Chart.yaml`)
    - a `values.yaml` file (`drone-webapp-chart/charts/common/values.yaml`)
    - a number of templates on the `templates/` folder (`drone-webapp-chart/templates`)
    - an empty `charts/` folder

1. Open the `drone-webapp-chart/Chart.yaml` to review the chart's dependencies by using the built-in Cloud Shell editor.

    ```bash
    code drone-webapp-chart/Chart.yaml
    ```

    The editor will show the following YAML.

    ```yml
    apiVersion: v2
    appVersion: 0.0.1
    description: ASP.NET Core is an open-source framework created by Microsoft for building
      cloud-enabled, modern applications.
    home: https://dotnet.microsoft.com/apps/aspnet
    icon: https://bitnami.com/assets/stacks/aspnet-core/img/aspnet-core-stack-220x234.png
    keywords:
    - asp.net
    - dotnet
    maintainers:
    - email: containers@bitnami.com
    - name: Bitnami
    name: drone-tracker
    sources:
    - https://github.com/bitnami/bitnami-docker-aspnet-core
    annotations:
     category: DeveloperTools
    version: 0.2.0
    dependencies:
      - name: common
        version: 0.x.x
        repository: https://marketplace.azurecr.io/helm/v1/repo
        tags:
          - bitnami-common
    ```

    Notice the dependencies section at the bottom of the file. This information shows you that there's a subchart to the main chart. However, this chart isn't yet available.

1. Try to install the chart using the flowing `helm install` command.

    ```bash
    helm install drone-webapp ./drone-webapp-chart/
    ```

    The command should return a result similar to the following output.

    ```output
    Error: found in Chart.yaml, but missing in charts/ directory: common
    ```

    The reason for the error, is that Helm is expecting to find the `common` chart in the charts folder.

1. Run the `helm dependency build` command to download the missing chart.

    ```bash
    helm dependency build ./modules/learn-helm-deploy-aks/src/drone-webapp-chart
    ```

    The command should return a result similar to the following output.

    ```output
    Hang tight while we grab the latest from your chart repositories...
    ...Successfully got an update from the "azure-marketplace" chart repository
    Update Complete. ⎈Happy Helming!⎈
    Saving 1 charts
    Downloading common from repo https://marketplace.azurecr.io/helm/v1/repo
    Deleting outdated charts
    ```

1. Review the files in the `drone-webapp-chart` folder to see the contents of Helm download.

    ```bash
        find drone-webapp-chart/ -print
    ```

    The command should return a result similar to the following output. The output is shortened for brevity.

    ```bash
    drone-webapp-chart/
    ...
    drone-webapp-chart/charts
    drone-webapp-chart/charts/common-0.6.2.tgz
    drone-webapp-chart/README.md
    drone-webapp-chart/templates
    drone-webapp-chart/templates/deployment.yaml
    ...
    drone-webapp-chart/values.yaml
    ```

    A subchart named `common` is now available in the `charts/` folder. You can extract the contents of the `common-0.6.2.tgz` package if you're interested in its contents. However, unpacking the file isn't required to complete the installation of the chart.

    Here is the command to unpack the file and list the folder contents:

    ```bash
    gzip -dc ./drone-webapp-chart/charts/common-0.6.2.tgz | tar -xf - -C ./drone-webapp-chart/charts/
    find drone-webapp-chart/ -print
    ```

    The command should return a result similar to the following output. The output is shortened for brevity.

    ```bash
    drone-webapp-chart/
    ...
    drone-webapp-chart/charts
    drone-webapp-chart/charts/common
    drone-webapp-chart/charts/common/.helmignore
    drone-webapp-chart/charts/common/Chart.yaml
    drone-webapp-chart/charts/common/README.md
    drone-webapp-chart/charts/common/templates
    drone-webapp-chart/charts/common/templates/_capabilities.tpl
    drone-webapp-chart/charts/common/templates/_errors.tpl
    drone-webapp-chart/charts/common/templates/_images.tpl
    drone-webapp-chart/charts/common/templates/_labels.tpl
    drone-webapp-chart/charts/common/templates/_names.tpl
    drone-webapp-chart/charts/common/templates/_secrets.tpl
    drone-webapp-chart/charts/common/templates/_storage.tpl
    drone-webapp-chart/charts/common/templates/_tplvalues.tpl
    drone-webapp-chart/charts/common/templates/_utils.tpl
    drone-webapp-chart/charts/common/templates/_validations.tpl
    drone-webapp-chart/charts/common/templates/_warnings.tpl
    drone-webapp-chart/charts/common/values.yaml
    drone-webapp-chart/charts/common-0.6.2.tgz
    drone-webapp-chart/README.md
    drone-webapp-chart/templates
    drone-webapp-chart/templates/deployment.yaml
    ...
    drone-webapp-chart/values.yaml
    ```

    Notice how the subchart also replicates the standard chart structure. It has a `Chart.yaml` file, a `values.yaml` file, and a `templates/` folder. However, there's a difference. All of the files in the templates folder end with the `.tpl` extension. These files contain custom functions used in the main chart.

    Recall, a chart dependency isn't limited to other applications. You may decide to reuse template logic across your charts and create a dependency specific to manage this logic as a chart dependency.

## Review the chart `values.yaml` file

The `aspnet-core` Helm chart has an extensive set of configuration options available to manage the overall deployment of a cloud-native web app. It's helpful to review the contents of the `values.yaml` to get an overview of the deployment.

1. Open the `values.yaml` in the Cloud Shell editor.

    ```bash
    code ./drone-webapp-chart/values.yaml
    ```

    There are a number of sections that are of interest in this file. Let's review two sections and how they impact the final deployed app.

1. Search for the `image` value to see which image is used for the web app.

    ```yaml
    ...
    image:
      registry: docker.io
      repository: bitnami/aspnet-core
      tag: 3.1.7-debian-10-r0
      ## Specify a imagePullPolicy
      ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
      ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
      ##
      pullPolicy: IfNotPresent
      ## Optionally specify an array of imagePullSecrets.
      ## Secrets must be manually created in the namespace.
      ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
      ##
      # pullSecrets:
      #   - myRegistryKeySecretName
    ...
    ```

    Notice the `bitnami/aspnet-core` Docker image. This image is the app's base image and contains an installation of [ASP.NET Core](https://dotnet.microsoft.com/apps/aspnet).

1. Search for the `appFromExternalRepo` value. You'll use these values you to generate the `deployment.yaml` manifest file. Here is an extract of the `appFromExternalRepo` section in the `values.yaml` file.

    ```yml
    ## Enable to download/build ASP.NET Core app from external git repository.
    ## Do not enable it if your docker image already includes your application
    ##
    appFromExternalRepo:
        enabled: true
        clone:
        ## Bitnami Git image version
        ## ref: https://hub.docker.com/r/bitnami/git/tags/
        ##
        image:
            registry: docker.io
            repository: bitnami/git
            tag: 2.28.0-debian-10-r9
            ## Specify a imagePullPolicy
            ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
            ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
            ##
            pullPolicy: IfNotPresent
            ## Optionally specify an array of imagePullSecrets.
            ## Secrets must be manually created in the namespace.
            ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
            ##
            # pullSecrets:
            #   - myRegistryKeySecretName
        ## Git repository to clone
        ##
        repository: https://github.com/MicrosoftDocs/mslearn-aks.git
        ## Git revision to checkout
        ##
        revision: main
        publish:
        ## Bitnami .NET SDK image version
        ## ref: https://hub.docker.com/r/bitnami/dotnet-sdk/tags/
        ##
        image:
            registry: docker.io
            repository: bitnami/dotnet-sdk
            tag: 3.1.302-debian-10-r19
            ## Specify a imagePullPolicy
            ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
            ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
            ##
            pullPolicy: IfNotPresent
            ## Optionally specify an array of imagePullSecrets.
            ## Secrets must be manually created in the namespace.
            ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
            ##
            # pullSecrets:
            #   - myRegistryKeySecretName
        ## Sub folder under the Git repository containing the ASP.NET Core app
        ##
        #subFolder: aspnetcore/fundamentals/servers/kestrel/samples/3.x/KestrelSample
        subFolder: modules/learn-helm-deploy-aks/src/drone-webapp
        ## Extra flags to be appended to "dotnet publish" command
        ##
        extraFlags: []
        ## Command to start downloaded ASP.NET Core app
        ##
        #startCommand: ["dotnet", "KestrelSample.dll"]
    ```

    There are several items specified in this section to note.

    - The `bitnami/git` image

    - The `bitnami/dotnet-sdk` image

    - The GitHub repo `https://github.com/MicrosoftDocs/mslearn-aks.git`

    - The app source code repository subfolder `modules/learn-helm-deploy-aks/src/drone-webapp`

    Each of these values is used in the `templates/deployment.yaml` file.

1. Next, search for the `ingress` value in the `values.yaml` file. You'll use these values to generate the `ingress.yaml` manifest file. Here is an extract of the `ingress` section in the `values.yaml` file.

    ```yml
    ingress:
      ## Set to true to enable ingress record generation
      ##
      enabled: true

      ## Set this to true in order to add the corresponding annotations for cert-manager
      ##
      certManager: false

      ## When the ingress is enabled, a host pointing to this will be created
      ## If no host is set, a wildcard (*) assignment is done
      hostname: aspnet-core.local

      ## Ingress annotations done as key:value pairs
      ## For a full list of possible ingress annotations, please see
      ## ref: https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md
      ##
      ## If certManager is set to true, annotation kubernetes.io/tls-acme: "true" will automatically be set
      ##
      annotations: {}

      ## Enable TLS configuration for the hostname defined at ingress.hostname parameter
      ## TLS certificates will be retrieved from a TLS secret with name: {{- printf "%s-tls" .Values.ingress.hostname }}
      ## You can use the ingress.secrets parameter to create this TLS secret, relay on cert-manager to create it, or
      ## let the chart create self-signed certificates for you
      ##
      tls: false

      ## The list of additional hostnames to be covered with this ingress record.
      ## Most likely the hostname above will be enough, but in the event more hosts are needed, this is an array
      ## extraHosts:
      ## - name: aspnet-core.local
      ##   path: /

      ## The tls configuration for additional hostnames to be covered with this ingress record.
      ## see: https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
      ## extraTls:
      ## - hosts:
      ##     - aspnet-core.local
      ##   secretName: aspnet-core.local-tls

      ## If you're providing your own certificates, please use this to add the certificates as secrets
      ## key and certificate should start with -----BEGIN CERTIFICATE----- or -----BEGIN RSA PRIVATE KEY-----
      ## name should line up with a secretName set further up
      ##
      ## If it is not set and you're using cert-manager, this is unneeded, as it will create the secret for you
      ## If it is not set and you're NOT using cert-manager either, self-signed certificates will be created
      ## It is also possible to create and manage the certificates outside of this helm chart
      ## Please see README.md for more information
      ##
      secrets: []
      ## - name: aspnet-core.local-tls
      ##   key:
      ##   certificate:
    ```

    This section allows you to configure many aspects of the final Ingress file. For this exercise, you're only going to use the `ingress.enabled` value.

## Review the `deployment.yaml` and `ingress.yaml` template files

The values in the `values.yaml` file, is combined with the templates in the chart's `templates/` folder to create the final manifest files. It's helpful to review the contents of the `deployment.yaml` and the `ingress.yaml` files to get an overview of the deployment.

1. Open the `templates/deployment.yaml` in the Cloud Shell editor.

    ```bash
    code ./drone-webapp-chart/templates/deployment.yaml
    ```

    Here is an extract of the files contents. The output is shortened for brevity.

    ```yml
    apiVersion: {{ include "common.capabilities.deployment.apiVersion" . }}
    kind: Deployment
    metadata:
      ...
    spec:
      replicas: {{ .Values.replicaCount }}
      ...
          initContainers:
            {{- if .Values.appFromExternalRepo.enabled }}
            - name: clone-repository
              image: {{ include "aspnet-core.git.image" . }}
              imagePullPolicy: {{ .Values.appFromExternalRepo.clone.image.pullPolicy | quote }}
              command:
                - /bin/bash
                - -ec
                - |
                  git clone {{ .Values.appFromExternalRepo.clone.repository }} --branch {{ .Values.appFromExternalRepo.clone.revision }} /repo
              volumeMounts:
                - name: repo
                  mountPath: /repo
            - name: dotnet-publish
              image: {{ include "aspnet-core.sdk.image" . }}
              imagePullPolicy: {{ .Values.appFromExternalRepo.publish.image.pullPolicy | quote }}
              workingDir: /repo
              command:
                - /bin/bash
                - -ec
                - |
                  cd {{ .Values.appFromExternalRepo.publish.subFolder }}
                  dotnet publish -o /app {{ .Values.appFromExternalRepo.publish.extraFlags | join " " }}
              volumeMounts:
                - name: app
                  mountPath: /app
                - name: repo
                  mountPath: /repo
            {{- end }}
            {{- if .Values.initContainers }}
            {{- include "common.tplvalues.render" (dict "value" .Values.initContainers "context" $) | nindent 8 }}
            {{- end }}
          {{- end }}
          ...
    ```

    Notice that this file has the structure of a Deployment manifest, but the final information that goes into the file, is dependent on values from the `values.yaml` file and template control flow logic.

    For example, the `spec.replicas` for this deployment is defined by `{{ .Values.replicaCount }}` and how container initialization is determined by the `.Values.appFromExternalRepo.enabled` value in the `{{- if .Values.appFromExternalRepo.enabled }}` statement. 

    The rest of this section then makes use of the Git image and repository values to clone the repo and build the web app.

1. Open the `templates/ingress.yaml` in the Cloud Shell editor.

    ```bash
    code ./drone-webapp-chart/templates/ingress.yaml
    ```

    Here is an extract of the files contents. The output is shortened for brevity.

    ```yml
    {{- if .Values.ingress.enabled -}}
    apiVersion: extensions/v1beta1
    kind: Ingress
    metadata:
      name: {{ include "aspnet-core.fullname" . }}
      labels: {{- include "common.labels.standard" . | nindent 4 }}
        {{- if .Values.commonLabels }}
        {{- include "common.tplvalues.render" ( dict "value" .Values.commonLabels "context" $ ) | nindent 4 }}
        {{- end }}
      annotations:
        {{- if .Values.ingress.certManager }}
        kubernetes.io/tls-acme: "true"
        {{- end }}
        {{- if .Values.ingress.annotations }}
        {{- include "common.tplvalues.render" ( dict "value" .Values.ingress.annotations "context" $) | nindent 4 }}
        {{- end }}
        {{- if .Values.commonAnnotations }}
        {{- include "common.tplvalues.render" ( dict "value" .Values.commonAnnotations "context" $ ) | nindent 4 }}
        {{- end }}
    spec:
      ...
    {{- end }}
    ```

    Notice how the Ingress manifest is dependent on the `{{- if .Values.ingress.enabled -}`} statement.

## Deploy the Helm chart

You're now ready to deploy the web app. You'll run the `helm install` command, which runs the template engine to create the various manifest files and deploy the chart release.

1. Deploy the drone-webapp Helm chart by using the `helm install` command.

    ```bash
    helm install drone-webapp ./drone-webapp-chart
    ```

    You can view the installation process by running the `kubectl get pods` command with the wait parameter. This parameter polls the result of the command and continuously updates the output. Use `Ctrl+c` to exit the command.

    ```bash
    kubectl get pods -w
    ```

1. Once the web app is running, open die cluster's load balancer IP address in a browser to see the web app running. List the content of the `create-aks-exports.txt` file to find the IP address of the load balancer.

    ```bash
    cat ~/clouddrive/mslearn-aks/create-aks-exports.txt
    ```

    Here is an example of the app running in a web browser.

    :::image type="content" source="../media/7-web-app-browser.png" alt-text="{alt-text}":::

## Upgrade the Helm release

The development team updated the source code of the web app. To deploy a new version, you'll use the `helm upgrade` command to create a delta of the latest changes to the app.

1. Your first step is to list all Helm deployments by using the `helm list` command. This command allows you to see what the current revision count for all Helm releases.

    ```bash
    helm list
    ```

    The command should return a result similar to the following output.

    ```output
    NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
    drone-webapp    default         1               2020-09-09 13:05:19.063106151 +0000 UTC deployed        drone-tracker-0.2.0       0.0.1
    ```

1. Run the `helm history` command to view the history information about the drone-webapp.

    ```bash
    helm history drone-webapp
    ```

    ```output
    REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
    1               Wed Sep  9 13:05:19 2020        deployed        drone-tracker-0.2.0       0.0.1           Install complete
    ```

1. Open the `Chart.yaml` file by opening the integrated editor in Cloud Shell and update the version number of the application.

    ```bash
    code ./drone-webapp-chart/Chart.yaml
    ```

    Update the `appVersion` number to version `0.0.2` and run the following `helm upgrade` command.

    ```bash
    helm upgrade drone-webapp ./drone-webapp-chart
    ```

1. Run the `helm history` command to view the history information about the drone-webapp.

    ```bash
    helm history drone-webapp
    ```

    The command should return a result similar to the following output.

    ```output
    REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
    1               Wed Sep  9 13:19:12 2020        superseded      drone-tracker-0.2.0       0.0.1           Install complete
    2               Wed Sep  9 13:22:36 2020        deployed        drone-tracker-0.2.0       0.0.2           Upgrade complete
    ```

## Roll back the Helm release

Since the upgrade of the release, a number of customers reported errors on the website. The team asks you to roll back the release to the previous stable version of the app. You'll use the `helm rollback` command to roll back the app.

1. Roll back the Helm release by using the `helm rollback` command and specifying the revision number of the release you're targeting.

    ```bash
    helm rollback drone-webapp 1
    ```

1. Once rollback is complete, view the Helm deployment history by using the `helm history` command.

    ```bash
    helm history drone-webapp
    ```

    The command should return a result similar to the following output.

    ```output
    REVISION        UPDATED                         STATUS          CHART                   APP VERSION     DESCRIPTION
    1               Wed Sep  9 13:25:08 2020        superseded      drone-tracker-0.2.0     0.0.1           Install complete
    2               Wed Sep  9 13:26:45 2020        superseded      drone-tracker-0.2.0     0.0.2           Upgrade complete
    3               Wed Sep  9 13:33:38 2020        deployed        drone-tracker-0.2.0     0.0.1           Rollback to 1
    ```

    Notice the last entry in the list shows the following information:

    - An incremented revision number

    - The app version number of the rollback release

    - A description of the rollback release revision number

When deploying, versioning, and updating applications, you need to ensure you have the correct versions of software libraries and configurations so that the application functions as expected.

Let's say your development team decides to deploy the pet store company website to Kubernetes. As part of the process, your team creates deployment, service, and ingress YAML-based files. You hardcode and maintain the information in each file for each target environment by hand. However, maintaining three files for each environment is cumbersome and increases in complexity as the application grows.

:::image type="content" source="../media/2-deploy-with-yaml-files.svg" border="false" alt-text="A diagram that shows a container deployed to a Kubernetes node using a deployment, a service, and an ingress YAML file.":::

You can use Helm to simplify the application deployment process and avoid hardcoded deployment variables and settings.

## What is Helm?

Helm is a package manager for Kubernetes that combines all your application's resources and deployment information into a single deployment package.

:::image type="content" source="../media/2-what-is-helm.svg" border="false"  alt-text="A diagram shows a containerized app deployed to a Kubernetes cluster using a Helm chart.":::

You can think of Helm similarly to the Windows Package Manager on Windows, the Advanced Package Tool (apt) on Linux, or Homebrew on macOS. You specify the name of the application you want to install, update, or remove, and Helm takes care of the process.

With Helm, you aren't limited to installing a single app at a time. Helm allows you to create templated, human-readable YAML script files to manage your application's deployment. These template files allow you to specify all required dependencies, configuration mapping, and secrets used to manage the deploy of an application successfully.

Helm uses four components to manage application deployments on a Kubernetes cluster:

- The Helm client
- Helm charts
- Helm releases
- Helm repositories

## What is the Helm client?

The Helm client is **a client installed binary responsible for creating and submitting the manifest files required to deploy a Kubernetes application**. The client is responsible for the interaction between the user and the Kubernetes cluster.

:::image type="content" source="../media/2-helm-components.svg" border="false" alt-text="A diagram shows the communication between three Helm components to create a Helm release; the client, chart, and repository.":::

The Helm client is available for all major operating systems and is installed on your client PC. In Azure, the Helm client is preinstalled in the Cloud Shell and supports all security, identity, and authorization features of Kubernetes.

> [!NOTE]
> This module assumes the use of Helm v3. You can run the `helm version` command to check the Helm version running on your client device. If you're running Helm v2, keep in mind that some of the command parameters in this module will be different.

## What is a Helm chart?

A Helm chart is **a templated deployment package that describes a related set of Kubernetes resources**. It contains all the information required to build and deploy the manifest files for an application to run on a Kubernetes cluster.

A Helm chart consists of several files and folders to describe the chart. Some of the components are required and some are optional. What you choose to include is based on the apps configuration requirements.

The following list describes the file and folder components of a Helm chart with the required items in bold:

| File / Folder | Description |
| ------------- | ----------- |
| **`Chart.yaml`** | A YAML file containing the information about the chart. |
| **`values.yaml`** | The default configuration values for the chart. |
| **`templates/`** | A folder that contains the deployment templates for the chart. |
| `LICENSE` | A plain text file that contains the license for the chart. |
| `README.md` | A markdown file that contains instructions on how to use the chart. |
| `values.schema.json`** | A schema file for applying structure on the values.yaml file. |
| `charts/` | A folder that contains all the subcharts to the main chart. |
| `crds/` | Custom Resource Definitions. |
| `templates/Notes.txt` | A text file that contains template usage notes. |

## What is a Helm release?

A Helm release is **the application or group of applications deployed using a chart**. Each time you install a chart, a new instance of an application is created on the cluster. Each instance has a release name that allows you to interact with the specific application instance.

:::image type="content" source="../media/2-helm-components-release.svg" border="false" alt-text="A diagram shows the communication between three Helm components to create a Helm release: the client, chart, and repository. The release is highlighted.":::

For example, let's say you installed two Nginx instances onto your Kubernetes cluster using a chart. Later, you decide to upgrade the first Nginx instance, but not the second. Since the two releases are different, you can upgrade the first release without impacting the second.

## What is a Helm repository?

A Helm repository is **a dedicated HTTP server that stores information on Helm charts**. The server hosts a file that describes charts and where to download each chart.

:::image type="content" source="../media/2-helm-components-repository.svg" border="false" alt-text="A diagram shows the communication between three Helm components to create a Helm release: the client, chart, and repository. The repository is highlighted.":::

The Helm project hosts many public charts, and many repositories exist from which you can reuse charts. Helm repositories simplify the discoverability and reusability of Helm packages.

## Benefits of using Helm

Helm introduces a number of benefits that simplify application deployment and improves productivity in the development and deployment lifecycle of cloud-native applications. With Helm, you have application releases that are:

- Repeatable,
- Reliable,
- Manageable in multiple and complex environments, and
- Reusable across different development teams.

A Helm chart standardizes the deployment of an application using packaged template logic that's parameterized by set input values. This template-driven package design provides an environment-agnostic approach to deploying and sharing cloud-native applications.

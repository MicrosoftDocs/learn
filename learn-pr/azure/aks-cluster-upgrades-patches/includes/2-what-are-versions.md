Software releases often encounter errors, bugs, or security flaws that require development teams to apply updates and fixes. As software evolves, new features and functionalities are added. These updates and fixes are released as new versions of the software. Versioning is a controlled process that involves tracking and managing software version releases. Software versions typically remain in support for a set period of time, which gives users time to upgrade their software to the latest version.

:::image type="content" source="../media/2-software-version-release-lifecycle.png" border="false" alt-text="Diagram that shows how software evolves over time from its initial release as new bug fixes and features are made through software versioning.":::

## What is semantic versioning?

[Semantic versioning](https://semver.org/) is a versioning scheme comprised of the following version components:

* **Major versions** are released when software evolves from version 1.0.0 to 2.0.0. These versions typically include breaking changes that aren't backward compatible with previous versions.
* **Minor versions** are released when software evolves from 1.0.0 to 1.1.0. These versions typically include new features and functionalities.
* **Patch versions** are released when software evolves from version 1.0.0 to 1.0.1. These versions typically include bug fixes and security updates.

## Kubernetes versioning

Kubernetes uses the semantic versioning scheme. New Kubernetes version releases are only for components of the Kubernetes runtime within the cluster. The Kubernetes runtime includes the following components:

* kube-apiserver
* kubelet
* kube-controller-manager
* kube-scheduler
* kube-proxy

The Kubernetes runtime components don't include node upgrades, such as operating-system updates or image upgrades for nodes running the Kubernetes cluster. This means that you need to apply separate upgrades and patches to the Kubernetes cluster components and the underlying compute nodes supporting the cluster.

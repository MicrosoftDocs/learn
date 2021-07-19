
Versioning in software allows for software to evolve in a controlled process over time. Software that has been released can often encounter error, bug, or security flaws. These faults are often discovered by the software development and testing team or the users of the software. To apply fixes and updates, a new version of the software is then released. This process is known as patching. Typically, older software versions remain in support for a set period of time. This gives users some time to upgrade to the newest software version. 

:::image type="content" source="../media/2-software-version-release-lifecycle.png" border="false" alt-text="An image that shows how software evolves over time from its initial release as new bug fixes and features are made through software versioning.":::

## What is semantic versioning? 
[Semantic versioning](https://semver.org/) is a versioning scheme that is made up of three components: 

:::image type="content" source="../media/2-major-minor-patch.png" border="false" alt-text="An image that shows the components of semantic versioning is made up of a major version, a minor version, and a patch version component.":::

A major version is released when software evolves from version 1.0.0 to 2.0.0. A minor version is release when the software evolves from 1.0.0 to 1.1.0. And a patch version is released when the software evolves from version 1.0.0 to 1.0.1.

## What are Kubernetes versions? 
Kubernetes follows semantic versioning rules when a new version is released. This means when bug fixes or security fixes are made, a new patch version is released. When Kubernetes decides to roll out new features for cluster components, a new minor version is released. 

The new version releases by Kubernetes are for components of the Kubernetes runtime within the cluster only. These components includes the kube-apiserver, kubelet, kube-controller-manager, kube-scheduler, and kube-proxy. They do not include node upgrades such as operating system updates or image upgrades for nodes that run within the Kubernetes cluster. This means, in addition to applying Kubernetes cluster patches and upgrades, you will also need upgrade and patch the underlying compute nodes that support the Kubernetes cluster as part of a separate upgrades and patches process.

 :::image type="content" source="../media/2-kubernetes-cluster-component-upgrades.png" border="false" alt-text="An image that shows a list of the components that Kubernetes updates with new version releases and a list that shows that node operating system and images are not part of the updates that Kubernetes releases.":::


Versioning in software allows for software to evolve in a controlled process over time. Software that has been released can often encounter error, bug, or security flaws. These faults are often discovered by the software development and testing team or the users of the software. To apply fixes and updates, a new version of the software is then released. This process is known as patching. Typically, older software versions remain in support for a set period of time. This gives users some time to upgrade to the newest software version. 

:::image type="content" source="../media/draft/2-software-version-release-lifecycle.png" border="false" alt-text="An image that shows how software evolves over time from its initial release as new bug fixes and features are made through software versioning.":::

## What is semantic versioning? 
[Semantic versioning](https://semver.org/) is a versioning scheme that is made up of three components: 

:::image type="content" source="../media/draft/2-major-minor-patch.png" border="false" alt-text="An image that shows the components of semantic versioning is made up of a major version, a minor version, and a patch version component.":::

The major version tells us that this is the first time we are releasing this type of software. For example, when Songify first launched the music software to the public, version 1.0.0 was released.  

When Songify decided to add new features to the music software to improve the product, a minor version is released. For example, Songify added a new feature that automatically generates lyrical words over the soundtracks. This new version is version 1.1.0 of the music software.

:::image type="content" source="../media/draft/2-minor-version.png" border="false" alt-text="An image that shows that when a new feature is added to an existing software, a new minor version of that software is released.":::

The patch version is typically an indication of bug fixes. When the music software was first launched, users found they could only log into their music application on one device at a time. They filed a complaint and requested the development team to make some changes. Soon, the development team released version 1.0.1 of the software to improve the performance of the music application. Version 1.0.1 now allows users to sign into their music application from multiple devices.

:::image type="content" source="../media/draft/2-patch-version.png" border="false" alt-text="An image that shows that when a bug fix is made to the software, a new patch version of that software is released.":::

## What are Kubernetes versions? 
Kubernetes follows semantic versioning rules when a new version is released. This means when bug fixes or security fixes are made, a new patch version is released. When Kubernetes decides to roll out new features for cluster components, a new minor version is released. 

The new version releases by Kubernetes are for components of the Kubernetes runtime within the cluster only. These components includes the kube-apiserver, kubelet, kube-controller-manager, kube-scheduler, and kube-proxy. They do not include node upgrades such as operating system updates or image upgrades for nodes that run within the Kubernetes cluster. This means, in addition to applying Kubernetes cluster patches and upgrades, you will also need upgrade and patch the underlying compute nodes that support the Kubernetes cluster as part of a separate upgrades and patches process.

 :::image type="content" source="../media/draft/2-kubernetes-cluster-component-upgrades.png" border="false" alt-text="An image that shows a list of the components that Kubernetes updates with new version releases and a list that shows that node operating system and images are not part of the updates that Kubernetes releases.":::

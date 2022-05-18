Several tools are available from third parties to help assess the security and license rating of software packages in use.

As discussed in the previous section, one approach by these tools is to provide a centralized artifact repository.

Scanning can be done at any time, inspecting the packages part of the repository.

The second approach uses tooling that scans the packages used in a build pipeline.

During the build process, the tool can scan the packages by the build, giving instantaneous feedback on the packages in use.

## Inspect packages in the delivery pipeline

There's tooling available to do security scans on packages, components, and source code while running a delivery pipeline. Often such tooling will use the build artifacts during the build process and do scans. The tooling can either work on a local artifact repository or the intermediary build output. Some examples for each are products like:

:::row:::
  :::column:::
    **Tool**
  :::column-end:::
  :::column:::
    **Type**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Artifactory
  :::column-end:::
  :::column:::
    Artifact repository
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SonarQube
  :::column-end:::
  :::column:::
    A static code analysis tool
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    WhiteSource (Bolt)
  :::column-end:::
  :::column:::
    Build scanning.
  :::column-end:::
:::row-end:::


## Configure pipeline

The configuration of the scanning for license types and security vulnerability in the pipeline is done by using appropriate build tasks in your DevOps tooling. For Azure DevOps, these are build pipeline tasks.

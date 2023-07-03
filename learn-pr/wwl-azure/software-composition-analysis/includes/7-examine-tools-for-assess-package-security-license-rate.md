
Several tools are available from third parties to help assess software packages' security and license rating.

As discussed in the previous section, one approach by these tools is to provide a centralized artifact repository.

Scanning can be done at any time, inspecting the packages part of the repository.

The second approach uses tooling that scans the packages used in a build pipeline.

During the build process, the tool can scan the packages by the build, giving instantaneous feedback on the packages in use.

## Inspect packages in the delivery pipeline

While running a delivery pipeline, there's tooling available to do security scans on packages, components, and source code. Often such tooling will use the build artifacts during the build process and do scans. The tooling can either work on a local artifact repository or the intermediary build output. Some examples for each are products like:

| **Tool**    | **Type**                    |
| ----------- | --------------------------- |
| Artifactory | Artifact repository         |
| SonarQube   | A static code analysis tool |
| Mend (Bolt) | Build scanning.             |

## Configure pipeline

The configuration of the scanning for license types and security vulnerability in the pipeline is done by using appropriate build tasks in your DevOps tooling. For Azure DevOps, these are build pipeline tasks.

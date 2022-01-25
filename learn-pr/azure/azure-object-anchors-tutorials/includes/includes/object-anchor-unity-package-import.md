# [Web download](#tab/unity-package-web-ui)

Locate the Azure Object Anchors package for Unity (`com.microsoft.azure.object-anchors.runtime`) [here](https://aka.ms/aoa/unity-sdk/package). Select the version you want and download the package using the **Download** button.

Next follow the instructions in [installing a package from a local tarball file](https://docs.unity3d.com/Manual/upm-ui-tarball.html) to import
the Azure Object Anchors package you downloaded into the Unity project using the Unity Package Manager.

# [NPM download](#tab/unity-package-npm)

This step requires that [NPM](https://www.npmjs.com/get-npm?azure-portal=true) is installed and available.

Run the following command replacing `<version_number>` with the version of Azure Object Anchors you want to download:

```bash
npm pack com.microsoft.azure.object-anchors.runtime@<version_number> --registry https://pkgs.dev.azure.com/aipmr/MixedReality-Unity-Packages/_packaging/Unity-packages/npm/registry/
```

> [!NOTE]
> To list the available versions of the Azure Object Anchors package, run the following:
>
> ```bash
> npm view com.microsoft.azure.object-anchors.runtime --registry https://pkgs.dev.azure.com/aipmr/MixedReality-Unity-Packages/_packaging/Unity-packages/npm/registry/ versions
> ```

The Azure Object Anchors package will be downloaded to the folder where you ran the command.

Next follow the instructions in [installing a package from a local tarball file](https://docs.unity3d.com/Manual/upm-ui-tarball.html) to import
the Azure Object Anchors package you downloaded into the Unity project using the Unity Package Manager.

# [Mixed Reality Feature Tool (beta)](#tab/unity-package-mixed-reality-feature-tool)

This step requires that the [Mixed Reality Feature Tool](/windows/mixed-reality/develop/unity/welcome-to-mr-feature-tool) is downloaded and available.

> [!NOTE]
> The [Mixed Reality Feature Tool](/windows/mixed-reality/develop/unity/welcome-to-mr-feature-tool) currently only supports Windows.

1. Follow the [Mixed Reality Feature Tool](/windows/mixed-reality/develop/unity/welcome-to-mr-feature-tool) documentation to set up the tool and learn how to use it.
2. Then you can install "Microsoft Azure Object Anchors" feature package into the Unity project folder.

---

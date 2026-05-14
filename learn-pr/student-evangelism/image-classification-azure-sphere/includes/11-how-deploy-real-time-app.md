So far, you've updated your project with the required data, libraries, and settings. Next, you'll run the Azure Sphere real-time capable application (RTApp) locally and view the classification output.

This sample performs one CIFAR-10 inference at RTApp startup. The input image is not captured at run time. Instead, `main.c` initializes `image_data` from the compile-time `IMG_DATA` macro in `include\arm_nnexamples_cifar10_inputs.h`.

`IMG_DATA` must contain a single 32x32 RGB image as raw, unquantized `uint8_t` values from 0 through 255. The layout is a flat array of `32*32*3 = 3072` values in row-major HWC order: `[R,G,B, R,G,B, ...]`. Don't prequantize or prescale custom image values. `main.c` subtracts the channel means and applies Q7 normalization by using `INPUT_MEAN_SHIFT` and `INPUT_RIGHT_SHIFT` before it runs the CMSIS-NN layers.

The project includes a default `IMG_DATA` sample, so generating a new image header is optional unless you want to test a different image. To use a custom image, resize and convert it to the exact 32x32 RGB `IMG_DATA` layout, copy the generated values into the compile-time header, rebuild the image package, sideload it for local testing, restart or debug the RTApp, and read the terminal output. Cloud deployment is a separate workflow that targets an Azure Sphere catalog, product, and device group.

The component in this unit is:

**cifar-10-IMG_DATA.ipynb:** A Jupyter notebook available in the repository's [scripts folder](https://github.com/MicrosoftDocs/mslearn-oxford-image-classification-azure-sphere/tree/master/scripts). It generates an `IMG_DATA` definition from a source image. The upstream `scripts\requirements.txt` file is a reference list, not a pip-installable requirements file, so install compatible packages directly. Use TensorFlow 2.15 for the notebook's Keras dependency because it includes Keras 2.15; unpinned Keras 3 requires backend configuration and removed `keras.preprocessing.image`, which the notebook uses. If you run the upstream notebook unchanged, install Pillow as `Pillow<10` because the notebook uses `Image.ANTIALIAS`, which was removed in Pillow 10. Alternatively, update a local copy of the notebook to use `Image.Resampling.LANCZOS`; then use a Pillow version that supports `Image.Resampling`, such as current Pillow releases.

Steps you follow are:

1. Define the compile-time `IMG_DATA` input for the RTApp.
2. Build and sideload the RTApp locally to the attached Azure Sphere device.
3. Display the RTApp UART output in your terminal emulator.

By the end of the module, you'll understand how this CMSIS-NN CIFAR-10 sample runs local inference over one compile-time image on an Azure Sphere real-time core.

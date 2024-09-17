Now we’re ready to run the example Python script on the Triton Server. If you look in the `demo` directory, you see a collection of folders and files.  

In the `demo/app` folder, there are two Python scripts. The first, `frame_grabber.py` uses the Triton Inference Server. The second, `frame_grabber_onnxruntime.py` can be used in a standalone fashion. The `utils` folder inside of the `app` directory contains Python scripts to enable the interpretation of the model’s output tensor.
  
Both Python scripts are set to watch the `image_sink` directory for any image files that are placed there. In the `images-sample`, you find a collection of images that we copy via command line to the `image_sink` for processing. The Python scripts automatically delete the files from the `image_sink` after the inference is completed.

In the `model-repo` folder, you find a folder for the name of the model (gtc_onnx), which holds the model configuration file for the Triton Inference server, and the label file. Also included is a folder denoting the version of the model, which contains the Open Neural Network Exchange (ONNX) model that the server uses to inference.

If the model detects the objects it trained on, the Python script creates an annotation of that inference with a bounding box, tag name, and confidence score. The script saves the image into the `images-annotated` folder with a unique name using a timestamp, which we can download to view locally. That way, you can copy the same images over and over again to the `image_sink` but have new annotated images created each run for illustration purposes.

## Execute an inference workload on NVIDIA Triton Inference Server

1. To get started on the inferencing, we want to open two windows in the Windows Terminal, and `ssh` into the virtual machine from each window.

1. In the first window, run the following command, but first change out the *\<your username\>* place holder with your username for the virtual machine:

    ```bash
    sudo docker run --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 --rm -p8000:8000 -p8002:8002 -v/home/<your username>/demo/model-repo:/models nvcr.io/nvidia/tritonserver:20.11-py3 tritonserver --model-repository=/models
    ```

1. In the second window, copy the following command, changing *\<your username\>* to your value, and set the *\<probability threshold\>* to your desired confidence level between 0 and 1. By default, this value is set to 0.6.

    ```bash
    python3 demo/app/frame_grabber.py -u <your username> -p .07
    ```

1. In the third window, copy and paste this command to copy the image files from the `images_sample` folder to the `image_sink` folder:

    ```bash
    cp demo/images_sample/* demo/image_sink/
    ```

    If you go back to your second window, you can see the execution of the model, including the model statistics and the returned inference in the form of a Python dictionary.

    Here's a sample view of what you should see in the second window as the script executes:

    :::image type="content" source="../media/4-script-output.png" alt-text="A screenshot showing the output of the Python script." lightbox="../media/4-script-output.png":::

1. If you want to see a list of your annotated images, you can run this command:

    ```bash
    ls demo/annotated_images
    ```

1. To download the images to your local machine, we first want to create a folder to receive the images. In a command line window, `cd` to the directory that you want to place the new folder in, and run:

    ```bash
    mkdir annotated_img_download
    scp <your usename>@x.x.x.x:/home/<your username>/demo/images_annotated/* annotated_img_download/
    ```

    This command copies all of the files from the Ubuntu virtual machine to your local device for viewing.

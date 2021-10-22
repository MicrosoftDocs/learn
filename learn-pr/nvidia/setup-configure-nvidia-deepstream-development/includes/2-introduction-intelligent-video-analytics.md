Every day, video cameras produce volumes of data in popular business domains.  These areas include hospital, manufacturing, retail, and smart city environments. Many of these deployments can be enhanced with the addition of AI that operates on the data produced by the camera sensors in real time.  

Imagine being able to monitor enforcement of health advisories or adherence to safety protocols at job sites, adapt to customer demographics, or respond to traffic events in an automated way. You can accomplish these scenarios by using video-based solutions that apply AI to Internet of Things devices deployed at the edge.

We refer to these types of solutions as *Intelligent Video Analytics (IVA)* applications. They extract actionable insights through the application of computer vision algorithms that operate on live video frames.  This table describes three types of computer vision algorithms:  

| Computer vision algorithm  | Capabilities  |
|---|---|
| Object detection ![Image that shows an example of object detection with computer vision.](../media/object-detection.png) | Object detection models are trained to classify individual objects in an image and identify their location with a bounding box. For example, a traffic monitoring solution might use object detection to identify the location of various classes of vehicles.  |
| Image classification ![Image that shows an example of image classification with computer vision.](../media/image-classification.png) | Image classification involves training a machine learning model to classify images based on their content. For example, in a traffic monitoring solution, you might use an image classification model to classify images based on the type of vehicle they contain, like taxis, buses, bicycles, and so on.  |
| Object tracking ![Image that shows an example of object tracking with computer vision.](../media/people-counting.png)  |  You can apply object tracking to an object detected via object detection. The object is assigned an identity that you can reference through successive inference passes in an IVA pipeline. For example, you could use object tracking to count unique instances of people in an area.  |

You can do powerful assessments by using these algorithms in combination to achieve functionality known as *cascading inference*. Here's an example of this technique: 
1. Identify a vehicle and its location in the frame by using object detection. 
1. Use a tracker that assigns each vehicle a unique ID to count the number of vehicles in the area. 
1. Use an image classification model to determine each vehicle's color.

Once we are able to generate insights in this fashion, we can employ more services to make use of this data by offloading to cloud services in Microsoft Azure where data can be live-processed, trigger automation tasks, or archived for historic analysis.  

## Enabling Development of Intelligent Video Analytics Applications with NVIDIA DeepStream and Microsoft Azure

NVIDIA DeepStream enables the development of Intelligent Video Analytics applications using a multi-platform framework that can be deployed on the edge and connect to cloud services.  This framework can enable you to visually define IVA pipelines using an included development tool called the "NVIDIA Graph Composer".  This tool can allow you to define video sources from File, Local Camera, or Networked RTSP video streams that can feed directly into single or cascading inference operations. These operations produce insights that can then be forwarded on to cloud services for further processing.  By performing the computationally heavy inference tasks locally at the edge, we can reduce the amount of data needed to transmit insights and telemetry to the cloud.

![DeepStream Edge to Cloud Diagram](../media/deepstream-edge-to-cloud-product-page.jpg)

## Hardware and Operating System Requirements

In order to proceed with this module, it is required that you have access to an X86/AMD64 based machine running [Ubuntu 18.04](http://releases.ubuntu.com/18.04/). You will want to ensure that your development machine that has one of the following graphics cards installed and present:

### DeepStream 6.0 Compatible GPUs

* [RTX2080](https://www.nvidia.com/en-us/geforce/graphics-cards/rtx-2080/)  
* [RTX3080](https://www.nvidia.com/en-us/geforce/graphics-cards/30-series/rtx-3080-3080ti/)
* [Tesla T4](https://www.nvidia.com/en-us/data-center/tesla-t4/)
* [Ampere A100](https://www.nvidia.com/en-us/data-center/a100/)

    >[!NOTE]
    >If you intend on using a Virtual Machine to satisfy these requirements, it is possible that you may encounter issues later on in this learning path when attempting to launch the NVIDIA Graph Composer application if you are connecting to your VM over a remote session.  You will still be able to proceed through the learning modules, but we want to ensure that you are aware of this [issue](https://forums.developer.nvidia.com/t/graph-composer-unable-to-start-during-rdp-session-on-azure-vm-with-tesla-t4/186966) should you be considering this option.

### Try this

Consider scenarios where computer vision could be employed to aid in automating a task or simplifying a traditionally complex process.  What would your video feeds need to see?  What computer vision algorithms would need to be employed to satisfy your solution (object detection, image classification, object tracking)?

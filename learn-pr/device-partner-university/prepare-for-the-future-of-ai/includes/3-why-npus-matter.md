NPUs excel at matrixed processing, which is essential for neural networks and AI. In very basic terms, NPUs can handle small bits of information, like grids of numbers, quickly and efficiently. Let’s see what this means in practice.

## Basic example

Let’s say you tasked a neural network using an NPU with identifying this image.

:::image type="content" border="true" source="../media/cat.png" alt-text="Photograph of a cat in front of a computer.":::

The neural network would break down the image into small units of information, each representing a characteristic.

These pieces pass through different layers in the neural network—one identifying edges, one colors, and so on—until the image is identified as a cat. The pieces of data pass through these layers simultaneously.

With an NPU, this complex process happens almost instantaneously.

## NPU processing

The idea of “AI processing” may seem vague. Think of it this way: when tasks can be processed by the NPU instead of the CPU or GPU, it takes an incredible burden off of the system as a whole. With devices with NPUs becoming more popular, the number and types of tasks NPUs can do is growing every day.

:::image type="content" border="true" source="../media/neural-processing-unit.png" alt-text="Photograph of an NPU hero chip set against on one of the illuminated color backgrounds.":::

## Benefits of an NPU

There are a number of advantages to having an NPU in your Windows device.

- **Instantaneous response:** With NPUs, users can perform tasks with little to no latency. For example, imagine you needed to have a report analyzed. If it’s a short report, you could upload it to the cloud and have it analyzed in a few seconds. But a larger report could take much, much longer over the cloud. With an NPU, you could have that massive report analyzed much faster—reducing wait times and frustration.

- **Client context:** NPUs help devices provide context. Let’s stay with our example about analyzing a document. If you send a report to a cloud-based AI solution for analysis, it can read the content of the document. However, on-device AI can take into account things like open applications and browser windows—providing a much broader context for the content.

- **Privacy and security:** NPUs let data stay local. By keeping data stored locally on your PC, you ensure it’s protected by Bitlocker and only able to be accessed by leveraging biometrics like Windows Hello for Business. This means that the data used in on-device AI operations is only accessible to the end user—and nobody else.

- **Connection:** NPUs allow users to work anywhere. With an NPU, employees who rely on compatible AI services can work from anywhere—regardless of the quality or strength of their internet connection.

- **Cost:** NPUs reduce or eliminate costs. While many AI workloads and tasks still rely on the cloud, NPUs enable certain features to be run on the device—saving businesses money on their cloud storage/processing expenses.

- **Sustainability:** NPUs can help support sustainability goals. NPUs enhance sustainability by being highly energy-efficient, performing more inferences per watt, and running computations locally on a single chip rather than sending them to a server for processing. This reduces power consumption and carbon emissions, as there's no need for data transmission to external servers.

In this module we have learned how convolutional neural networks work, and how they can capture patterns in 2D images.

Here's a recap of the key concepts we covered:

- **Image data as tensors**: Representing images as multi-dimensional arrays (H×W for grayscale, H×W×3 for color), and normalizing pixel values.
- **Dense neural networks**: Building single-layer and multi-layer fully connected networks for image classification, including concepts like softmax, one-hot encoding, loss functions, and optimizers.
- **Overfitting**: Recognizing when a model fits training data too well but fails to generalize, and strategies to address it.
- **Convolutional Neural Networks (CNNs)**: Using convolutional filters to extract spatial patterns, pooling layers to reduce dimensionality, and pyramid architectures that combine multiple convolutional layers.
- **Transfer learning**: Leveraging pretrained models like VGG-16 to extract features and build classifiers for custom tasks with less data and training time.

In fact, CNNs can also be used for finding patterns in 1-dimensional signals (such as sound waves, or time series), and in multi-dimensional structures (for example, events in videos where some patterns are repeated across frames). CNNs are also the simple building blocks for solving more complex computer vision tasks, such as Image Generation. **Generative Adversarial Networks (GANs)** and **diffusion models** (such as Stable Diffusion and DALL·E) are used to generate images, with diffusion models representing the current state of the art. Similarly, CNNs are used for object detection, instance segmentation, and more.


The process of training a model can be either supervised or unsupervised. Our goal here is to contrast these approaches, then take a deeper dive into the learning process with a focus on supervised learning. It's worth remembering throughout this discussion that the only difference between supervised and unsupervised learning is how the objective function works.

## What is unsupervised learning?

In unsupervised learning, we train a model to solve a problem without us knowing the correct answer. In fact, unsupervised learning is typically used for problems where there isn't one correct answer, but instead, better and worse solutions.

Imagine that we want our machine-learning model to draw realistic pictures of avalanche rescue dogs. There isn't one "correct" drawing to draw. As long as the image looks somewhat like a dog, we'll be satisfied. But if the produced image is of a cat, that's a worse solution.

Recall that training requires several components:

:::image type="content" source="../media/2-2-a.png" alt-text="Diagram of the model and objective function parts of the machine-learning lifecycle." border="false":::

In unsupervised learning, the objective function makes its judgment purely on the model's estimate. That means the objective function often needs to be relatively sophisticated. For example, the objective function might need to contain a "dog detector" to assess if images that the model draws look realistic. The only data that we need for unsupervised learning is about features that we provide to the model.

## What is supervised learning?

Think of supervised learning as learning by example. In supervised learning, we assess the model's performance by comparing its estimates to the correct answer. Although we can have simple objective functions, we need both:

* Features that are provided as inputs to the model
* Labels, which are the correct answers that we want the model to be able to produce

:::image type="content" source="../media/2-2-b.jpg" alt-text="Diagram of the model and objective function parts of the machine-learning lifecycle, with labels." border="false":::

For example, consider our desire to predict what the temperature will be on January 31 of a given year. For this prediction, we'll need data with two components:

* Feature: Date
* Label: Daily temperature (for example, from historical records)

In the scenario, we provide the date feature to the model. The model predicts the temperature, and we compare this result to the dataset's "correct" temperature. The objective function can then calculate how well the model worked, and we can make adjustments to the model.

## Labels are only for learning

It's important to remember that no matter how models are trained, they only process features. During supervised learning, the objective function is the only component that relies on access to labels. After training, we don't need labels to use our model.

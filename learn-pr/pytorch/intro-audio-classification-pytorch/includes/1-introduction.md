Have you ever wondered how the voice assistants we use everyday work? How do they understand the words that we say?

The assistant must convert the speech to text, and then convert that text into numbers (called *word embedding*). The assistant then classifies the utterance and correlates it to the intent (what the speaker wants the voice assistant to do). For more details on this process, see the "Introduction to natural language processing" module in this PyTorch learning path.

However, how about when a dog barks or a cat meows? These sounds can't be converted into text.

![Image that shows how sounds can come from a variety of sources.](..\images\1-introduction-1.png)

In this module, we'll look at how to extract sound wave patterns from an audio recording of spoken words. Audio classification is useful for many things, not just speech assistants. There are various sound sources that an application needs to recognize. For example, you can classify music genres or detect illness by the tone in someone's voice. There are more applications that haven't even been thought of yet.

You'll learn how to do audio classification with PyTorch, a popular Python machine learning framework. There are many ways to build an audio classification model. You can use a waveform, tag sections of a wave file, or even use computer vision on a spectrogram image.

In this module, you first learn how to understand audio data and transform sound signals into an image representation by using a spectrogram. Then you'll build a model by using computer vision that can understand a *yes* or *no* speech command.

That's right! You can turn audio into an image representation, and then use computer vision to classify the word spoken. 

## Learning objectives

In this module you will:

- Learn the basic features of audio data.
- Learn how to transform sound signals to a visual image format by using spectrograms.
- Build a speech classification model that can recognize sounds or spoken words by using convolutional neural networks (CNNs).

## Prerequisites

- Basic Python knowledge
- Basic knowledge about how to use Jupyter Notebooks
- Basic understanding of CNNs. (A good place to start is the "Introduction to Computer Vision with PyTorch" module in this learning path.)

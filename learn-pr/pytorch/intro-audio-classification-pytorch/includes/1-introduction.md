Have you ever wondered how the voice assistants we use everyday works? How do they understand the words that we say?  The assistant must convert the speech to text, then the NLP step which is the word embedding (turning words into numbers). Lastly, you have a classification of the utterance (what people say) to the intent (what they want the voice assistant to do). If you are following this learning path, this technique is covered in the "Introduction to natural language processing" module in this PyTorch learning path.

However, how about when a dog barks or a cat meows? These sounds cannot be converted into text.
                         
![variety of sounds](/images/1-introduction-1.png)

In this module, we'll look at how to extract sound wave patterns from an audio of words spoken. Of course, audio classification is useful for many things, not just speech assistants. There are a variety of sound sources that an application needs to recognize.  For example, in music, you can classify genres or detect illness by the tone in someone's voice, and even more applications that we haven't even thought of yet.

We will be learning how to do audio classification with PyTorch, a popular Python machine learning framework. There are multiple ways to build an audio classification model. You can use a waveform, tag sections of a wave file, or even use computer vision on a spectrogram image. This module will first break down how to understand audio data and transform sound signals into an image representation using a Spectrogram. Then we will build a simple model using computer vision that can understand a `yes` or `no` speech command.

That's right! You can turn audio into an image representation and then use computer vision to classify the word spoken! 

## Learning objectives

In this module you will:

- Learn the basic features of audio data
- Learn how to transform sound signals to a visual image format using spectrograms
- Build a speech classification model that can recognize sounds or spoken words using CNNs

## Prerequisites

- Basic Python knowledge
- Basic knowledge about how to use Jupyter Notebooks
- Basic understanding of Convolutional Neural Networks (CNNs).  See "Introduction to Computer Vision with PyTorch" module in this learning path
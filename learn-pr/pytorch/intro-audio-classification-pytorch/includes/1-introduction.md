Have you ever wondered how the voice assistants we use everyday work? How do they understand the words that we say? 

We can break down the steps all voice assistants likely use:

1. First, the assistant must convert the speech to text.
1. The text is run through a natural language processing (NLP) step, which turns the words into numeric data. We covered that earlier in the PyTorch learning path.
1. Finally, there's a classification of the _utterance_ - what people say to the _intent_ - what they want the voice assistant to do.

In this module, we want to look at how we get the text from the spoken audio. Of course, audio classification is useful for many things, not just speech assistants. For example, in music, you can classify genres or detect illness by the tone in someone's voice, and even more applications that we haven't even thought of yet.

We will be learning how to do audio classification with [PyTorch](https://pytorch.org/), a popular Python machine learning framework. There are multiple ways to build an audio classification model. You can use the waveform, tag sections of a wave file, or even use computer vision on the spectrogram image. This module will first break down how to understand audio data, from analog to digital representations; then, we will build the model using computer vision on the spectrogram images. 

That's right! You can turn audio into an image representation and then use computer vision to classify the word spoken! 

We will be building a simple model that can understand `yes` and `no`. The dataset we will be using is the open dataset [Speech Commands](https://pytorch.org/audio/stable/datasets.html#speechcommands) which is built into PyTorch [datasets](https://pytorch.org/audio/stable/datasets.html). This dataset has 36 total different words/sounds to be used for classification. Each utterance is stored as a one-second (or less) WAVE format file. We will only be using `yes` and `no` for binary classification.

## Learning objectives

In this module you will:

- Learn the basics of audio data
- Learn how to visualize and transform audio data
- Build a binary classification speech model that can recognize "yes" and "no"

## Prerequisites

- Basic Python knowledge
- Basic knowledge about how to use Jupyter Notebooks
- Basic understanding of machine learning
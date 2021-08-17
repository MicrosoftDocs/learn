Ever wonder how the voice assistants actually work? How do they understand the words that we say? When you think about voice assistants you have the first step which is speech to text, then the nlp step which is the word embedding (turning words into numbers), then you have a classification of the utterance (what people say) to the intent (what they want the voice assistant to do). If you are following this learning path, you will have learned how the NLP part works already. Now we want to look at how we get the text from the spoken audio. Of course audio classification can be used for many things, not just speech assistants. For example, in music you can classify genres, or detect illness by the tone in someones voice, and even more applications that we haven't even thought of yet.

In this learn module we will be learning how to do audio classification with TensorFlow. There are multiple ways to build an audio classification model. You can use the waveform, tag sections of a wave file, or even use computer vision on the spectrogram image. In this tutorial we will first break down how to understand audio data, from analog to digital representations, then we will build the model using computer vision on the spectrogram images. That's right, you can turn audio into an image representation and then use computer vision to classify the word spoken! We will be building a simple model that can understand `yes` and `no`. The dataset we will be using is the open dataset [Speech Commands]() which is built into Tensorflow [datasets](). This dataset has 36 total different words/sounds to be used for classification. Each utterance is stored as a one-second (or less) WAVE format file. We will only be using `yes` and `no` for a binary classification.

## Learning objectives
- Understand some key features of audio data.
- Introduction to how to build audio machine learning models.
- Learn how to build a binary classification model from wave files.

## Prerequisites
- Knowledge of Python
- Basic understand of machine learning
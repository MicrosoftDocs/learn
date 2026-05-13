Ever wonder how voice assistants recognize short commands such as "yes," "no," or "stop"? Full speech assistants usually combine many systems, including audio capture, speech recognition, natural language processing, and intent classification. This module focuses on one smaller but important task: keyword classification from short audio clips.

There are multiple ways to build an audio classification model. A model can learn directly from waveforms, from engineered audio features, or from spectrograms that represent frequency content over time. In this module, you use TensorFlow to transform audio waveforms into spectrogram tensors and train a simple convolutional neural network to classify the words `yes` and `no`.

The examples use the smaller mini Speech Commands dataset that TensorFlow provides for tutorials. The original [Speech Commands dataset](https://www.tensorflow.org/datasets/catalog/speech_commands) ([Warden, 2018](https://arxiv.org/abs/1804.03209)) contains more than 105,000 one-second or shorter WAV files across 35 spoken words. The mini Speech Commands dataset contains eight commands, and this module uses only the `yes` and `no` folders for binary classification.

## Learning objectives

- Understand key features of audio data, including sample rate, amplitude, channels, and waveforms.
- Convert audio waveforms into spectrogram tensors.
- Build and evaluate a binary keyword classification model from WAV files.

## Prerequisites

- Basic Python knowledge
- Basic understanding of machine learning
- A Python environment that supports TensorFlow 2.10 or later, with TensorFlow and Matplotlib installed. Use a Python version supported by the TensorFlow release you install. For setup guidance, see [Install TensorFlow with pip](https://www.tensorflow.org/install/pip) and [Install Matplotlib](https://matplotlib.org/stable/users/installing/index.html).

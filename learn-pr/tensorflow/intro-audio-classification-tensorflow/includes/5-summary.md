Congratulations on learning how to build a binary audio classification model.

You learned how analog sound is represented as digital samples, how waveforms show amplitude over time, and how spectrograms show frequency content over time. You also saw how to load the `yes` and `no` classes from the Speech Commands dataset, convert waveforms into spectrogram tensors, train a convolutional neural network, and evaluate the model on held-out data.

## Next steps

To go deeper, try these ideas:

- Extend the model to classify all eight commands in the mini Speech Commands dataset by loading `SOURCE_DATASET_PATH` instead of the binary `BINARY_DATASET_PATH`. The `label_names` array and `num_labels` value update automatically from the directory names.
- Use the full [Speech Commands dataset](https://www.tensorflow.org/datasets/catalog/speech_commands) and the `train`, `validation`, and `test` splits provided by TensorFlow Datasets for a more rigorous evaluation. TensorFlow Datasets exposes the standard keyword-spotting label set, including target commands plus `_unknown_` and `_silence_`, so update the output layer and label handling for that label set.
- Try [transfer learning for audio recognition](https://www.tensorflow.org/tutorials/audio/transfer_learning_audio) with a pretrained YAMNet model.

## Related learning

- [TensorFlow fundamentals](/training/paths/tensorflow-fundamentals/) learning path
- [Introduction to TensorFlow using Keras](/training/modules/intro-machine-learning-keras/)
- [Introduction to computer vision with TensorFlow](/training/modules/intro-computer-vision-tensorflow/)
- [Go beyond Keras: Customize with TensorFlow](/training/modules/intro-machine-learning-tensorflow/)

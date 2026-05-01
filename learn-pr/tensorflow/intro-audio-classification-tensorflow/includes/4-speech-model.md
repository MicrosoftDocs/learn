Now that the waveforms have been converted to spectrogram tensors, you can train a convolutional neural network (CNN). CNNs work well for spectrogram classification because a spectrogram is a two-dimensional representation with local patterns across time and frequency.

The code in this unit uses the following objects created in the previous unit:

- `train_spectrogram_ds`
- `val_spectrogram_ds`
- `test_spectrogram_ds`
- `label_names`
- `get_spectrogram`
- `BINARY_DATASET_PATH`

If you run the code outside the full module flow, run the setup and preprocessing code from the previous unit first.

## Inspect the model input

Before creating the model, inspect one batch to get the spectrogram input shape and the number of labels.

```python
import pathlib

import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras import layers
from tensorflow.keras import models

for example_spectrograms, example_labels in train_spectrogram_ds.take(1):
    input_shape = example_spectrograms.shape[1:]
    break

num_labels = len(label_names)

print("Input shape:", input_shape)
print("Number of labels:", num_labels)
print("Labels:", label_names)
```

**Expected output:** The spectrogram input shape should match the shape produced in the previous unit, and the labels should be `no` and `yes`.

```output
Input shape: (124, 129, 1)
Number of labels: 2
Labels: ['no' 'yes']
```

## Create the model

The model starts with a [resizing layer](https://www.tensorflow.org/api_docs/python/tf/keras/layers/Resizing) that downsamples each `(124, 129, 1)` spectrogram to `(32, 32, 1)`. The smaller input keeps training fast at the cost of frequency and time resolution; this trade-off works for the binary task in this module. A [normalization layer](https://www.tensorflow.org/api_docs/python/tf/keras/layers/Normalization) follows. The normalization layer learns the mean and standard deviation of the training spectrograms before training begins by calling `adapt`.

```python
normalization_layer = layers.Normalization()
normalization_layer.adapt(
    data=train_spectrogram_ds.map(lambda spectrogram, label: spectrogram)
)

model = models.Sequential([
    layers.Input(shape=input_shape),
    layers.Resizing(32, 32),
    normalization_layer,
    layers.Conv2D(32, 3, activation="relu"),
    layers.Conv2D(64, 3, activation="relu"),
    layers.MaxPooling2D(),
    layers.Dropout(0.25),
    layers.Flatten(),
    layers.Dense(128, activation="relu"),
    layers.Dropout(0.5),
    layers.Dense(num_labels),
])

model.summary()
```

**Expected output:** The model summary lists the input layer, resizing and normalization layers, two convolutional layers, pooling, dropout, flattening, and dense output layers. The final dense layer has two outputs, one for each class.

## Compile and train the model

Use the [Adam optimizer](https://www.tensorflow.org/api_docs/python/tf/keras/optimizers/Adam) and [sparse categorical cross-entropy](https://www.tensorflow.org/api_docs/python/tf/keras/losses/SparseCategoricalCrossentropy). Although the task has two classes, this model uses two output logits, one for `no` and one for `yes`, rather than one sigmoid output. That design matches the integer labels created with `label_mode="int"` in the previous unit. The model's final `Dense` layer outputs raw logits (no softmax activation), so set `from_logits=True` so the loss applies a numerically stable softmax internally.

```python
model.compile(
    optimizer=tf.keras.optimizers.Adam(),
    loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
    metrics=["accuracy"],
)

history = model.fit(
    train_spectrogram_ds,
    validation_data=val_spectrogram_ds,
    epochs=10,
    callbacks=[
        tf.keras.callbacks.EarlyStopping(
            monitor="val_loss",
            patience=2,
            restore_best_weights=True,
        )
    ],
)
```

**Expected output:** TensorFlow prints one line per epoch with training loss, training accuracy, validation loss, and validation accuracy. Exact values vary by hardware and random initialization, but for this two-class problem the accuracy should improve over the first few epochs and validation accuracy should become much better than random guessing.

## Plot training history

Plot the loss and accuracy curves to check whether the model improves during training.

```python
metrics = history.history

plt.figure(figsize=(12, 4))

plt.subplot(1, 2, 1)
plt.plot(history.epoch, metrics["loss"], label="Training loss")
plt.plot(history.epoch, metrics["val_loss"], label="Validation loss")
plt.xlabel("Epoch")
plt.ylabel("Loss")
plt.legend()

plt.subplot(1, 2, 2)
plt.plot(history.epoch, metrics["accuracy"], label="Training accuracy")
plt.plot(history.epoch, metrics["val_accuracy"], label="Validation accuracy")
plt.xlabel("Epoch")
plt.ylabel("Accuracy")
plt.legend()

plt.show()
```

**Expected output:** The loss plot should generally trend downward. The accuracy plot should generally trend upward. If training accuracy keeps improving while validation accuracy gets worse, the model is overfitting.

## Evaluate on the test set

Use the test set only after training is complete. This gives a better estimate of how the model performs on data it didn't see during training or validation.

```python
test_metrics = model.evaluate(test_spectrogram_ds, return_dict=True)
print(test_metrics)
```

**Expected output:** TensorFlow prints the final test loss and test accuracy. The exact values vary, but the result should be well above the 50 percent accuracy expected from random guessing on a balanced two-class dataset.

You can also inspect a confusion matrix to see which classes the model confuses.

```python
predicted_batches = []
true_batches = []

for spectrograms, labels in test_spectrogram_ds:
    logits = model(spectrograms, training=False)
    predicted_batches.append(tf.argmax(logits, axis=1))
    true_batches.append(labels)

predicted_labels = tf.concat(predicted_batches, axis=0)
true_labels = tf.concat(true_batches, axis=0)

confusion_matrix = tf.math.confusion_matrix(
    true_labels,
    predicted_labels,
    num_classes=num_labels,
)
print(confusion_matrix.numpy())
```

**Expected output:** The output is a 2 x 2 matrix. Most counts should appear on the diagonal when the model is classifying `no` and `yes` correctly.

## Run inference on one audio file

To classify a single WAV file, load it with the same preprocessing used for training: one channel, 16,000 samples, STFT magnitude, and a channel dimension.

```python
def load_waveform(file_path):
    audio_binary = tf.io.read_file(str(file_path))
    waveform, sample_rate = tf.audio.decode_wav(
        audio_binary,
        desired_channels=1,
        desired_samples=16000,
    )
    waveform = tf.squeeze(waveform, axis=-1)
    return waveform, sample_rate


sample_file = next((BINARY_DATASET_PATH / "no").glob("*.wav"))

sample_waveform, sample_rate = load_waveform(sample_file)
sample_spectrogram = get_spectrogram(sample_waveform)

logits = model(sample_spectrogram[tf.newaxis, ...], training=False)
predicted_index = tf.argmax(logits[0]).numpy()
predicted_label = label_names[predicted_index]

print("Sample file:", sample_file)
print("Predicted label:", predicted_label)
```

**Expected output:** The prediction usually matches the folder name for the selected sample file. Because this example selects a file from the `no` folder, the model usually predicts `no`. Predictions can occasionally be wrong, especially before the model has fully converged or for clips that were misclassified during training.

## Optional: test your own voice

You can test the model with your own WAV files. Record short clips of yourself saying "yes" and "no". Keep each clip close to one second and minimize background noise. Export the files as 16 kHz mono 16-bit PCM WAV files so they match the training data and can be decoded by [`tf.audio.decode_wav`](https://www.tensorflow.org/api_docs/python/tf/audio/decode_wav). If your recording tool exports a different sample rate, resample the files to 16 kHz before using this code. The `desired_samples=16000` argument pads or trims samples; it doesn't convert a 44.1 kHz or 48 kHz recording to 16 kHz audio. Update the paths in `custom_files` to match the files you create.

```python
def load_voice_sample(file_path):
    audio_binary = tf.io.read_file(str(file_path))
    waveform, sample_rate = tf.audio.decode_wav(
        audio_binary,
        desired_channels=1,
        desired_samples=16000,
    )

    if int(sample_rate.numpy()) != 16000:
        raise ValueError("Use a 16 kHz WAV file, or resample the audio to 16 kHz before inference.")

    waveform = tf.squeeze(waveform, axis=-1)
    return waveform


custom_files = {
    "no": pathlib.Path("data/myvoice/no.wav"),
    "yes": pathlib.Path("data/myvoice/yes.wav"),
}

missing_files = [file_path for file_path in custom_files.values() if not file_path.exists()]

if missing_files:
    print("Create these WAV files before running the optional custom-voice example:")
    for file_path in missing_files:
        print(file_path)
else:
    for expected_label, file_path in custom_files.items():
        waveform = load_voice_sample(file_path)
        spectrogram = get_spectrogram(waveform)
        logits = model(spectrogram[tf.newaxis, ...], training=False)
        predicted_label = label_names[tf.argmax(logits[0]).numpy()]

        print(f"Expected: {expected_label}; predicted: {predicted_label}")
```

**Expected output:** If the files don't exist yet, the code prints the paths to create. After you create the files, the code prints one prediction for each custom file. Accuracy on your own voice may be lower than test-set accuracy because the model was trained on the Speech Commands recordings, not on your recording environment or microphone.

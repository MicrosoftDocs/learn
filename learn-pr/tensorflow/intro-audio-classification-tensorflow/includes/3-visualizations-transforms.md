After you understand the raw waveform, the next step is to transform the audio into a representation that is useful for classification.

A waveform shows amplitude over time. A **spectrogram** shows frequency content over time. To create a spectrogram, you compute the short-time Fourier transform (STFT) across small overlapping windows of the waveform. TensorFlow provides [`tf.signal.stft`](https://www.tensorflow.org/api_docs/python/tf/signal/stft) for this operation.

In older versions of this workflow, spectrograms were saved as PNG files and then loaded back as images. The updated approach keeps spectrograms as tensors. This avoids extra file I/O, avoids image resizing artifacts, and matches the current TensorFlow audio tutorial pattern.

## Prepare the binary audio dataset

Start with the same mini Speech Commands download from the previous unit. The following code downloads the dataset if it isn't already present, validates the archive hash, locates the extracted folder for both Keras 2 and Keras 3 layouts, and copies only the `no` and `yes` folders into a smaller binary dataset directory.

```python
import pathlib
import shutil

import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf

SOURCE_DATASET_PATH = pathlib.Path("data/mini_speech_commands")
ALT_SOURCE_DATASET_PATH = pathlib.Path("data/mini_speech_commands_extracted/mini_speech_commands")
BINARY_DATASET_PATH = pathlib.Path("data/speech_commands_yes_no")
MINI_SPEECH_COMMANDS_SHA256 = "49650f2341b26d886b46b3f4fb8fed59e30300b17550f1ee4a768b3106cf93a0"

if not SOURCE_DATASET_PATH.exists() and not ALT_SOURCE_DATASET_PATH.exists():
    tf.keras.utils.get_file(
        "mini_speech_commands.zip",
        origin="https://storage.googleapis.com/download.tensorflow.org/data/mini_speech_commands.zip",
        file_hash=MINI_SPEECH_COMMANDS_SHA256,
        hash_algorithm="sha256",
        extract=True,
        cache_dir=".",
        cache_subdir="data",
    )

if ALT_SOURCE_DATASET_PATH.exists():
    SOURCE_DATASET_PATH = ALT_SOURCE_DATASET_PATH

for label in ("no", "yes"):
    target_dir = BINARY_DATASET_PATH / label
    target_dir.mkdir(parents=True, exist_ok=True)

    for source_file in (SOURCE_DATASET_PATH / label).glob("*.wav"):
        target_file = target_dir / source_file.name
        if not target_file.exists():
            shutil.copy2(source_file, target_file)
```

**Expected output:** This setup code doesn't print output. It creates a `data/speech_commands_yes_no` directory with one subdirectory for `no` and one for `yes`. TensorFlow 2.16 and later use Keras 3, which extracts the archive into a `<archive>_extracted` subdirectory; the helper handles both layouts so the rest of the unit works on any supported TensorFlow version.

## Load audio files as TensorFlow datasets

Use [`tf.keras.utils.audio_dataset_from_directory`](https://www.tensorflow.org/api_docs/python/tf/keras/utils/audio_dataset_from_directory) to create TensorFlow datasets from the directory structure. The mini Speech Commands files are sampled at 16 kHz, so `output_sequence_length=16000` selects a fixed window of 16,000 samples per clip, which is exactly one second of audio at that sample rate. Files shorter than 16,000 samples are padded with zeros, and files longer than 16,000 samples are truncated. The `output_sequence_length` argument doesn't resample audio recorded at a different sample rate; resampling means changing how many samples represent each second of sound. If you adapt this workflow to files recorded at another sample rate, resample them to 16 kHz before loading, or use the loader's `sampling_rate` option with [`tensorflow-io`](https://www.tensorflow.org/io) and verify that the resulting tensor shapes still match the model input.

The code sets `label_mode="int"` explicitly because the model uses integer class labels with sparse categorical cross-entropy in the next unit. The class names are inferred from the folder names in alphanumeric order.

```python
SEED = 42
BATCH_SIZE = 64

tf.random.set_seed(SEED)
np.random.seed(SEED)

train_ds, validation_ds = tf.keras.utils.audio_dataset_from_directory(
    directory=BINARY_DATASET_PATH,
    label_mode="int",
    batch_size=BATCH_SIZE,
    validation_split=0.2,
    subset="both",
    seed=SEED,
    output_sequence_length=16000,
)

label_names = np.array(train_ds.class_names)
print("Label names:", label_names)
```

**Expected output:** The loader finds about 2,000 WAV files across the `no` and `yes` classes. With a 20 percent validation split, about 1,600 examples are used for training and about 400 for validation.

```output
Found 2000 files belonging to 2 classes.
Using 1600 files for training.
Using 400 files for validation.
Label names: ['no' 'yes']
```

Keep a test set separate from the validation set. The loader doesn't create a separate test split, so the following code unbatches the holdout data and splits the individual clips into a validation shard and a test shard. Unbatch before sharding so the split happens at the clip level rather than the batch level. Cache the holdout data so the validation and test shards don't repeatedly decode the same WAV files.

```python
holdout_ds = validation_ds.unbatch().cache()
val_ds = holdout_ds.shard(num_shards=2, index=0).batch(BATCH_SIZE)
test_ds = holdout_ds.shard(num_shards=2, index=1).batch(BATCH_SIZE)
```

**Expected output:** This code doesn't print output. The model uses `train_ds` for training, `val_ds` for tuning during training, and `test_ds` for final evaluation.

> [!NOTE]
> [`Dataset.shard`](https://www.tensorflow.org/api_docs/python/tf/data/Dataset#shard) selects elements from the dataset. Because this code calls `unbatch()` before `shard()`, the shard elements are individual audio clips rather than whole batches. With about 400 holdout clips, `val_ds` and `test_ds` each contain about 200 clips after batching.

> [!NOTE]
> This module follows a compact split pattern that's adapted from the TensorFlow tutorial so the example stays small. For rigorous evaluation with the full Speech Commands dataset, use the [`train`, `validation`, and `test` splits provided by TensorFlow Datasets](https://www.tensorflow.org/datasets/catalog/speech_commands), or split by speaker ID, so clips from the same speaker don't appear in both training and evaluation data.

The dataset returns audio tensors with a channel dimension. Because these files are mono, remove the extra channel dimension before creating spectrograms.

```python
def squeeze(audio, labels):
    audio = tf.squeeze(audio, axis=-1)
    return audio, labels


train_ds = train_ds.map(squeeze, num_parallel_calls=tf.data.AUTOTUNE)
val_ds = val_ds.map(squeeze, num_parallel_calls=tf.data.AUTOTUNE)
test_ds = test_ds.map(squeeze, num_parallel_calls=tf.data.AUTOTUNE)

for example_audio, example_labels in train_ds.take(1):
    print("Audio batch shape:", example_audio.shape)
    print("Label batch shape:", example_labels.shape)
```

**Expected output:** Each audio batch contains up to 64 one-second waveforms.

```output
Audio batch shape: (64, 16000)
Label batch shape: (64,)
```

## Visualize a waveform

The following code plots one waveform from a training batch.

```python
example_waveform = example_audio[0]
example_label = label_names[example_labels[0].numpy()]

plt.figure(figsize=(12, 4))
plt.plot(example_waveform.numpy())
plt.title(f"Waveform for '{example_label}'")
plt.xlabel("Sample")
plt.ylabel("Amplitude")
plt.xlim([0, 16000])
plt.show()
```

**Expected output:** The plot shows amplitude over 16,000 samples for one `no` or `yes` audio clip.

## Create spectrograms

The STFT converts the waveform from the time domain into a time-frequency representation. The model uses only the magnitude of the STFT values, so the code applies `tf.abs` to the complex STFT result. The final line adds a channel dimension so convolutional layers can process the spectrogram as image-like input.

```python
def get_spectrogram(waveform):
    spectrogram = tf.signal.stft(
        waveform,
        frame_length=255,
        frame_step=128,
    )
    spectrogram = tf.abs(spectrogram)
    spectrogram = spectrogram[..., tf.newaxis]
    return spectrogram


example_spectrogram = get_spectrogram(example_waveform)
print("Spectrogram shape:", example_spectrogram.shape)
```

**Expected output:** With one second of audio (16,000 samples), a frame length of 255, and a frame step of 128, the spectrogram shape is `(124, 129, 1)`. The first dimension is the number of time frames: `floor((16000 - 255) / 128) + 1 = 124`. This formula applies because [`tf.signal.stft`](https://www.tensorflow.org/api_docs/python/tf/signal/stft) leaves `pad_end` set to `False` by default, so it doesn't add an extra partial frame at the end. The second dimension is the number of frequency bins: `tf.signal.stft` zero-pads each frame to the next power of two for the FFT (256 in this case), then returns `fft_length / 2 + 1 = 129` non-redundant bins. The final dimension is the channel axis added for the convolutional model.

```output
Spectrogram shape: (124, 129, 1)
```

## Visualize a spectrogram

Use a logarithmic scale for display so quieter frequency components are easier to see. Add a small epsilon before calling `np.log` so zero values don't become negative infinity.

```python
def plot_spectrogram(spectrogram, ax):
    if len(spectrogram.shape) > 2:
        spectrogram = np.squeeze(spectrogram, axis=-1)

    log_spec = np.log(spectrogram.T + np.finfo(float).eps)
    height = log_spec.shape[0]
    width = log_spec.shape[1]
    time_steps = np.arange(width)
    frequency_bins = np.arange(height)
    ax.pcolormesh(time_steps, frequency_bins, log_spec)
    ax.set_xlabel("Time frame")
    ax.set_ylabel("Frequency bin")


fig, axes = plt.subplots(2, figsize=(12, 8))

axes[0].plot(example_waveform.numpy())
axes[0].set_title("Waveform")
axes[0].set_xlim([0, 16000])

plot_spectrogram(example_spectrogram.numpy(), axes[1])
axes[1].set_title("Spectrogram")

plt.suptitle(example_label.title())
plt.show()
```

**Expected output:** The first chart shows the waveform. The second chart shows the spectrogram, with time frames on the horizontal axis, frequency bins on the vertical axis, and color intensity representing magnitude.

## Create spectrogram datasets

Map the waveform datasets into spectrogram datasets. Cache and prefetch the datasets to reduce input pipeline latency while training.

```python
def make_spectrogram_dataset(dataset):
    return dataset.map(
        map_func=lambda audio, label: (get_spectrogram(audio), label),
        num_parallel_calls=tf.data.AUTOTUNE,
    )


train_spectrogram_ds = make_spectrogram_dataset(train_ds)
val_spectrogram_ds = make_spectrogram_dataset(val_ds)
test_spectrogram_ds = make_spectrogram_dataset(test_ds)

train_spectrogram_ds = train_spectrogram_ds.cache().shuffle(1000, seed=SEED).prefetch(tf.data.AUTOTUNE)
val_spectrogram_ds = val_spectrogram_ds.cache().prefetch(tf.data.AUTOTUNE)
test_spectrogram_ds = test_spectrogram_ds.cache().prefetch(tf.data.AUTOTUNE)

for spectrograms, labels in train_spectrogram_ds.take(1):
    print("Spectrogram batch shape:", spectrograms.shape)
    print("Label batch shape:", labels.shape)
```

**Expected output:** The model-ready dataset contains batches of spectrogram tensors and integer labels.

```output
Spectrogram batch shape: (64, 124, 129, 1)
Label batch shape: (64,)
```

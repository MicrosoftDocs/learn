Before you build an audio classification model, you need to understand how audio becomes data that TensorFlow can process.

Sound begins as a continuous analog signal. A microphone captures that signal and converts it into a sequence of numbers by sampling the signal at regular time intervals. The number of samples captured per second is the **sample rate**. For example, a 16 kHz audio file contains 16,000 samples per second.

Each sample stores the **amplitude** of the signal at a moment in time. Plotting amplitude across the samples gives you a **waveform**. Audio can also have one or more **channels**. A mono file has one channel; a stereo file has two channels, usually left and right.

For longer audio, you often split the signal into smaller **frames** and classify each frame independently. The Speech Commands examples used in this module are already one second or shorter, so the model can classify each whole file as a single command.

> [!NOTE]
> The code in this module uses TensorFlow 2.10 or later. The audio data loader [`tf.keras.utils.audio_dataset_from_directory`](https://www.tensorflow.org/api_docs/python/tf/keras/utils/audio_dataset_from_directory) used in the next unit was introduced in TensorFlow 2.10. Use a Python version supported by the TensorFlow release you install, verify that `import tensorflow as tf` works, and install Matplotlib for the visualization examples. For setup guidance, see [Install TensorFlow with pip](https://www.tensorflow.org/install/pip) and [Install Matplotlib](https://matplotlib.org/stable/users/installing/index.html).

## Import the packages

The following code imports the packages used to inspect the audio data.

```python
import pathlib

import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
```

**Expected output:** The imports don't display output when they succeed.

## Get the Speech Commands data

The [Speech Commands dataset](https://www.tensorflow.org/datasets/catalog/speech_commands) contains short WAV files of spoken commands. To keep the example small, use the [mini Speech Commands dataset](https://www.tensorflow.org/tutorials/audio/simple_audio) that TensorFlow provides for tutorials. It contains eight command folders: `down`, `go`, `left`, `no`, `right`, `stop`, `up`, and `yes`.

The following code downloads the dataset on the first run, validates the archive with a SHA-256 hash by using [`tf.keras.utils.get_file`](https://www.tensorflow.org/api_docs/python/tf/keras/utils/get_file), and locates the extracted folder. TensorFlow 2.16 and later use Keras 3, which extracts archives into a `<archive>_extracted` subdirectory. Earlier versions extract straight into the cache directory. The helper checks both layouts so the rest of the unit works on any supported TensorFlow version.

```python
DATASET_PATH = pathlib.Path("data/mini_speech_commands")
ALT_DATASET_PATH = pathlib.Path("data/mini_speech_commands_extracted/mini_speech_commands")
MINI_SPEECH_COMMANDS_SHA256 = "49650f2341b26d886b46b3f4fb8fed59e30300b17550f1ee4a768b3106cf93a0"

if not DATASET_PATH.exists() and not ALT_DATASET_PATH.exists():
    tf.keras.utils.get_file(
        "mini_speech_commands.zip",
        origin="https://storage.googleapis.com/download.tensorflow.org/data/mini_speech_commands.zip",
        file_hash=MINI_SPEECH_COMMANDS_SHA256,
        hash_algorithm="sha256",
        extract=True,
        cache_dir=".",
        cache_subdir="data",
    )

if ALT_DATASET_PATH.exists():
    DATASET_PATH = ALT_DATASET_PATH

commands = sorted(item.name for item in DATASET_PATH.iterdir() if item.is_dir())
print("Commands:", commands)
```

**Expected output:** TensorFlow downloads and extracts the dataset the first time the code runs. After extraction, the command list should contain eight labels similar to this output:

```output
Commands: ['down', 'go', 'left', 'no', 'right', 'stop', 'up', 'yes']
```

This module uses only the `yes` and `no` classes.

```python
yes_files = sorted((DATASET_PATH / "yes").glob("*.wav"))
no_files = sorted((DATASET_PATH / "no").glob("*.wav"))

print(f"Yes examples: {len(yes_files)}")
print(f"No examples: {len(no_files)}")
```

**Expected output:** The mini dataset includes 1,000 WAV files for each of the eight commands, so the `yes` and `no` counts are typically 1,000 each.

## Convert a WAV file to a tensor

The Speech Commands files are 16-bit PCM WAV files. TensorFlow can read the file bytes with [`tf.io.read_file`](https://www.tensorflow.org/api_docs/python/tf/io/read_file) and decode 16-bit PCM WAV data with [`tf.audio.decode_wav`](https://www.tensorflow.org/api_docs/python/tf/audio/decode_wav). Other WAV encodings can fail to decode, so convert custom audio to 16-bit PCM WAV before using the same loader.

The Speech Commands files are mono and sampled at 16 kHz. The `desired_channels=1` argument requests one output channel. For multichannel WAV files, [`tf.audio.decode_wav`](https://www.tensorflow.org/api_docs/python/tf/audio/decode_wav) keeps the first channel and ignores the rest instead of mixing them; for files with fewer channels than requested, it duplicates the last channel to reach the requested count. The `desired_samples=16000` argument pads shorter clips with zeros or trims longer clips.

Because these files are sampled at 16 kHz, 16,000 samples is exactly one second. For audio at a different sample rate, 16,000 samples represents a different duration. `desired_samples` doesn't resample audio that was recorded at a different sample rate. To resample, decode the file and then use a tool such as [`tensorflow_io.audio.resample`](https://www.tensorflow.org/io/api_docs/python/tfio/audio/resample), or resample the file with another audio toolchain before using this workflow.

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


example_file = yes_files[0]
waveform, sample_rate = load_waveform(example_file)

print("Waveform shape:", waveform.shape)
print("Sample rate:", sample_rate.numpy())
print("Value range:", float(tf.reduce_min(waveform)), "to", float(tf.reduce_max(waveform)))
```

**Expected output:** The waveform is a one-dimensional tensor with 16,000 samples. [`tf.audio.decode_wav`](https://www.tensorflow.org/api_docs/python/tf/audio/decode_wav) returns `float32` values normalized to the theoretical range `[-1.0, 1.0]`. The actual minimum and maximum for any one clip are usually well inside that range. Your output will look similar to the following, with file-specific min and max values:

```output
Waveform shape: (16000,)
Sample rate: 16000
Value range: -0.42306518 to 0.5128479
```

## Plot the waveform

Plotting the waveform shows the amplitude of the audio signal over time.

```python
timescale = np.arange(waveform.shape[0])

plt.figure(figsize=(12, 4))
plt.plot(timescale, waveform.numpy())
plt.title("Waveform for a 'yes' example")
plt.xlabel("Sample")
plt.ylabel("Amplitude")
plt.xlim([0, 16000])
plt.show()
```

**Expected output:** The plot shows a line that moves above and below zero as the speaker says "yes." If you open the selected WAV file in an audio player, you should hear a short clip of someone saying "yes."

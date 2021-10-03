using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CognitiveServices.Speech;
using Microsoft.CognitiveServices.Speech.Audio;

namespace speech_to_text
{
    class Program
    {
        static async Task Main(string[] args)
        {
            string azureKey = "ENTER YOUR KEY FROM THE FIRST EXERCISE";
            string azureLocation = "ENTER YOUR LOCATION FROM THE FIRST EXERCISE";
            string textFile = "Shakespeare.txt";
            string waveFile = "Shakespeare.wav";

            try
            {
                FileInfo fileInfo = new FileInfo(waveFile);
                if (fileInfo.Exists)
                {
                    var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
                    using var audioConfig = AudioConfig.FromWavFileInput(fileInfo.FullName);
                    using var speechRecognizer = new SpeechRecognizer(speechConfig, audioConfig);
                    var stopRecognition = new TaskCompletionSource<int>();

                    FileStream fileStream = File.OpenWrite(Path.Combine(fileInfo.DirectoryName, textFile));
                    StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);

                    var phraseList = PhraseListGrammar.FromRecognizer(speechRecognizer);
                    phraseList.AddPhrase("thou seest");

                    speechRecognizer.Recognized += (s, e) =>
                    {
                        switch(e.Result.Reason)
                        {
                            case ResultReason.RecognizedSpeech:
                                streamWriter.WriteLine(e.Result.Text);
                                break;
                            case ResultReason.NoMatch:
                                Console.WriteLine("Speech could not be recognized.");
                                break;
                        }
                    };

                    speechRecognizer.Canceled += (s, e) =>
                    {
                        if (e.Reason != CancellationReason.EndOfStream)
                        {
                            Console.WriteLine("Speech recognition canceled.");
                        }
                        stopRecognition.TrySetResult(0);
                        streamWriter.Close();
                    };

                    speechRecognizer.SessionStopped += (s, e) =>
                    {
                        Console.WriteLine("Speech recognition stopped.");
                        stopRecognition.TrySetResult(0);
                        streamWriter.Close();
                    };

                    Console.WriteLine("Speech recognition started.");
                    await speechRecognizer.StartContinuousRecognitionAsync();
                    Task.WaitAny(new[] { stopRecognition.Task });
                    await speechRecognizer.StopContinuousRecognitionAsync();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
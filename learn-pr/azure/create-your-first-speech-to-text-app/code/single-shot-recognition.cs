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
                    var result = await speechRecognizer.RecognizeOnceAsync();

                    FileStream fileStream = File.OpenWrite(Path.Combine(fileInfo.DirectoryName, textFile));
                    StreamWriter streamWriter = new StreamWriter(fileStream, Encoding.UTF8);
                    streamWriter.WriteLine(result.Text);
                    streamWriter.Close();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
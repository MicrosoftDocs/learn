using System;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Microsoft.CognitiveServices.Speech;
using Microsoft.CognitiveServices.Speech.Audio;

namespace text_to_speech
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
                FileInfo fileInfo = new FileInfo(textFile);
                if (fileInfo.Exists)
                {
                    string textContent = File.ReadAllText(fileInfo.FullName);
                    var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
                    using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
                    var speechResult = await speechSynthesizer.SpeakTextAsync(textContent);
                    using var audioDataStream = AudioDataStream.FromResult(speechResult);
                    await audioDataStream.SaveToWaveFileAsync(waveFile);       
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
             
            }
        }
    }
}

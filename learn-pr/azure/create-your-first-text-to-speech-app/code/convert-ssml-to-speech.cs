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
            string ssmlFile = "Shakespeare.xml";
            string waveFile = "Shakespeare.wav";
            try
            {
                FileInfo fileInfo = new FileInfo(ssmlFile);
                if (fileInfo.Exists)
                {
                    string ssmlContent = File.ReadAllText(fileInfo.FullName);
                    var speechConfig = SpeechConfig.FromSubscription(azureKey, azureLocation);
                    using var speechSynthesizer = new SpeechSynthesizer(speechConfig, null);
                    var speechResult = await speechSynthesizer.SpeakSsmlAsync(ssmlContent);
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

using RandomNameGeneratorLibrary;
using System;
using System.Security.Cryptography;

namespace CensusData.Models
{
    [Serializable]
    public class Main
    {
        public int Temperature { get; set; } = new Random().Next(10,35);
        public int Humidity { get; set; } = new Random().Next(10, 100);      

    }
}

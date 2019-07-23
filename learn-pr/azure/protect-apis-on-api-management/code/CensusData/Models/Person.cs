using RandomNameGeneratorLibrary;
using System;
using System.Security.Cryptography;

namespace CensusData.Models
{
    [Serializable]
    public class Person
    {
        public int ID { get; set; } = new Random().Next(1000);
        public string Name { get; set; }
        public string Occupation { get; set; }
        public int Age { get; set; }
        public string Href { get; set; }

    }
}

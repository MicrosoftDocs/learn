using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace CensusData.Services
{
    public class OccupationGeneratorService : IOccupationGeneratorService
    {

        private string[] occupations = File.ReadAllText("Occupations.txt").Split(Environment.NewLine, StringSplitOptions.RemoveEmptyEntries);

        public string GetRandomOccupation()
        {
            int randomIndex = new Random().Next(occupations.Length - 1);
            return occupations[randomIndex];
        }

        public string[] GetAllOccupations()
        {
            return occupations;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CensusData.Models
{
    [Serializable]
    public class Census
    {
        private Person[] data;
        private int year;
        public Census()
        {
            data = new Person[100];

            // Return dummy data
            for (int i = 0; i < 100; i++)
            {
                data[i] = new Person();
            }
        }        

        public int Year { get => year; set => year = value; }
        public Person[] People { get => data; set => data = value; }
    }
}

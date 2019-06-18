using System;

namespace CensusData.Models
{
    public class Wind
    {
        public int Speed { get; set; } = new Random().Next(0, 20);

        public double Direction  {  get; set;  } = new Random().Next(0, 360);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CensusData.Models
{
    [Serializable]
    public class WeatherEntry
    {
        private Main mainOutlook;
        private Wind wind;
        private DateTime date;
        private double latitude;
        private double longitude;
        public WeatherEntry(DateTime date, double latitude, double longitude)
        {
            this.date = date;
            this.latitude = latitude;
            this.longitude = longitude;
            this.mainOutlook = new Main();
            this.wind = new Wind();
        }

        public Main MainOutlook { get => mainOutlook; set => mainOutlook = value; }
        public Wind Wind { get => wind; set => wind = value; }
        public DateTime Date { get => date; set => date = value; }
        public double Latitude { get => latitude; set => latitude = value; }
        public double Longitude { get => longitude; set => longitude = value; }
    }
}

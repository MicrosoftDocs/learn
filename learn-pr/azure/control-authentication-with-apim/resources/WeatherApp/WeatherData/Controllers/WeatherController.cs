using CensusData.Models;
using Microsoft.AspNetCore.Mvc;
using RandomNameGeneratorLibrary;
using System;

namespace CensusData.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class WeatherController : ControllerBase
    {
        public WeatherController()
        {
        }

        [HttpGet("{latitude}/{longitude}", Name = "GetTodaysWeather")]
        public WeatherEntry Get(double latitude, double longitude)
        {
            return new WeatherEntry(DateTime.Today, latitude, longitude) { };
        }

        [HttpGet("{date}/{latitude}/{longitude}", Name = "GetSpecificDaysWeather")]
        public WeatherEntry Get(DateTime date, double latitude, double longitude)
        {
            return new WeatherEntry(date, latitude, longitude) { };
        }
    }
}

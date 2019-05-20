using CensusData.Models;
using CensusData.Services;
using Microsoft.AspNetCore.Mvc;
using RandomNameGeneratorLibrary;

namespace CensusData.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CensusController : ControllerBase
    {
        int numberOfPeopleInCensus = 100;
        int defaultYear = 2011;
        IPersonBuilderService builderService;

        public CensusController()
        {
            builderService = new PersonBuilderService(new OccupationGeneratorService(), new PersonNameGenerator());
        }

        [HttpGet(Name = "GetLatestCensus")]
        public Census Get()
        {
            return new Census() { People = builderService.Build(numberOfPeopleInCensus, this.Request.Scheme + "://" + Request.Host.ToString()), Year = defaultYear };
        }

        [HttpGet("{censusYear}", Name = "GetCensusDetails")]
        public Census Get(int censusYear)
        {
            return new Census() { People = builderService.Build(numberOfPeopleInCensus, this.Request.Scheme + "://" + Request.Host.ToString()), Year = censusYear };
        }
    }
}

using CensusData.Models;
using CensusData.Services;
using Microsoft.AspNetCore.Mvc;
using RandomNameGeneratorLibrary;

namespace CensusData.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PeopleController : ControllerBase
    {
        IPersonBuilderService builderService;
        public PeopleController()
        {
            builderService = new PersonBuilderService(new OccupationGeneratorService(), new PersonNameGenerator());
        }

        [HttpGet("{reference}", Name = "GetPersonDetails")]
        public PersonDetail Get(int reference)
        {

            return builderService.BuildDetailedPerson(reference, this.Request.Scheme + "://" + Request.Host.ToString());
        }
    }
}

using CensusData.Models;

namespace CensusData.Services
{
    public interface IPersonBuilderService
    {
        Person[] Build(int count, string domain);
        PersonDetail BuildDetailedPerson(int reference, string domain);
    }
}
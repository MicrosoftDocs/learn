namespace CensusData.Services
{
    public interface IOccupationGeneratorService
    {
        string GetRandomOccupation();
        string[] GetAllOccupations();
    }       
}
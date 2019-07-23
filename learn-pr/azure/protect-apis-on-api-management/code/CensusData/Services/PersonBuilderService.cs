using CensusData.Models;
using RandomNameGeneratorLibrary;
using System;

namespace CensusData.Services
{
    public class PersonBuilderService : IPersonBuilderService
    {
        private IOccupationGeneratorService occupationGeneratorService;
        private IPersonNameGenerator personNameGenerator;
        private string[] maritalStatusOptions;

        public PersonBuilderService(IOccupationGeneratorService occupationGeneratorService, IPersonNameGenerator personNameGenerator)
        {
            this.occupationGeneratorService = occupationGeneratorService;
            this.personNameGenerator = personNameGenerator;
            maritalStatusOptions = new string[] { "Married", "Widowed", "Separated", "Divorced", "Single" };         
        }

        public Person[] Build(int count, string domain)
        {
            Person[] people = new Person[count];

            for (int i = 0; i < count; i++)
            {
                people[i] = new Person()
                {
                    Age = new Random().Next(18, 100),
                    Name = personNameGenerator.GenerateRandomFirstAndLastName(),
                    Occupation = occupationGeneratorService.GetRandomOccupation()
                };

                people[i].Href = domain + "/api/people/" + people[i].ID;
            }

            return people;
        }

        public PersonDetail BuildDetailedPerson(int reference, string domain)
        {
            PersonDetail person = new PersonDetail()
            {
                ID = reference,
                Age = new Random().Next(18, 100),
                Name = personNameGenerator.GenerateRandomFirstAndLastName(),
                Occupation = occupationGeneratorService.GetRandomOccupation(),
                WeeklyHoursWorked = new Random().Next(10, 60),
                MaritalStatus = GetRandomMaritalStatus()
            };

            person.Href = domain + "/api/people/" + person.ID;

            return person;
        }

        private string GetRandomMaritalStatus()
        {
            return maritalStatusOptions[new Random().Next(4)];
        }

    }
}

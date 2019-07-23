using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CensusData.Models
{
    public class PersonDetail : Person
    {
        public int WeeklyHoursWorked
        {
            get;
            set;
        }

        public string MaritalStatus
        {
            get;set;
        }
    }
}

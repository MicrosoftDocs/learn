using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace CoursesWebApp.Models
{
    public class DataAccessController
    {
        // TODO: Add your connection string in the following statements
        private string connectionString = "<Azure SQL Database Connection String>";

        // Retrieve all details of courses and their modules    
        public IEnumerable<CoursesAndModules> GetAllCoursesAndModules()
        {
            List<CoursesAndModules> courseList = new List<CoursesAndModules>();

            // TODO: Connect to the database
            //using ()
            {
                // TODO: Specify the SQL query to run
                
                // TODO: Execute the query
                
                // TODO: Read the data a row at a time
                
                // TODO: Close the database connection
            }
            return courseList;
        }
    }
}

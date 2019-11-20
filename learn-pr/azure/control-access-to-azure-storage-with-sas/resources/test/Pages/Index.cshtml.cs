using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Collections.Generic;

namespace test.Pages
{
    public class IndexModel : PageModel
    {
        public List<PatientRecord> Patients { get; set; }

        public void OnGet()
        {

        }
    }
}

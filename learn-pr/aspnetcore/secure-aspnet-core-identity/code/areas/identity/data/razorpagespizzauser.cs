using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;

namespace RazorPagesPizza.Areas.Identity.Data;

public class RazorPagesPizzaUser : IdentityUser
{
    [Required]
    [MaxLength(100)]
    public string FirstName { get; set; } = string.Empty;

    [Required]
    [MaxLength(100)]
    public string LastName { get; set; } = string.Empty;
}
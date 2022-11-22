// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.
#nullable disable

using System;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.WebUtilities;
using RazorPagesPizza.Areas.Identity.Data;
using System.Security.Claims;

namespace RazorPagesPizza.Areas.Identity.Pages.Account
{

#region snippet_ConfigProperty
public class ConfirmEmailModel : PageModel
{
    private readonly UserManager<RazorPagesPizzaUser> _userManager;
    private readonly IConfiguration Configuration;

    public ConfirmEmailModel(UserManager<RazorPagesPizzaUser> userManager,
                                IConfiguration configuration)
    {
        _userManager = userManager;
        Configuration = configuration;
    }

#endregion

/// <summary>
///     This API supports the ASP.NET Core Identity default UI infrastructure and is not intended to be used
///     directly from your code. This API may change or be removed in future releases.
/// </summary>
[TempData]
public string StatusMessage { get; set; }
#region snippet_OnGetAsync
public async Task<IActionResult> OnGetAsync(string userId, string code)
{
    if (userId == null || code == null)
    {
        return RedirectToPage("/Index");
    }

    var user = await _userManager.FindByIdAsync(userId);
    if (user == null)
    {
        return NotFound($"Unable to load user with ID '{userId}'.");
    }

    code = Encoding.UTF8.GetString(WebEncoders.Base64UrlDecode(code));
    var result = await _userManager.ConfirmEmailAsync(user, code);
    StatusMessage = result.Succeeded ? "Thank you for confirming your email." : "Error confirming your email.";

    var adminEmail = Configuration["AdminEmail"] ?? string.Empty;
    if(result.Succeeded)
    {
        var isAdmin = string.Compare(user.Email, adminEmail, true) == 0 ? true : false;
        await _userManager.AddClaimAsync(user, 
            new Claim("IsAdmin", isAdmin.ToString()));
    }

    return Page();
}
#endregion
}
}

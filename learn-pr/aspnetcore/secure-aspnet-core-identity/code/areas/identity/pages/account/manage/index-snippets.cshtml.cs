#region snippet_LoadAsync
private async Task LoadAsync(RazorPagesPizzaUser user)
{
    var userName = await _userManager.GetUserNameAsync(user);
    var phoneNumber = await _userManager.GetPhoneNumberAsync(user);

    Username = userName;

    Input = new InputModel
    {
        PhoneNumber = phoneNumber,
        FirstName = user.FirstName,
        LastName = user.LastName
    };
}
#endregion

#region snippet_OnPostAsync
public async Task<IActionResult> OnPostAsync()
{
    var user = await _userManager.GetUserAsync(User);
    if (user == null)
    {
        return NotFound($"Unable to load user with ID '{_userManager.GetUserId(User)}'.");
    }

    if (!ModelState.IsValid)
    {
        await LoadAsync(user);
        return Page();
    }

    user.FirstName = Input.FirstName;
    user.LastName = Input.LastName;
    await _userManager.UpdateAsync(user);

    var phoneNumber = await _userManager.GetPhoneNumberAsync(user);
    if (Input.PhoneNumber != phoneNumber)
    {
        var setPhoneResult = await _userManager.SetPhoneNumberAsync(user, Input.PhoneNumber);
        if (!setPhoneResult.Succeeded)
        {
            StatusMessage = "Unexpected error when trying to set phone number.";
            return RedirectToPage();
        }
    }

    await _signInManager.RefreshSignInAsync(user);
    StatusMessage = "Your profile has been updated";
    return RedirectToPage();
}
#endregion

#region snippet_FirstAndLastNameInputModel
public class InputModel
{
    [Required]
    [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
    [Display(Name = "First name")]
    public string FirstName { get; set; }

    [Required]
    [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 1)]
    [Display(Name = "Last name")]
    public string LastName { get; set; }

    /// <summary>
    ///     This API supports the ASP.NET Core Identity default UI infrastructure and is not intended to be used
    ///     directly from your code. This API may change or be removed in future releases.
    /// </summary>
    [Phone]
    [Display(Name = "Phone number")]
    public string PhoneNumber { get; set; }
}
#endregion

#region snippet_OnGetAsync
public async Task<IActionResult> OnGetAsync()
{
    var user = await _userManager.GetUserAsync(User);
    if (user == null)
    {
        return NotFound($"Unable to load user with ID '{_userManager.GetUserId(User)}'.");
    }

    var userName = await _userManager.GetUserNameAsync(user);
    var email = await _userManager.GetEmailAsync(user);
    var phoneNumber = await _userManager.GetPhoneNumberAsync(user);

    Username = userName;

    Input = new InputModel
    {
        Email = email,
        PhoneNumber = phoneNumber,
        FirstName = user.FirstName,
        LastName = user.LastName,
    };

    IsEmailConfirmed = await _userManager.IsEmailConfirmedAsync(user);

    return Page();
}
#endregion

#region snippet_OnPostAsync
public async Task<IActionResult> OnPostAsync()
{
    if (!ModelState.IsValid)
    {
        return Page();
    }

    var user = await _userManager.GetUserAsync(User);
    if (user == null)
    {
        return NotFound($"Unable to load user with ID '{_userManager.GetUserId(User)}'.");
    }

    user.FirstName = Input.FirstName;
    user.LastName = Input.LastName;
    await _userManager.UpdateAsync(user);

    var email = await _userManager.GetEmailAsync(user);
    if (Input.Email != email)
    {
        var setEmailResult = await _userManager.SetEmailAsync(user, Input.Email);
        if (!setEmailResult.Succeeded)
        {
            var userId = await _userManager.GetUserIdAsync(user);
            throw new InvalidOperationException($"Unexpected error occurred setting email for user with ID '{userId}'.");
        }
    }

    var phoneNumber = await _userManager.GetPhoneNumberAsync(user);
    if (Input.PhoneNumber != phoneNumber)
    {
        var setPhoneResult = await _userManager.SetPhoneNumberAsync(user, Input.PhoneNumber);
        if (!setPhoneResult.Succeeded)
        {
            var userId = await _userManager.GetUserIdAsync(user);
            throw new InvalidOperationException($"Unexpected error occurred setting phone number for user with ID '{userId}'.");
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

    [Required]
    [EmailAddress]
    public string Email { get; set; }

    [Phone]
    [Display(Name = "Phone number")]
    public string PhoneNumber { get; set; }
}
#endregion

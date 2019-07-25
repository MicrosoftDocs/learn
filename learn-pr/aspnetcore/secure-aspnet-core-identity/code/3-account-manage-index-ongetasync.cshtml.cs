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

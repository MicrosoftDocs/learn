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

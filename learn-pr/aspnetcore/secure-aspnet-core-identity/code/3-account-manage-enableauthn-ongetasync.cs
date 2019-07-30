public async Task<IActionResult> OnGetAsync([FromServices] QrCodeService qrCodeService)
{
    var user = await _userManager.GetUserAsync(User);
    if (user == null)
    {
        return NotFound($"Unable to load user with ID '{_userManager.GetUserId(User)}'.");
    }

    await LoadSharedKeyAndQrCodeUriAsync(user);
    QrCodeAsBase64 = qrCodeService.GetQRCodeAsBase64(AuthenticatorUri);

    return Page();
}

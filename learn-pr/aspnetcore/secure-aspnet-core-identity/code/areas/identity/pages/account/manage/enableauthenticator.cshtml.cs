#region snippet_QrCodeAsBase64
public class EnableAuthenticatorModel : PageModel
{
    private readonly UserManager<RazorPagesPizzaUser> _userManager;
    private readonly ILogger<EnableAuthenticatorModel> _logger;
    private readonly UrlEncoder _urlEncoder;

    public string QrCodeAsBase64 { get; set; }    
#endregion

#region snippet_OnGetAsync
public async Task<IActionResult> OnGetAsync([FromServices] QRCodeService qrCodeService)
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
#endregion

#region snippet_GenerateQrCodeUri
private string GenerateQrCodeUri(string email, string unformattedKey)
{
    return string.Format(
        CultureInfo.InvariantCulture,
        AuthenticatorUriFormat,
        _urlEncoder.Encode("RazorPagesPizza"),
        _urlEncoder.Encode(email),
        unformattedKey);
}
#endregion
}
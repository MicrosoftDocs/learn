public class CouponService : ICouponService
{
    public readonly HttpClient _httpClient;
    private readonly UrlsConfig _urls;
    private readonly ILogger<CouponService> _logger;

    public CouponService(
        HttpClient httpClient,
        IOptions<UrlsConfig> config,
        ILogger<CouponService> logger)
    {
        _urls = config.Value;
        _httpClient = httpClient;
        _logger = logger;
    }

    // code omitted for brevity

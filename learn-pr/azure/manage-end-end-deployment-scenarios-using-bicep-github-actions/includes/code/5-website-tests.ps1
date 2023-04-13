param(
  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string] $HostName
)

Describe 'Toy Website' {

    It 'Serves pages over HTTPS' {
      $request = [System.Net.WebRequest]::Create("https://$HostName/")
      $request.AllowAutoRedirect = $false
      $request.GetResponse().StatusCode |
        Should -Be 200 -Because "the website requires HTTPS"
    }

    It 'Does not serves pages over HTTP' {
      $request = [System.Net.WebRequest]::Create("http://$HostName/")
      $request.AllowAutoRedirect = $false
      $request.GetResponse().StatusCode |
        Should -BeGreaterOrEqual 300 -Because "HTTP is not secure"
    }

    It 'Returns a success code from the health check endpoint' {
      $response = Invoke-WebRequest -Uri "https://$HostName/health" -SkipHttpErrorCheck
      Write-Host $response.Content
      $response.StatusCode |
        Should -Be 200 -Because "the website and configuration should be healthy"
    }

}

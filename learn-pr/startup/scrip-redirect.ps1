$oldFolderName = "startups"
ForEach ($moduleDirectory in Get-ChildItem -Directory) {
    $unitYamlFiles = Get-ChildItem $moduleDirectory -Filter *.yml
    $unitYamlFiles | % {
        $ymlName = $_.Name
        $mdName = $ymlName.Replace(".yml", ".md")
        $noExtensionName = $_.Name.Replace(".yml", "")
        $redirectLastSegment = "$noExtensionName"
        Write-Output "    {`n      ""source_path"": ""learn-pr/$($oldFolderName)/$($moduleDirectory.Name)/$mdName"",`n      ""redirect_url"": ""https://docs.microsoft.com/learn/modules/$($moduleDirectory.Name)/$redirectLastSegment"",`n      ""redirect_document_id"": true`n    },"
    }
}
$packageName = '{{PackageName}}'
#$url = 'http://www.cloudberrylab.com:80/download/CloudBerryExplorerSetup_v1.7.0.226Google.exe'
$url = '{{DownloadUrl}}'

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'CloudBerryExplorer.GoogleStorage.au3';

    $installerPackage = Join-Path $scriptDir "CloudBerryExplorer.GoogleStorage.exe";
    Get-ChocolateyWebFile $packageName $installerPackage $url;

    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw
}

# Generally found in $HOME\Documents\PowerShell

Set-Alias vim nvim.exe
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Invoke-Expression (&starship init powershell)

# Generally found in $HOME\Documents\PowerShell

Set-Alias vim nvim.exe
Set-Alias which where.exe
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
# Import-Module WebAdministration
Invoke-Expression (&starship init powershell)

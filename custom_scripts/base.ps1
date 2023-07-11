# Create a config file if it doesn't exists and set the config directory.
if (-not (Test-Path -Path $PROFILE)) {
	New-Item -Path $PROFILE -Type File -Force
	}
($PROFILE) -match "(.+?)Microsoft.PowerShell_profile.ps1"
$pwshconfig = $Matches[1]

# Set neovim config directory
$nvimconfig = "~\AppData\Local\nvim\"
if (-not (Test-Path -Path $nvimconfig)) {
	New-Item -Path ("$nvimconfig", "init.lua" -join "") -Type File -Force
	}

# $modules = @(
# "Get-ChildItemColor",
# ""
# )
# foreach ($module in $modules) {
# if (-not(Test-Path -Path ("$PSScriptRoot\", $module))) {
# Write-Host "Following packages are not found:`r" +
# $module
# # Install-Module $module -Scope CurrentUser
# }
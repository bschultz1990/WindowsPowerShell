$custom_scripts = Get-ChildItem -Path "$PSScriptRoot\custom_scripts" -Filter "*.ps1"
foreach ($script in $custom_scripts) {
	. $script.FullName
	}

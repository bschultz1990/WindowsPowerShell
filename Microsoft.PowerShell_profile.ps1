forEach ($file in (Get-Item "$PSScriptRoot/custom_scripts/*.ps1")) {
        . $file.FullName
}

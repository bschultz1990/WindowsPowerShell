#Set-PSDebug -Trace 1

forEach ($file in (Get-Item "$PSScriptRoot/custom_scripts/*.ps1")) {
        . $file.FullName
}

#Set-PSDebug -Trace 0

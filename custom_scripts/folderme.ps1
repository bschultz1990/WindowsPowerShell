function folderme {
    $ext_input = Read-Host "Enter file extension to look for starting with *.:"
    $ext = 
    $files = Get-ChildItem -Path .\ -Filter $ext -File

    $prefix = Read-Host "What is before your match?"
    $suffix = Read-Host "What is immediately after your match?"
    $regex = $prefix, "(.+?)", $suffix -join ""
    Write-Host "regex is: $regex"

    $prename = Read-Host "What would you like before your new folder name? (leave blank to skip)"
    $postname = Read-Host "How about after? (leave blank to skip)"

    foreach ($file in $files) {
        $fileName = $file.Name
        if ($fileName -match "$regex") {
            $digits = $Matches[1]
            $newFolderName = "$prename""$digits""$postname"
            $newFolderPath = Join-Path -Path .\ -ChildPath $newFolderName

            if (-not (Test-Path -Path $newFolderPath)) {
                New-Item -ItemType Directory -Path $newFolderPath | Out-Null
            }

            Move-Item -Path $file.FullName -Destination $newFolderPath
        }
    }
}

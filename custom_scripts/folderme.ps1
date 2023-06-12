function mm {
    param (
        [Parameter(Mandatory=$true,
        position=0)]
        [String]$new_folder
    )
    mkdir $new_folder
    mv *$new_folder*.pdf .\$new_folder\
    clear
    ls
}


function folderme {
    param (
        [Parameter(Mandatory=$true,
        position=0)]
        [String]$FolderPath
    )
    $ext_input = Read-Host "Enter file extension to look for:"
    $ext = "*.", $ext_input -join ""
    $files = Get-ChildItem -Path $FolderPath -Filter $ext -File

    $prefix = Read-Host "What is before your match?"
    $suffix = Read-Host "What is immediately after your match?"
    $regex = $prefix, "(.+?)", $suffix -join ""
    Write-Host "regex is: $regex"

    $prename = Read-Host "What would you like before your new folder name? (leave blank to skip)"
    $postname = Read-Host "How about after? (leave blank to skip)"

$uniqueMatches = @{}  # create hashtable to store unique matches

foreach ($file in $files) {
    $fileName = $file.Name
    if ($fileName -match "$regex") {
        $digits = $Matches[1]
        $newFolderName = "$prename", "$digits", "$postname" -join ""
        $newFolderPath = Join-Path -Path $FolderPath -ChildPath $newFolderName

        # check if folder name already exists in hashtable
        if ($uniqueMatches.ContainsKey($newFolderName)) {
            $newFolderPath = $uniqueMatches[$newFolderName]  # use existing folder path
        } else {
            # create new folder and add to hashtable
            if (-not (Test-Path -Path $newFolderPath)) {
                New-Item -ItemType Directory -Path $newFolderPath | Out-Null
            }
            $uniqueMatches[$newFolderName] = $newFolderPath
        }

        Move-Item -Path $file.FullName -Destination $newFolderPath
    }
}
}
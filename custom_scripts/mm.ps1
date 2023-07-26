function mm {
    param (
        [Parameter(Mandatory=$true,
        position=0)]
        [String]$new_folder
    )
    New-Item -ItemType Directory -Path $new_folder
    mv *$new_folder*.pdf .\$new_folder\
    ls
}

function find {
    param (
        [Parameter(Mandatory=$true, position=0)]
        [String]$file
    )
    # Get-ChildItem -Path . -Filter $file -Recurse
    Get-ChildItem -Path . -Include $file -Recurse
}

function finddocs {
    param (
        [Parameter(Mandatory=$true, position=0)]
        [String]$docnum
    )
    $appletonDocs = "https://vfc.sharepoint.com/sites/AppletonINLDocuments/_layouts/15/search.aspx/siteall?q="
    cd $international
    $docstring = $appletonDocs, $docnum -join ""
    start $docstring
    fd $docnum
}

function pdfme {
    param (
        
        [Parameter(Mandatory=$true, position=0)]
        [String]$path
    )

    $xlFixedFormat = "Microsoft.Office.Interop.Excel.xlFixedFormatType" -as [type]
    $excelFiles = Get-ChildItem -Path $path -include *.xls, *.xlsx -recurse
    $objExcel = New-Object -ComObject excel.application
    $objExcel.visible = $false
    foreach($wb in $excelFiles)
    {
        $fileName = $wb.BaseName -replace '\s','_' # Replace spaces with underscores
        $filepath = Join-Path -Path $path -ChildPath "$fileName.pdf"

        $workbook = $objExcel.workbooks.open($wb.fullname, 3)
        $workbook.Saved = $true
        Write-Host "Saving $filepath"
        try {
            $workbook.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, $filepath)
            if (-not (Test-Path -Path $filepath)) {
                Write-Warning "PDF file was not created: $filepath"
            }
        } catch {
            Write-Warning "Error exporting PDF file: $_"
        }
        $workbook.Close()
    }
    $objExcel.Quit()
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($workbook) | Out-Null
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject($objExcel) | Out-Null
}


function fileme {
    $ext = Read-Host "Enter file extension to filter by"

    foreach ($item in $locTable.Keys) {
        Write-Host "Moving the following files to $($locTable[$item])"
        ls *$item*.$ext
        mv *$item* $locTable[$item]
    }
}

#moveme
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


function folderme {
    $FolderPath = "."
    # $ext_input = Read-Host "Enter file extension to look for:"
    $ext = "*.", "pdf" -join ""
    $files = Get-ChildItem -Path $FolderPath -Filter $ext -File

    $prefix = Read-Host "What is before your match?"
    $suffix = Read-Host "What is immediately after your match?"
    $regex = $prefix, "(.+?)", $suffix -join ""
    # Write-Host "regex is: $regex"

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
        Write-Host $newFolderPath
            }
            $uniqueMatches[$newFolderName] = $newFolderPath
        }

        Move-Item -Path $file.FullName -Destination $newFolderPath
    }
}
}

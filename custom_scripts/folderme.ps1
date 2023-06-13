$locTable = @{
    "arezzo" = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\AREZZO"
    "forus" = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1005 Vans\Forus - Chile 10780157\Invoices\2023"
    "grimoldi" = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMOLDI-JUST US"
    "grimuru" = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMURU"
    "lotus" = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1034 Altra\Lotus Corp - Japan 10743817\Invoices\2023"
}

function ic {
    # Get all items
    # Filter by folder
    # For each dir in directories,
    # start $appletonINLurl($dir)
    }

function pdfme {
param (
    [Parameter(Mandatory=$true,
    position=0)]
    [String]$path
)

$xlFixedFormat = "Microsoft.Office.Interop.Excel.xlFixedFormatType" -as [type]
$excelFiles = Get-ChildItem -Path $path -include *.xls, *.xlsx -recurse
$objExcel = New-Object -ComObject excel.application
$objExcel.visible = $false
foreach($wb in $excelFiles)
{
#  $filepath = Join-Path -Path $path -ChildPath ($wb.BaseName+“.pdf”)
 $filepath = $path, ($wb.BaseName), ".pdf" -join ""

 $workbook = $objExcel.workbooks.open($wb.fullname, 3)
 $workbook.Saved = $true
Write-Host "saving $filepath"
 $workbook.ExportAsFixedFormat($xlFixedFormat::xlTypePDF, $filepath)
 $objExcel.Workbooks.close()
}
$objExcel.Quit()
}


function fileme {
    $ext = Read-Host "Enter file extension to filter by"

    foreach ($item in $locTable.Keys) {
        Write-Host "Moving the following files to $($locTable[$item])"
        ls *$item*.$ext
        mv *$item* $locTable[$item]
    }
}

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
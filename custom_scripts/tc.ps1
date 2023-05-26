function classify ($file) {
  # Exit if the path is not accessible:
  if (-not (Test-Path $classification_folder) -or -not ($file)) {
    return "Path does not exist or is not accessible. Exiting..."
  }
  $destination = $classification_folder
  Move-Item -Path $file -Destination $destination
  $file = $file.Substring(1)
  Set-Clipboard "$destination$file"
  Write-Host "Moved $file to $destination"
  Write-Host "Copied new path to clipboard."
}

function certify ($file) {
  # Exit if the path is not accessible:
  if (-not (Test-Path $certificates_dir) -or -not ($file)) {
    return "Path does not exist or is not accessible. Exiting..."
  }
  $folder = Read-Host "Enter a certificate folder to search for"
  if ((findme2 -file $folder -directory $global:certificates_dir -folder 1) -eq 1) {
    $destination = $global:find_selection
  }
  else {
    $newdir = "$global:certificates_dir", "\", "$folder" -join ""
    # Write-Host "Newdir will be $newdir"
    mkdir $newdir
    $destination = $newdir
  }
  # Write-Host "Destination is $destination"
  # Write-Host "Will move $file to $destination"
  $cleanfile = $file.Substring(1)
  $newdest = "$destination", "$cleanfile" -join ""
  # Write-Host "Newdest will be $newdest"

  Move-Item -Path $file -Destination $newdest
  Set-Clipboard $newdest
  Write-Host "Copied new path to clipboard."
}

function qualify ($file) {
  # Exit if the path is not accessible:
  if (-not (Test-Path $qualification_folder) -or -not ($file)) {
    return "Path does not exist or is not accessible. Exiting..."
  }
  # Move the file to the qualification folder:
  Move-Item -Path $file -Destination $qualification_folder

  # Take the dot off the $file name
  $file = $file.Substring(1)
  
  Set-Clipboard "$qualification_folder$file"
  Write-Host "Moved $file to $qualification_folder"
  Write-Host "Copied new path to clipboard."
}

function combine($file1, $file2) {
  speccheck
  $out_dir = $pwd
  $file1, $file2 | Merge-PDF -OutputPath $out_dir\$spec.pdf
  open $out_dir\$spec.pdf
}

function speccheck {
  $loc = Split-Path -Path (Get-Location) -Leaf
  $answer = Read-Host "Use $loc as your spec? (y/n)"
  if ($answer -eq "y") { 
    $global:spec = $loc 
    return $global:specresult = "y"
  }
  if ($answer -eq "n" -or (-not($spec))) { 
    setspec
    return $global:specresult = "n"
  }
}

function setspec($newspec) {
  if ($newspec) { $global:spec = "$newspec" }
  else { $global:spec = Read-Host "Enter a spec" }
  Write-Host $spec
}

function doccheck {
  $loc = Split-Path -Path (Get-Location) -Leaf
  $answer = Read-Host "Use $loc as your document? (y/n)"
  if ($answer -eq "y") {
    $global:doc = $loc
    return $global:docresult = "y"
  }
  if ($answer -eq "n" -or (-not($doc))) {
    setdoc
    return $global:docresult = "n"
  }
}

function setdoc {
  $global:doc = Read-Host "Title your document:"
  Write-Host $global:doc
}

function new {
  param(
    [switch]$certificate,
    [switch]$classification,
    [switch]$qualification,
    [switch]$quote
  )

  if ($quote) {
    # Get $doc from doccheck
    doccheck
    # Only create a folder if we've opted for a special name.
    if ($global:docresult -eq "n") {
      mkdir $global:doc
      cd $global:doc
    }

    $destination = (getdir), "\$global:doc", "Proforma,Packing,SLI", ".xlsx" -join ""
    Copy-Item -Path $global:invoice -Destination $destination 
    Write-Host "Remember to grab the original quote request from the CSR."
  }

  if ($certificate) {
    $folder = Read-Host "Enter a new certificate folder name. (e.g. Hologic)"
    $type = (Read-Host "What type of certificate is being generated? (e.g. USMCA, COO, AUSFTA)").ToUpper().Replace(' ', '')
    $year = Get-Date -Format "yyyy.MM.dd"
    $ext = ".xlsx"
    $global:certname = "$year $type $folder$ext"

    # Create a working folder.
    Write-Host "Creating working certificate folder $folder..."
    mkdir $folder
    cd $folder

    $destination = (getdir), "\$global:certname" -join ""
    Copy-Item -Path $global:certificate -Destination $destination
    Set-Clipboard (getdir)
    Set-ItemProperty "$global:certname" -Name LastWriteTime -Value (Get-Date)
    Write-Host "Remember to grab your CSR's original request sheet!"
    $global:foldercheck = "n"
    return
  }
  if ($classification) {
    speccheck
    Write-Host "Checking for existing spec $spec..."
    if ((findme2 -file $spec -directory $classification_folder) -eq 1) {
      Write-Host "Opening selection for review..."
      open $global:find_selection
      return
    }
    # Only make a new folder if we're working with a new spec:
    if ($global:specresult -eq "n") {
      $dirname = $global:spec.Split('\')[-1]
      mkdir $dirname
      cd $dirname
    }
    # Otherwise, assume we're in the directory we need and dump files in there:
    $destination = (getdir), "\", "$spec", ".xlsx" -join ""
    Copy-Item -Path $global:workbook -Destination $destination
    Write-Host "Workbook copied."

    $destination = (getdir), "\cover.xlsx" -join ""
    Copy-Item -Path "$global:coversheet" -Destination $destination
    Write-Host "Cover sheet copied."

    Set-Clipboard $spec
    Write-Host "Spec: $spec"
    Write-Host "Get your spec sheet from SMS and recipe from apack.biz"
    return
  }

  if ($qualification) {
    speccheck
    Write-Host "Checking for existing qualification $global:spec..."
    if ((findme -file $global:spec -directory $qualification_folder) -eq 1) {
      $global:qualicheck = "y"
      # $global:current_qual = $global:find_selection
      return
    }
    # Only make a new folder if we're working with a new spec:
    if ($global:specresult -eq "n") {
      $dirname = $global:spec.Split('\')[-1]
      mkdir $dirname
      cd $dirname
    }
    # Otherwise, assume we're in the directory we need and dump files in there:
    $destination = (getdir), "\", "$spec", ".xlsx" -join ""
    Copy-Item -Path $global:workbook -Destination $destination
    Set-Clipboard $spec
    # Write-Host "Remember to grab your spec from SMS and recipe from apack.biz."
  }
}

function recipe {
  param ( [Parameter(Mandatory = $true)] [string]$spec )
  Set-Clipboard $spec
  start "http://reports.apack.biz/ReportServer/Pages/ReportViewer.aspx?/SMS/Technical+Specification+Materials+Report+(ERC-907)&rs:Command=Render"
  Write-Host "Spec copied!"
}

function info($file) {
  if ($file) {
    $name = Split-Path $file -Leaf
    $extension = [System.IO.Path]::GetExtension($file)
    Write-Host "Name: $name"
    Write-Host "Extension: $extension"
  }
}

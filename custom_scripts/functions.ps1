

# $trash_folder = "~/Documents/trash"
# if (-not(Test-Path "$trash_folder")) {
# 	mkdir "$trash_folder"
# 	Write-Host "Trash folder created at: $trash_folder"
# }

# function trash ($file) {
#   Move-Item -Path $file -Destination $trash_folder -Force
# }

# function trashempty {
#   Remove-Item -Path $trash_folder\*
#   Write-Host "Trash emptied."
# }

# function trashview {
#   $back = $PWD
#   cd $trash_folder
#   ls
# }

function fzo {
        start $(fzf)
}

function fzd {
        $regex = ".*(?=\\)"
        $dir = findstr $regex $(fzf)
        cd $dir
        }

function rename ($file) {
	$destination = Read-Host "Enter a new name:"
	Rename-Item -Path "$file" -NewName "$destination"
	}

function cwd {
	Set-Clipboard (getdir)
	}

function unzip ($file, $folder) {
	if (!$file){ $file = Read-Host "Enter zip file name" }
	if (!$folder){ $folder = Read-Host "Enter folder name" }

	Expand-Archive -Path "$file" -DestinationPath $pwd\$folder
	trash $file
	c $folder
	}

function c ($dir) {
	cd $dir 
	ls
	}

function reload {
	. "$PROFILE"
	}

function npp {
	start "C:\Users\319427\Apps\npp.8.5.portable.x64\notepad++.exe"
	}

#Only display the last two directories in the prompt
function Prompt {
  # "$(getdir)`r`n> "
  # "$(Split-Path -Path (Get-Location) -Leaf)`r`n> "
  return "$pwd`r`n> "
}

function f {
  Set-Location "$(find . -type d | fzf)"
}

function findme2 {
  param (
    [string]$file,
    [string]$directory,
    [string]$folder
  )
  if (-not (Test-Path "$directory") -or -not ("$file")) {
    return "Please provide a valid file and directory to search for."
  }
  # Assume we're finding folder names
  $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -Directory

  # ..unless the user omits the folder flag ;)
  if (! $folder) {
    $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -File
  }

  if ($filematches.Count -gt 0) {
    $results = @()
    Write-Host "Partial matches found:"
    foreach ($match in $filematches) {
      $results += $match.FullName
    }
    for ($i = 0; $i -lt $results.Length; $i++) {
      Write-Host "$i $($results[$i])"
    }
    [int]$index = Read-Host "select"
    $global:find_selection = $results[$index]
    Set-Clipboard $results[$index]
    return 1
  }
  return 0
}
function findme {
  param (
    [string]$file,
    [string]$directory
  )
  if (-not (Test-Path "$directory") -or -not ("$file")) {
    return "Please provide a valid file and directory to search for."
  }
  $filematches = Get-ChildItem -Path "$directory" -Filter "*$file*" -File
  if ($filematches.Count -gt 0) {
    Write-Host "Partial matches found:"
    foreach ($match in $filematches) {
      Write-Host $match.FullName
    }
    return 1
  }
  return 0
}

function getdir {
  Set-Clipboard $pwd
  $full_path = Get-Clipboard
  $prefix = "Microsoft.PowerShell.Core\FileSystem::"
  return $full_path.Replace($prefix, "")
}

function getpath($file) {
  if (!$file) {
    Write-Host "Error: No source file provided."
    return
  }
  $dir = (Get-Item $file).DirectoryName
  $file = (Get-Item $file).Name
  $path = Join-Path $dir $file
  Set-Clipboard $path
}

function man($cmd) {
  Get-Help $cmd -full
}

function open ($file) {
  Invoke-Item $file
}

function mv($file, $destination) {
  Move-Item -Path $file -Destination $destination
}

function touch($file) {
  "" | Out-File $file -Encoding ASCII
}

function mkdir ($dir) {
if (-not (Test-Path -Path $PROFILE)) {
	New-Item -Path $PROFILE -Type File -Force
	}
}


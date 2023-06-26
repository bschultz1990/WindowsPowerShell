$trash_folder = "~/Documents/trash"
if (-not(Test-Path "$trash_folder")) {
	mkdir "$trash_folder"
	Write-Host "Trash folder created at: $trash_folder"
}

function trash ($file) {
  Move-Item -Path $file -Destination $trash_folder -Force
}

function trashempty {
  Remove-Item -Path $trash_folder\*
  Write-Host "Trash emptied."
}

function trashview {
  $back = $PWD
  cd $trash_folder
  ls
}


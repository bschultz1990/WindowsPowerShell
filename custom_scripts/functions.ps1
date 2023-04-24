function man($cmd) {
    Get-Help $cmd -full
}

function open ($file){
	Invoke-Item $file
}

function mv($file, $destination) {
	Move-Item -Path $file -Destination $destination
}

function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

function mkdir ($dir) {
	New-Item -ItemType Directory -Path $dir -Force
}

function trash ($file) {
	Move-Item -Path $file -Destination $trash_folder -Force
}

function trash-empty {
    Remove-Item -Path $trash_folder\*
	Write-Host "Trash emptied."
}

function trash-view {
	$back = $PWD
	cd $trash_folder
	ls
}
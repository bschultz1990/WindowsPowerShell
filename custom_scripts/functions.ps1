#Only display the last two directories in the prompt
function prompt {
	Write-Host (Split-Path -Path (Get-Location) -Leaf)">"
}

function rename($file) {
	$newname = Read-Host "Enter new file name:"
	Rename-Item -Path $file -NewName $newname
	Write-Host "Renamed to $newname"
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
	Write-Host "Copied $path to clipboard"
}

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
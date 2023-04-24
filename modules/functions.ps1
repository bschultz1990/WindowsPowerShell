
function mkdir($dir) {
	New-Item $dir -ItemType Directory
}

function rmdir ($dir) {
  Remove-Item $dir -Recurse
}

function touch($file) {
	New-Item $file -ItemType File
}
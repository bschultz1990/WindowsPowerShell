function strip ($file) {
  if (-not $file) { return "Please provide a file name." }
  if ([System.IO.Path]::GetExtension($file) -ne '.pdf') {
    return "Please provide a pdf file."
  }
  if (-not (Test-Path -Path backup)) {
    mkdir backup
  }
  cpdf $file -o out.pdf
  Move-Item $file backup
  Rename-Item -Path out.pdf -NewName $file
}

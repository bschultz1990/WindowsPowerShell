function strip ($file) {
  if (-not $file) { return "Please provide a file name." }
  if ([System.IO.Path]::GetExtension($file) -ne '.pdf') {
    return "Please provide a pdf file."
  }
  pdftk $file cat output out.pdf
  rm $file
  Rename-Item -Path out.pdf -NewName $file
}

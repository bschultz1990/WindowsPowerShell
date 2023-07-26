function strip ($file) {
  if (-not $file) { return "Please provide a file name." }
  pdftk $file cat output out.pdf
  rm $file
  Rename-Item -Path out.pdf -NewName $file
}

function cc {
  $filecounter = 0
  ls $dl
  foreach ($file in (Get-ChildItem $dl)){
    $filecounter += 1
  }
  Write-Host
  Write-Host $filecounter "files"
  $response = Read-Host "Continue? [y, n]"
  while ($response.ToLower() -notin @('y', 'n')) {
    $response = Read-Host "Correct responses are either 'y' or 'n': "
  }
  if ($response.ToLower() -eq "y") {
    rm *.pdf
    python "C:\Users\bschul3\OneDrive - VFC Corp\Documents\international_invoices.py"
    mv $dl/*stamped* .
    rm $dl/*.pdf
    ls $dl
  }
  else {
    return
  }
}
